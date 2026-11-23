# 16 — Engineering Principles

**Purpose:** Numbered, quotable rules for working in this ecosystem, each with reasoning, evidence, and source. Read to resolve tradeoffs consistently; later principles are appended after the final rule.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00. Evidence: [`handoff.md`](../../handoff.md), observed workspace/repo state (`argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits; root not a git repo), and template/policy docs in `argos-specs/`. The code wins (see rule 8).

## Principles

### 1. "Every rule has a reason, and every reason names what breaks."
- **Reasoning:** Rules without failure modes become superstition and are dropped under pressure; naming what breaks makes tradeoffs testable and memorable.
- **Evidence:** `handoff.md` standards require this explicitly; current scaffold docs rely on `Miss → ...` notes to convey risk where enforcement/code is absent (04, 05, 14).
- **Source:** `handoff.md` (Standards); reinforced by initial skills generation practice.

### 2. "Be concrete and label confidence."
- **Reasoning:** Concrete names/paths/commands enable verification; confidence labels prevent readers from treating inference as fact in a rapidly changing scaffold.
- **Evidence:** Workspace investigation required exact paths, git states, and distinction between verified placeholders vs. inferred architecture (01, 02, 15); many areas have no implementation.
- **Source:** `handoff.md` (Standards); observed repo state on 2026-11-22.

### 3. "Treat placeholders as debt, not decisions."
- **Reasoning:** Template tokens look authoritative but do not encode real choices; copying them forward creates systemic drift.
- **Evidence:** `argos-specs/git-guidelines.md` (`code-name`, `<feature*>`, empty tag tables) and `argos-specs/business-logic-v1.0.md` (`<...>`, `...`, `xxx`) remain unresolved (04 #1, #2, 15).
- **Source:** Verified file contents in `argos-specs/`; 04 lockstep analysis.

### 4. "Work in the right repository context every time."
- **Reasoning:** This workspace is a container, not a unified git repo; history, tags, and remotes belong to component repos.
- **Evidence:** Root `git` operations fail with "not a git repository"; each component has its own `.git/` and remote (`Zaming/argos-*`) with differing states (01, 05).
- **Source:** Verified git inspection on 2026-11-22.

### 5. "Update lockstep sets together or not at all."
- **Reasoning:** Mirrored names/rules/tables drift silently when changed in isolation, causing downstream confusion and rework.
- **Evidence:** Identity tokens, spec templates, and skills navigation/index are coupled across multiple files (04 #1–#3).
- **Source:** 04 change-rule analysis; `handoff.md` "Inventory lockstep sets".

### 6. "Absence of evidence is not evidence of behavior."
- **Reasoning:** In an empty scaffold, missing tests/logs/code means unknowns, not correctness or safety.
- **Evidence:** No manifests, routes, schemas, tests, CI, or runtime artifacts were found; security/auth/database/API/performance docs can only describe pending state (07–13, 15).
- **Source:** Verified workspace inventory and component inspections.

### 7. "Keep knowledge maintainable: append, retire, and refresh."
- **Reasoning:** Stable numbering preserves references; retiring (not deleting) preserves history; frequent refresh prevents confident wrong guidance.
- **Evidence:** `handoff.md` requires append-only numbering, "Superseded..." retirement, and refresh triggers; 00 defines changelog/confidence tracking for this purpose.
- **Source:** `handoff.md` (Keeping it fresh, The documents); 00_INDEX process.

### 8. "Trust the code over any document, including this one."
- **Reasoning:** Documents can lag reality; executable/configured behavior and repository state are the final authority for what the system does.
- **Evidence:** Entire skills set is generated from a scaffold snapshot with explicit confidence notes and known limitations; future changes will invalidate parts of these docs unless refreshed (00, 15).
- **Source:** `handoff.md` (Standards, The documents); core safety rule for all skills in `argos-specs/skills/`.
