---
name: create-ip-sticker-pack
description: Build a consistent original IP character and a WeChat-ready sticker pack from reference photos or images of a person, animal, object, or product. Use when the user asks to extract identity features, explore multiple IP concept styles, correct likeness or markings, select and formalize a character direction, create static sticker expressions or themed meme packs, preserve animal markings or limb anatomy, produce covers/icons/detail banners/donation images, or export and validate a complete WeChat sticker submission package.
---

# Create an IP Sticker Pack

Turn reference images into a reusable character system, then produce a coherent sticker set and submission assets. Preserve identity before optimizing cuteness or style.

## Required companion skill

Read and use the installed `imagegen` skill before generating or editing any raster visual. Use its built-in image-generation path by default and follow its transparency workflow. Keep deterministic typography and export work in the bundled scripts below.

## Workflow

### 1. Establish the project and inputs

- Inspect every reference image before generating.
- Label each input as identity reference, marking/detail reference, pose reference, style reference, or edit target.
- Correct orientation for analysis when needed; preserve originals.
- Create a versioned project folder. Never overwrite an approved round.
- Use this default structure:

```text
output/ip-name/
├── identity/
├── concepts/round-01/
├── model-sheet/
├── stickers/raw/
├── stickers/masters-no-text/
├── stickers/masters-text/
├── stickers/main-240/
├── stickers/thumb-120/
└── stickers/package-assets/
    ├── cover.png
    ├── chat-icon.png
    ├── detail-banner-750x400.png
    ├── donation-guide-750x560.png
    └── donation-thanks-750x750.png
```

### 2. Build an identity anchor

- Extract silhouette, proportions, face/head geometry, eyes, ears or handles, surface/color topology, body shape, appendages, and one to three recognition-critical traits.
- Record negative invariants: features that must not appear or must not change.
- For patterned animals or objects, describe markings as a topology map: origin, direction, boundary, asymmetry, and which planes they cross.
- Create an identity anchor sheet before broad style exploration when likeness is important.
- If the user says the likeness, expression, or marking is wrong twice, stop style iteration and rebuild the identity anchor from all references.
- Read [references/identity-consistency.md](references/identity-consistency.md) for the full extraction and review checklist.

### 3. Explore concept directions

- Diagnose the reference image before proposing styles. Score its silhouette, apparent material, emotional temperature, visual complexity, color tendency, age coding, and narrative cues; separate identity evidence from styling already present in the image.
- Route the subject into two or three compatible original style families, then explain each match using visible evidence from the reference. Do not infer personality from protected attributes or demographic appearance.
- When the user asks the skill to choose automatically, use the highest-fit family as the lead direction and one meaningfully different runner-up. When evidence is weak or contradictory, prefer identity-safe neutral directions instead of forcing a thematic match.
- Generate three or four clearly different directions while keeping the same identity, view, framing, and approximate pose.
- During exploration, combine style axes when needed to create meaningfully distinct directions. After selection, revise one axis at a time: proportion, material, emotional temperature, or degree of abstraction.
- Use descriptive design language rather than imitating a living artist, named studio, or existing collectible IP.
- Treat the style families as design ingredients, not named-character replicas. Never copy a signature face, teeth pattern, headpiece, hairstyle, costume, logo, or other source-IP identifier.
- Present a labeled overview and a short comparison of silhouette, expression system, production potential, and identity fidelity.
- When the user wants staged collaboration, wait for them to select a direction before building the full pack. When they request end-to-end completion or authorize automatic selection, choose the highest-fit direction, continue, and preserve the alternatives for review. Still ask when identity evidence is insufficient or competing directions would materially change the result.
- Read [references/style-routing.md](references/style-routing.md) whenever style should be inferred or recommended from reference images.
- Read [references/prompt-recipes.md](references/prompt-recipes.md) for concept and identity prompt scaffolds.

### 4. Formalize the selected IP

