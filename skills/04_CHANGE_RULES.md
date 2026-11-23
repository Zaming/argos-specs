# 04 — Change Rules

**Purpose:** Lockstep sets, hidden dependencies, high-risk areas, and what to retest. Read before renaming, replacing placeholders, restructuring, or making cross-cutting changes.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00. Evidence: [`argos-specs/git-guidelines.md`](../git-guidelines.md), [`argos-specs/business-logic-v1.0.md`](../business-logic-v1.0.md), [`argos-specs/sense-making.md`](../sense-making.md), [`handoff.md`](../../handoff.md), root/component `AGENTS.md` and `README.md` files, and directory/git inspection. Subrepo HEADs: `argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits. The code wins (see 16).

## Lockstep sets

### 1. Project identity and commit/tag naming tokens
**Status:** Unresolved placeholders (verified). Changing any token requires coordinated updates to avoid split identity.

| # | Location | Token / element to keep in sync | Role |
|---|---|---|---|
| 1 | `argos-specs/git-guidelines.md` | `code-name` (scope examples, text), `Code Name`, `Short Code` (`CN`) | Canonical naming guidance for commits/releases/spec scopes |
| 2 | `argos-specs/git-guidelines.md` | Product prefixes `WCN`, `BCN`, `ACN`, `SCN` and product mapping text (web/api/android/specs) | Tag prefix identity |
| 3 | `argos-specs/git-guidelines.md` | Feature placeholders `<feature1>`, `<feature2>`, `...` and scope lists | Allowed/expected commit scope vocabulary |
| 4 | `argos-specs/git-guidelines.md` | Release tag tables and "Next release" lines (currently empty / `*.01.0.001`) | Historical/operational release record |
| 5 | `argos-specs/business-logic-v1.0.md` | `<Platform>`, `<App/Software Type>`, `<Tech Stack>`, `<Userbase>`, `<Team Name>`, `<Code Name>`, `<short-code>`, descriptions | Product identity in requirements/specs |
| 6 | Root/component `README.md` files | Product name/role descriptions ("Argos", component purpose) | Human-facing identity and boundaries |
| 7 | Future code/manifests/CI/package IDs (none present yet) | App IDs, package names, service names, env var prefixes | Runtime/build identity |

**Change procedure:** define canonical values once (record decision in 01), then update #1–#6 in one reviewed change set and plan #7 before first implementation commit.  
*Miss → commits/tags/specs use mixed names/prefixes, making history and release tracking unreliable and causing rework across repos (03, 10, 15).* 

### 2. Business-logic template completeness (requirements/spec baseline)
**Status:** Template with placeholders (verified).

| # | Location | Coupled elements | Why in lockstep |
|---|---|---|---|
| 1 | `argos-specs/business-logic-v1.0.md` | Project Details, User Levels, System Requirements, Required Solution Layers, MVP Features and Access, Notes | Access/features/roles must agree; placeholders (`...`, `xxx`) indicate incomplete definition |
| 2 | `argos-specs/sense-making.md` | "Read the latest business-logic file" and output path `*-specs/planning/sense-making.csv` | Sense-making depends on current business logic and target folder |
| 3 | `argos-specs/git-guidelines.md` (spec scope guidance) | `code-name-specs/<feature>` / spec-kind scopes for spec changes | Spec edits should be traceable once committing begins |

**Change procedure:** when finalizing business logic, update dependent planning artifacts (or mark them stale) and record feature/scope names for 04 #1.  
*Miss → planning/security/access assumptions diverge from stated requirements; contributors implement against stale placeholders (01, 09, 15).*

### 3. Skills document set and navigation
**Status:** Generated on 2026-11-22.

| # | Location | Coupled elements | Why in lockstep |
|---|---|---|---|
| 1 | `argos-specs/skills/00_INDEX.md` | Inventory table, reading order, changelog, last-verified dates | Index must reflect actual docs and verification state |
| 2 | `argos-specs/skills/01`–`16` + `INBOX.md` | Headers (`Purpose`, `Confidence note`), cross-references (`see NN #k`) | Broken/renumbered refs misdirect readers |
| 3 | `handoff.md` | Required document list and standards | Source contract for generation/refresh |

