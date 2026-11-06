# Persistent character record

Read when selecting a character or continuing an existing pack. Store project-specific facts in the project, never in the skill itself.

Use `identity/character-spec.yaml` with these fields (omit unknown values rather than inventing measurements):

```yaml
version: 1
status: draft # approved only after user approval or an authorized automatic selection
selection_basis: ""
approved_reference: "" # project-relative image path
proportions: {}
palette: []
marking_topology: []
recognition_traits: []
appendage_topology: {}
expression_limits: []
forbidden_changes: []
typography: {}
```

Record each meaningful correction in `identity/corrections.md`: date, exact user requirement, affected feature, superseded rule if any, and resulting reference/master path. Latest explicit correction wins; retain superseded entries as history. Automatically selected directions must be labeled as such, not falsely called user-approved.

Before another theme or pack, read these records and the actual approved images. Keep per-sticker planning in a TSV with index, caption, action, emotion, incoming-message scenario, silhouette distinction, master path, and review status. Keep generation prompts beside masters and record rejected variants without including them in export input.

Record visual audit results for identity, appendages, caption readability, light/dark edges, and set redundancy. Mark each item pass, repaired, or unresolved. Do not claim image inspection from script-only checks.