- Create a canonical model sheet with front, three-quarter, profile, and back views when practical.
- Lock the face/head ratio, body ratio, palette, materials, marking topology, tail/limb design, and neutral expression.
- Define a compact expression grammar: eye states, ear/eyebrow states, mouth limits, body deformation limits, and forbidden changes.
- Keep identity-critical traits stable even when the body is exaggerated.

- Persist the selected identity in `identity/character-spec.yaml`, its approved reference image, and `identity/corrections.md`. Read [references/character-record.md](references/character-record.md) when establishing or continuing a character. Resolve conflicts in this order: latest user correction, approved character specification, approved master, other references. Never silently replace an approved design.

### 5. Plan the sticker set

- Default to 16 expressions unless the user specifies 8 or 24.
- When the user asks for “another set” or a new theme after approving an earlier pack, inherit the previous pack's count, IP direction, typography, export sizes, and character invariants unless they request a change.
- For a themed pack, define a compact visual system before generation: recurring environment palette, one primary prop family, one action and one emotional verb per sticker, and distinct silhouettes across the set.
- Balance utility and personality: greetings, acknowledgement, agreement, thanks, apology, laughter, confusion, refusal, waiting, encouragement, fatigue, sleep, and departure.
- Assign one readable action and one emotional verb to every sticker. Record the incoming-message scenario that would trigger it and how its silhouette differs from the rest. Avoid near-duplicate poses with only different captions.
- If the user asks for current memes or hot phrases, browse current sources before writing copy. Prefer short, chat-usable Chinese; avoid direct film/TV lines, lyrics, slogans tied to another IP, gambling/violent references, and phrases likely to fail review.
- Generate textless masters first. Add exact text deterministically after the masters pass the visual quality review below. Treat this as an internal quality gate unless the user requested staged approval or the intended copy is ambiguous.
- Read [references/caption-design.md](references/caption-design.md) when captions or memes are requested.

- Before expanding a new character into a full set, internally review three representative masters: neutral/front view, large body motion, and strong emotion with a prop when props are planned. Reuse suitable existing approved samples; do not add unnecessary images. Continue automatically after they pass unless likeness is uncertain or staged approval was requested.

### 6. Generate consistent masters

- Use the identity anchor, selected concept, and at most three pose/detail references per call; built-in image generation accepts at most five reference paths total.
- Generate one distinct asset per call for best control.
- Repeat invariants in every prompt: identity, proportions, marking topology, material, palette, and forbidden changes.
- For animals or anthropomorphic characters, state the full appendage topology in every prompt: exact number of forelimbs/front paws, hind limbs/hind paws, ears, tails, wings, horns, or handles. Require each visible appendage to connect to the correct body plane.
- Limit limb-like props such as walking sticks, utensils, cables, chair legs, and handlebars. State their exact count and make them visually distinct from limbs.
- When a marking error has already been corrected, repeat it as a negative invariant in every later themed-pack prompt. Example: “one tail, solid ginger-orange from root to tip; no white tip and no stripes.”
- Ask the model for no text. Do not trust generated Chinese typography.
- For transparent stickers, generate on a uniform removable chroma background and use the transparency method in the `imagegen` skill.
- Keep a generous safe margin and avoid cast shadows unless the chosen submission style explicitly needs them.
- Make abstract humor through pose, deformation, timing, and deadpan contrast—not through identity drift or random props.

### 7. Review before typography

Reject or regenerate an asset if any answer is no:

- Does the silhouette still read as the selected IP at thumbnail size?
- Are face/head proportions and recognition-critical markings correct?
- Is the action understandable without the caption?
- Are limbs, paws/hands, ears, tails, and duplicated parts anatomically plausible for the chosen abstraction?
- Is the subject fully inside the safe area?
- Does it use the same material, lighting, and rendering language as the set?

Check the set at 120 px and 240 px on both light and dark backgrounds: expressions should remain distinct without captions, and the final captions and edges must remain readable. Compare similar utility stickers (such as acknowledgement and agreement) for distinct chat scenarios and gestures.