**Change procedure:** append-only numbering; when adding/updating a doc, update index/changelog/confidence and fix cross-references.  
*Miss → readers follow wrong or missing guidance and trust stale navigation (00, 16 #2).*

### 4. Root/component AGENTS instructions
**Status:** All `AGENTS.md` files are empty (verified), while root `AGENTS.md` in workspace context previously instructed reading component AGENTS/skills (see conversation context / `AGENTS.md` at root path). **Inferred risk:** guidance may be added later in multiple places.

| # | Location | Coupled elements | Why in lockstep |
|---|---|---|---|
| 1 | `/AGENTS.md` | Global startup instructions, required reads | Entry point for contributors/agents |
| 2 | `argos-api/AGENTS.md`, `argos-android/AGENTS.md`, `argos-web/AGENTS.md`, `argos-specs/AGENTS.md` | Component-specific rules | Must not contradict root/skills; avoid duplication drift |

*Miss → contributors receive conflicting or missing instructions and violate component boundaries or process rules (02, 03).*

## Hidden dependencies

| Dependency | Evidence | Risk / Miss → impact |
|---|---|---|
| Separate git repos inside one non-git workspace root | Root has no `.git`; each component has `.git/` and own remote | Commands run from wrong directory affect wrong history. *Miss → commits/tags pushed to wrong repo or not at all (05, 10).* |
| `sense-making.md` assumes `planning/` output location | Instruction states `Save file in *-specs/planning/sense-making.csv` | `argos-specs/planning/` does not currently exist (verified). *Miss → output path confusion or unwritten artifact.* |
| `git-guidelines.md` encodes process but not enforcement | No hooks/CI/tooling present | Policy compliance relies on manual discipline. *Miss → inconsistent commit messages/tags despite documented standard (03, 10).* |
| Future cross-repo contracts (API/web/android) | Architecture intent in READMEs/business-logic reqs | Schema/endpoint/auth changes will require coordinated client/spec updates once implemented. *Miss → runtime breakage across components (01, 08).* |

## High-risk areas

| Area | Why high risk now | Guardrail |
|---|---|---|
| Mass placeholder replacement (`code-name`, prefixes, business-logic fields) | Many occurrences across specs/guidelines; easy partial update | Use search (`grep`) for old tokens, update lockstep set 04 #1/#2, record decision in 01. |
| Creating/retagging releases | Detailed but complex rules in `git-guidelines.md`; no existing tag history in tables | Do not invent tags; follow 10 and verify repo/remote/week timing before tagging. |
| Adding first implementation code to empty component repos | No established structure/tooling/tests yet | Define structure/manifests/CI in same change series; update 02/03/10/11/13/14. |
| Editing skills docs without index/changelog updates | Navigation and freshness become misleading | Update 00 in same change; append changelog entry (00). |

## What to retest / recheck

| After change | Recheck | Why |
|---|---|---|
| Any skills doc edit | Internal links/number refs, confidence note accuracy, `00_INDEX.md` inventory/changelog | Prevents stale/misdirected guidance (16 #2). |
| Placeholder/identity edits | `grep` for old tokens in `argos-specs/` (and component docs if touched); consistency with 01 decision records | Ensures lockstep completion. *Miss → mixed identity persists silently.* |
| Workflow/process doc edits | Run/mentally validate referenced commands against current OS/shell and paths | Documented commands can be wrong on Windows/PowerShell. |
| First code/tooling introduction (future) | Component build/lint/test commands, CI config, dependency manifests, and impacted skills docs | No automated baseline exists yet; manual verification is required until 11 is real. |
| Spec-to-implementation changes (future) | Contracts, auth flows, migrations, and affected client behavior per 07/08/09/11 | Cross-component regressions are likely once code exists. |
