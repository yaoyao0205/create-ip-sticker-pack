# Identity consistency

Use this reference while building or auditing an identity anchor.

## Extraction order

1. **Silhouette:** overall mass, width/height ratio, head-to-body ratio, appendage length.
2. **Geometry:** face or front-plane shape, eye spacing, nose/feature placement, ear/handle angle, jaw/base shape.
3. **Topology:** where colors, markings, seams, panels, hairlines, or material boundaries begin and end.
4. **Surface:** fur length, skin detail, grain, gloss, wear, manufacturing texture.
5. **Behavior:** neutral gaze, resting posture, habitual asymmetry, emotional baseline.
6. **Negative invariants:** tempting but incorrect features the generator must avoid.

## Subject-specific checks

### Person

- Preserve cranial/face shape before stylizing eyes or cheeks.
- Track eye spacing, brow angle, nose length/width, mouth width, jaw taper, hairline, and characteristic asymmetry.
- Avoid changing apparent age, ethnicity, or body type unless explicitly requested.

### Animal

- Track muzzle length, forehead slope, eye shape and color, ear size/angle, body mass, leg length, tail thickness and ring pattern.
- Map markings by anatomical plane. Example: “dark cap begins behind the left brow, crosses the crown, wraps the outer right ear base, and does not cover either cheek.”
- Do not let “cute” automatically mean a rounder face, shorter muzzle, or larger eyes.

### Object or product

- Track silhouette, corner radii, openings, button/port positions, seams, label zones, surface finish, and real-world proportions.
- Preserve functional geometry even when anthropomorphizing.
- Place facial features only on a stable, repeatable plane.

## Anchor-sheet content

- Neutral three-quarter hero view.
- Front view for symmetry and spacing.
- Profile view for projection and slope.
- Close crop of recognition-critical markings/details.
- Small palette/material swatches.
- A short “must keep / must avoid” list.

## Marking topology notation

Describe each marking with:

```text
NAME: crown patch
ORIGIN: behind left ear base
DIRECTION: diagonal toward right brow
BOUNDARY: feathered outer edge, hard inner edge
CROSSES: crown and right ear base
DOES NOT CROSS: cheeks, chin, left eye
ASYMMETRY: heavier on subject-right
```

## Identity audit score

Score each candidate from 0–2 on six dimensions:

- silhouette
- face/front geometry
- marking/detail topology
- palette/material
- expression baseline
- appendages and small distinctive traits

Regenerate below 9/12. Never compensate for a wrong face with correct color alone.

## Feedback routing

- “Face too round”: change head outline, cheek width, jaw taper, and eye-to-edge distance together.
- “Expression not alike”: compare eyelid openness, pupil size, gaze direction, mouth tension, ear angle, and head pitch.
- “Marking wrong”: stop pose work; rebuild the topology map and anchor close-up.
- “Looks like another breed/object”: revisit silhouette and structural ratios before texture.

