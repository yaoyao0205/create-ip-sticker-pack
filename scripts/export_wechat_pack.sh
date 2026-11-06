#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: export_wechat_pack.sh MASTERS_PNG_DIR OUTPUT_DIR" >&2
  exit 2
fi

masters_dir=$1
output_dir=$2
main_dir="$output_dir/main-240"
thumb_dir="$output_dir/thumb-120"

for command_name in ffmpeg ffprobe zip; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Missing required command: $command_name" >&2
    exit 2
  fi
done

mkdir -p "$output_dir"
for published in main-240 thumb-120 overview.png wechat-upload-kit.zip; do
  if [[ -e "$output_dir/$published" ]]; then
    echo "Existing export: $output_dir/$published; choose a new versioned output directory." >&2
    exit 2
  fi
done
stage_dir=$(mktemp -d "$output_dir/.export-XXXXXX")
trap 'rm -rf "$stage_dir"' EXIT
main_dir="$stage_dir/main-240"
thumb_dir="$stage_dir/thumb-120"
mkdir -p "$main_dir" "$thumb_dir"

old_ifs=$IFS
IFS=$'\n'
files=($(find "$masters_dir" -maxdepth 1 -type f -name '*.png' | sort))
IFS=$old_ifs

count=${#files[@]}
if [[ $count -eq 0 ]]; then
  echo "No PNG masters found in $masters_dir" >&2
  exit 2
fi

case $count in
  8|16|24) ;;
  *) echo "Expected 8, 16, or 24 masters; got $count." >&2; exit 2 ;;
esac

expected=1
for src in "${files[@]}"; do
  base=$(basename "$src")
  number=$(printf '%s' "$base" | sed -E 's/^([0-9][0-9]).*/\1/')
  if [[ ! $number =~ ^[0-9][0-9]$ ]]; then
    echo "Master must start with a two-digit index: $base" >&2
    exit 2
  fi

  wanted=$(printf '%02d' "$expected")
  [[ "$number" == "$wanted" ]] || { echo "Expected unique contiguous index $wanted, got $base" >&2; exit 2; }
  expected=$((expected + 1))
  ffmpeg -hide_banner -loglevel error -y -i "$src" \
    -vf "scale=240:240:force_original_aspect_ratio=decrease:flags=lanczos,format=rgba,pad=240:240:(ow-iw)/2:(oh-ih)/2:color=0x00000000" -gifflags -offsetting "$main_dir/$number.gif"
  ffmpeg -hide_banner -loglevel error -y -i "$src" \
    -vf "scale=120:120:force_original_aspect_ratio=decrease:flags=lanczos,format=rgba,pad=120:120:(ow-iw)/2:(oh-ih)/2:color=0x00000000" -frames:v 1 "$thumb_dir/$number.png"
done

dimension_errors=0
size_errors=0

for file in "$main_dir"/*.gif; do
  dimensions=$(ffprobe -v error -select_streams v:0 \
    -show_entries stream=width,height -of csv=p=0:s=x "$file")
  bytes=$(wc -c < "$file" | tr -d ' ')
  [[ $dimensions == "240x240" ]] || { echo "Bad main dimensions: $file ($dimensions)" >&2; dimension_errors=$((dimension_errors + 1)); }
  [[ $bytes -le 512000 ]] || { echo "Main over 500 KB: $file ($bytes bytes)" >&2; size_errors=$((size_errors + 1)); }
done

for file in "$thumb_dir"/*.png; do
  dimensions=$(ffprobe -v error -select_streams v:0 \
    -show_entries stream=width,height -of csv=p=0:s=x "$file")
  bytes=$(wc -c < "$file" | tr -d ' ')
  [[ $dimensions == "120x120" ]] || { echo "Bad thumbnail dimensions: $file ($dimensions)" >&2; dimension_errors=$((dimension_errors + 1)); }
  [[ $bytes -le 51200 ]] || { echo "Thumbnail over 50 KB: $file ($bytes bytes)" >&2; size_errors=$((size_errors + 1)); }
done

package_dir="$output_dir/package-assets"
if [[ -d "$package_dir" ]]; then
  donation_guide="$package_dir/donation-guide-750x560.png"
  donation_guide_gif="$package_dir/donation-guide-750x560.gif"
  donation_thanks="$package_dir/donation-thanks-750x750.png"
  donation_thanks_gif="$package_dir/donation-thanks-750x750.gif"

  for file in "$donation_guide" "$donation_guide_gif"; do
    [[ -f "$file" ]] || continue
    dimensions=$(ffprobe -v error -select_streams v:0 \
      -show_entries stream=width,height -of csv=p=0:s=x "$file")
    bytes=$(wc -c < "$file" | tr -d ' ')
    [[ $dimensions == "750x560" ]] || { echo "Bad donation guide dimensions: $file ($dimensions)" >&2; dimension_errors=$((dimension_errors + 1)); }
    [[ $bytes -le 102400 ]] || { echo "Donation guide over conservative 100 KB target: $file ($bytes bytes)" >&2; size_errors=$((size_errors + 1)); }
  done

  for file in "$donation_thanks" "$donation_thanks_gif"; do
    [[ -f "$file" ]] || continue
    dimensions=$(ffprobe -v error -select_streams v:0 \
      -show_entries stream=width,height -of csv=p=0:s=x "$file")
    bytes=$(wc -c < "$file" | tr -d ' ')
    [[ $dimensions == "750x750" ]] || { echo "Bad donation thanks dimensions: $file ($dimensions)" >&2; dimension_errors=$((dimension_errors + 1)); }
    [[ $bytes -le 204800 ]] || { echo "Donation thanks over conservative 200 KB target: $file ($bytes bytes)" >&2; size_errors=$((size_errors + 1)); }
  done
fi

if [[ $dimension_errors -ne 0 || $size_errors -ne 0 ]]; then
  echo "Validation failed; no upload ZIP published." >&2
  exit 1
fi
rows=$(( (count + 3) / 4 ))
ffmpeg -hide_banner -loglevel error -y -framerate 1 -pattern_type glob -i "$masters_dir/*.png" \
  -vf "scale=250:250:force_original_aspect_ratio=decrease:flags=lanczos,pad=250:250:(ow-iw)/2:(oh-ih)/2:color=0xf3f0ea,tile=4x${rows}:padding=0:margin=0:color=0xf3f0ea" \
  -frames:v 1 "$stage_dir/overview.png"

if [[ -d "$package_dir" ]]; then cp -R "$package_dir" "$stage_dir/package-assets"; fi
(
  cd "$stage_dir"
  rm -f wechat-upload-kit.zip
  zip -qr wechat-upload-kit.zip main-240 thumb-120 overview.png
  if [[ -d package-assets ]]; then zip -qr wechat-upload-kit.zip package-assets; fi

)

mv "$main_dir" "$output_dir/main-240"
mv "$thumb_dir" "$output_dir/thumb-120"
mv "$stage_dir/overview.png" "$output_dir/overview.png"
mv "$stage_dir/wechat-upload-kit.zip" "$output_dir/wechat-upload-kit.zip"
echo "count=$count dimension_errors=$dimension_errors size_errors=$size_errors"
echo "overview=$output_dir/overview.png"
echo "zip=$output_dir/wechat-upload-kit.zip"

if [[ $dimension_errors -ne 0 || $size_errors -ne 0 ]]; then
  exit 1
fi
