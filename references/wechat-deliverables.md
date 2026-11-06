# WeChat deliverables

Platform rules can change. Verify the logged-in current submission interface immediately before final delivery and use it as the final authority. Use the stricter limit when secondary sources disagree. Last research pass: 2026-08-26; the public official site was reachable only as a landing/login target and its help content was not machine-readable, so the donation limits below use conservative values consistently reported by current submission guides.

## Default production targets

| Asset | Default target | Conservative size limit | Notes |
| --- | --- | --- | --- |
| Main stickers | 240×240 GIF, 8/16/24 | 500 KB each | Keep the whole set static or the whole set animated |
| Album thumbnails | 120×120 PNG | 50 KB each | Match every main sticker one-to-one |
| Cover | 240×240 transparent PNG | 80 KB | Recognizable half/full body, little empty space, avoid text |
| Chat-panel icon | 50×50 transparent PNG | 30 KB | Prefer a simple frontal head or signature silhouette |
| Detail banner | 750×400 JPG/PNG | 80 KB | No text; vivid non-white opaque background; tell a small story |
| Donation guide image | 750×560 PNG/GIF | 100 KB | Optional unless donations are enabled; 1 image; opaque, lively background |
| Donation thank-you image | 750×750 PNG/GIF | 200 KB | Optional unless donations are enabled; 1 image; opaque thank-you scene |

If the active platform permits a larger file, keep the conservative file when quality remains acceptable.

## Naming

```text
main-240/01.gif ... 16.gif
thumb-120/01.png ... 16.png
package-assets/cover.png
package-assets/chat-icon.png
package-assets/detail-banner-750x400.jpg
package-assets/donation-guide-750x560.png
package-assets/donation-thanks-750x750.png
```

## Donation/appreciation assets

Create both assets when the creator enables the platform's appreciation feature.

### Guide image

- Export exactly 750×560 pixels as PNG or GIF; target no more than 100 KB.
- Use one image matching the submitted IP and sticker style.
- Make the emotional request readable from the pose before relying on copy.
- Use a lively opaque background that contrasts with WeChat's light interface. Avoid white, near-white, and transparent backgrounds or edges.
- Do not include unrelated characters, products, logos, QR codes, payment amounts, contact information, or off-theme promotional content.
- Do not stretch or squash the character or reuse a differently proportioned crop.

### Thank-you image

- Export exactly 750×750 pixels as PNG or GIF; target no more than 200 KB.
- Show one sincere, celebratory, or humorous thank-you beat after appreciation is sent.
- Keep the same IP, material, palette, and background language as the guide image, but use a distinct pose and composition.
- Use an opaque non-white background and avoid unrelated content or geometric distortion.

### Guide copy

- When the upload form requests an appreciation guide sentence, draft 5–15 Chinese characters unless the live interface states another range.
- Keep it strongly tied to the IP voice and sticker theme. Avoid pressure, guaranteed rewards, financial claims, external links, and instructions to contact or pay outside WeChat.
- Typeset exact copy deterministically when copy belongs inside an image; never trust generated Chinese text.

### Validation

- Check exact pixel dimensions, format, file size, and opaque corner pixels.
- Preview on white and light-gray backgrounds; the image boundary must remain visible.
- Inspect for unintended transparency, pale edge blending, compression artifacts, distorted proportions, cropped faces, and illegible copy.
- If the logged-in platform shows different limits, update this reference and obey the live interface before packaging.

## Visual review

- Inspect transparency on white, black, and mid-gray backgrounds.
- Ensure no chroma fringe remains around fur, hair, ears, tails, or thin limbs.
- Read every caption at 240×240 without zooming.
- Check that no text or important facial feature is clipped.
- Keep visual style, lighting, scale, and outline treatment consistent.
- Use a textless banner. Avoid white or transparent banner backgrounds.

## Static and animated sets

- Export static masters as single-frame GIF only when the platform requires GIF.
- For animation, use permanent looping and consistent frame cadence.
- Do not mix animated and static main assets in one set unless the current platform explicitly permits it.

## Final package

Include:

- main sticker directory
- thumbnail directory
- cover, icon, and banner
- donation guide and donation thank-you images when appreciation is enabled
- overview/contact sheet
- high-resolution transparent masters
- caption/action mapping
- upload ZIP

## Research sources

- Official platform entry point: https://sticker.weixin.qq.com/
- Current 2026 submission workflow cross-check: https://www.kakameme.com/zh/blog/wechat-sticker-store-submission
- Detailed donation asset constraints cross-check: https://gif.cdlchd.com/xwzx/6787.html

Treat secondary sources as corroboration only. Recheck the authenticated official upload form at submission time.
