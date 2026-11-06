# Anatomy and complex-prop quality

Use this checklist for animals, anthropomorphic characters, action poses, vehicles, tools, furniture, and outdoor equipment.

## Prompt contract

Declare exact topology rather than saying only “correct anatomy.” For a four-legged animal used anthropomorphically:

```text
Exactly four limbs total: two forelegs ending in two front paws, and two hind legs ending in two hind paws.
No extra, duplicated, detached, or fused paws. Each visible limb must connect to its correct shoulder or hip plane.
Exactly one tail and two ears.
```

Add pose-specific visibility: which limbs are visible, occluded, holding a prop, planted, or raised. Hidden limbs may remain hidden; do not ask the model to expose all four when the pose naturally occludes one.

## Limb-like props

- Set an exact maximum for poles, utensils, cables, handles, and thin furniture legs.
- Separate props from limbs by color, material, thickness, and attachment point.
- Prefer one hiking pole over two when pose readability matters.
- For vehicles, state wheel count and topology explicitly; verify handlebars, pedals, frame, and basket separately.
- Avoid several thin props crossing paws or the torso when the same joke works with one prop.

## No-text audit

Create a contact sheet before typography, then inspect uncertain assets at full size.

For each character, trace:

1. left foreleg from shoulder to paw;
2. right foreleg from shoulder to paw;
3. left hind leg from hip to paw;
4. right hind leg from hip to paw;
5. tail from root to tip;
6. both ears from head attachment to tip.

Reject when any trace terminates ambiguously, merges with another limb, appears twice, or connects to a prop. Do not hide a known defect under captions or cropping.

## Marking and identity audit

- Check color boundaries on every visible anatomical plane, not only the face.
- Reconfirm tail root, tail tip, rump patch, paws, ear bases, and forehead blaze.
- Keep previously corrected errors as explicit negative invariants in every prompt.

## Set-level audit

- Compare all assets in one overview for body mass, head ratio, material, lighting, and palette drift.
- Require distinct action silhouettes; captions must not be the only difference.
- Add text only after all no-text masters pass.
- After export, verify one-to-one filenames, alpha channel, dimensions, and readability at 240 px and 120 px.
