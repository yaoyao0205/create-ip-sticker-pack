# Prompt recipes

Replace bracketed fields. Label every input image by role.

## Identity anchor

```text
Use case: stylized-concept
Asset type: IP identity anchor sheet
Primary request: Build a faithful identity reference from the supplied [person/animal/object] photos before stylization.
Input images: Image 1 [role]; Image 2 [role]; Image 3 [role].
Subject invariants: [silhouette], [geometry], [marking topology], [palette], [distinctive traits].
Views: neutral three-quarter hero, front, profile, and close-up of [critical detail].
Style: clean neutral studio reference, minimal stylization.
Constraints: preserve asymmetry; no added accessories; no text; no watermark.
Avoid: [negative invariants].
```

## Concept directions

Keep identity, pose, camera, and framing fixed across directions.

```text
Use case: stylized-concept
Asset type: IP concept direction [A/B/C/D]
Primary request: Translate the identity anchor into [soft-healing / odd-cute observer / art collectible / sticker mascot] language.
Input images: Image 1 identity anchor; Image 2 optional marking close-up.
Style axis: change [proportion/material/emotional temperature/abstraction] only.
Identity invariants: [list].
Composition: full-body three-quarter neutral pose, centered, consistent scale.
Constraints: original design; no named artist or existing IP imitation; no text; no watermark.
Avoid: [negative invariants].
```

When style is inferred from images, add:

```text
Visible fit evidence: [silhouette/material/mood/detail observations only].
Style family: [source-neutral family from style-routing.md].
Design translation: [proportion], [silhouette], [expression grammar], [palette], [material], [lighting].
Originality guardrail: do not reproduce signature facial geometry, tooth patterns, hairstyles, headgear, costumes, logos, or accessories from any existing collectible character.
```

## Sticker master

```text
Use case: stylized-concept
Asset type: transparent sticker master
Primary request: Create the selected IP performing [one concrete action] to communicate [emotion/verb].
Input images: Image 1 identity anchor; Image 2 selected concept; Image 3 optional pose reference.
Identity invariants: [list].
Expression: [eyes], [mouth], [head/ear angle], [body deformation].
Composition: one full character, readable silhouette, generous safe margin.
Background: perfectly uniform chroma background selected by the imagegen transparency workflow.
Constraints: same material and lighting as the set; no text; no props unless essential; no watermark.
Avoid: extra limbs, duplicated appendages, cropped features, identity drift.
```

## Abstract-humor modifier

Add one or two, not all:

- exaggerate one body axis while keeping the face stable
- make the pose physically awkward but visually readable
- contrast a calm face with an impossible body shape
- freeze the character at the least dignified moment
- squash, stretch, tilt, or flatten without altering identity-critical topology

## Detail banner

```text
Use case: ads-marketing
Asset type: WeChat sticker detail banner, final crop 750×400
Primary request: Show the same IP in three or four signature states as a left-to-right micro-story.
Input images: Image 1 identity anchor; Image 2 selected concept; Images 3–5 signature pose references.
Composition: wide 1.875:1, all faces and appendages inside crop-safe margins, balanced rhythm.
Backdrop: vivid opaque non-white studio set with simple abstract shapes.
Style: match the selected sticker material and lighting.
Text: none.
Constraints: same character identity in every instance; no letters, numbers, logos, speech bubbles, or watermark.
```