Create a no-text contact sheet before adding captions. Audit every asset at both overview and full size. Reject and regenerate any image with an extra, missing, duplicated, detached, or fused limb/paw; an extra tail or ear; a prop mistaken for an appendage; or an identity-critical marking error. Do not rely on prompt compliance alone.

Read [references/anatomy-prop-quality.md](references/anatomy-prop-quality.md) for the appendage audit and complex-prop checklist.

### 8. Add exact captions

- Prepare a UTF-8 TSV with `filename`, `caption`, and optional rotation degrees. Encode line breaks as `\n`.
- Run:

```bash
swift scripts/compose_text.swift \
  stickers/masters-no-text captions.tsv stickers/masters-text
```

- Use short captions with high contrast. Test on light and dark backgrounds at 240 px.
- Prefer a rounded Chinese display face for friendly toy/sticker packs, with a bold system fallback. Patch the script only when the selected IP needs a sharper or more formal voice.
- Patch the script's palette constants when the selected IP needs another brand color; keep the white outer rim and dark inner outline for accessibility.

### 9. Create package assets

- Make the cover and chat icon from the most recognizable neutral or signature pose.
- Make the detail banner as a textless 750×400 story scene on a vivid non-white, non-transparent background.
- When the creator enables appreciation/donations, create both the donation guide image and donation thank-you image. Treat them as a paired micro-story rather than resized duplicates.
- Use an opaque, lively background clearly separated from WeChat's light interface. Keep the IP, style, and subject matter consistent with the submitted sticker set; avoid unrelated promotional content, transparent/white backgrounds, and stretched artwork.
- Keep essential faces, gestures, and any short embedded copy inside conservative safe areas because platform presentation may crop or overlay controls.
- Keep all faces and recognition-critical details away from crop edges.
- Use image generation for the banner, then resize and compress deterministically.
- Read [references/wechat-deliverables.md](references/wechat-deliverables.md) before export. It includes the donation-guide and donation-thanks specifications. Verify the logged-in live upload interface immediately before submission.

### 10. Export and validate

- Name master files with numeric prefixes such as `01-hello.png`.
- Run:

```bash
bash scripts/export_wechat_pack.sh stickers/masters-text stickers
```

- Review the generated overview at actual size.
- Verify counts, dimensions, transparency, file sizes, unique contiguous numbering, and one-to-one main/thumbnail mapping. The exporter uses a fresh staging directory, preserves aspect ratio, and publishes only after checks pass. Existing published export folders are not overwritten: choose a new versioned output folder.
- Inspect GIF transparency edges visually on light/dark backgrounds; alpha presence alone cannot prove edge quality. Export script limits are conservative local presets, not proof of current platform acceptance; verify current platform requirements before delivery. Save the visual audit findings alongside the caption map.
- Validate donation assets separately: exact dimensions, PNG/GIF format, opaque corners, conservative file-size target, visual continuity, and no geometric distortion.
- Deliver the overview, editable/high-resolution masters, upload ZIP, caption map, and any generated source prompts.

## Quality gates

- **Identity gate:** validate the anchor before concept breadth; request user approval only when likeness remains uncertain or staged collaboration was requested.
- **Selection gate:** obtain a user-selected direction for staged collaboration; for end-to-end work, select the highest-fit direction and disclose the choice.
- **Set gate:** request approval of representative key poses only when identity remains uncertain or the user requested staged approval.
- **Typography gate:** add copy only after textless masters pass internal visual review; ask the user when the intended wording is ambiguous.
- **Submission gate:** validate current platform rules immediately before delivery.

## Working style

- Show visual rounds rather than describing unseen concepts.
- Make targeted single-variable revisions after feedback.
- Preserve user-approved assets and create versioned siblings.
- Report which features were corrected and which files changed.
- Cite web sources whenever current memes or platform rules are researched.
