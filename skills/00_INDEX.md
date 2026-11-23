# 00 — Index

**Purpose:** Reading order by task, inventory of skills documents with last-verified dates, contribution process, and changelog. Read this first to find the right document quickly.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00 (root is not a git repository). Subrepo HEADs observed: `argos-api/` `c348c54` (`Initial commit`), `argos-web/` `0a5d9ec` (`Initial commit`), `argos-android/` `0ac5e0e` (`Initial commit`), `argos-specs/` has no commits on `main`. The code wins (see 16).

## Reading order by task

| Task | Read | Why |
|---|---|---|
| First time in the ecosystem | [01_ARCHITECTURE.md](01_ARCHITECTURE.md) → [02_PROJECT_STRUCTURE.md](02_PROJECT_STRUCTURE.md) → [03_CODE_STYLE.md](03_CODE_STYLE.md) → [14_DEVELOPER_WORKFLOWS.md](14_DEVELOPER_WORKFLOWS.md) | Establish the model, layout, conventions, and day-1 workflow before changing anything. |
| Understand what exists today | [01_ARCHITECTURE.md](01_ARCHITECTURE.md), [02_PROJECT_STRUCTURE.md](02_PROJECT_STRUCTURE.md), [15_KNOWN_LIMITATIONS.md](15_KNOWN_LIMITATIONS.md) | The ecosystem is scaffold-only; these state verified reality vs. placeholders. |
| Update specs or planning docs | [04_CHANGE_RULES.md](04_CHANGE_RULES.md), [03_CODE_STYLE.md](03_CODE_STYLE.md), [14_DEVELOPER_WORKFLOWS.md](14_DEVELOPER_WORKFLOWS.md), [13_DEPENDENCIES.md](13_DEPENDENCIES.md) | Avoid placeholder drift and keep cross-doc names/prefixes in lockstep. |
| Prepare commits/releases/tags (future, per component repo) | [03_CODE_STYLE.md](03_CODE_STYLE.md), [04_CHANGE_RULES.md](04_CHANGE_RULES.md), [10_DEPLOYMENT.md](10_DEPLOYMENT.md), [argos-specs/git-guidelines.md](../git-guidelines.md) | Commit scope and version/tag rules are documented but untested in this scaffold. |
| Investigate a problem or surprise | [05_DEBUGGING_PLAYBOOK.md](05_DEBUGGING_PLAYBOOK.md), [06_FAILURE_STORIES.md](06_FAILURE_STORIES.md), [15_KNOWN_LIMITATIONS.md](15_KNOWN_LIMITATIONS.md) | No runtime incidents recorded yet; start from known gaps and verification commands. |
| Work on DB/API/security/testing/performance | [07_DATABASE.md](07_DATABASE.md), [08_API.md](08_API.md), [09_SECURITY.md](09_SECURITY.md), [11_TESTING.md](11_TESTING.md), [12_PERFORMANCE.md](12_PERFORMANCE.md), [15_KNOWN_LIMITATIONS.md](15_KNOWN_LIMITATIONS.md) | These areas are not implemented in this workspace; documents explain absence and risks. |
| Propose or record engineering knowledge | [INBOX.md](INBOX.md), [16_ENGINEERING_PRINCIPLES.md](16_ENGINEERING_PRINCIPLES.md), relevant topic doc | Use the contribution homes defined in [handoff.md](../../handoff.md). |

## Document inventory

| # | Document | Purpose | Last verified |
|---|---|---|---|
| 00 | [00_INDEX.md](00_INDEX.md) | Index, reading order, contribution guide, changelog | 2026-11-22T02:28:19+08:00 |
| — | [INBOX.md](INBOX.md) | Staging area for unverified contributions | 2026-11-22T02:28:19+08:00 |
| 01 | [01_ARCHITECTURE.md](01_ARCHITECTURE.md) | Ecosystem model, components, boundaries, decisions, debt | 2026-11-22T02:28:19+08:00 |
| 02 | [02_PROJECT_STRUCTURE.md](02_PROJECT_STRUCTURE.md) | Annotated tree, placement rules, naming signals | 2026-11-22T02:28:19+08:00 |
| 03 | [03_CODE_STYLE.md](03_CODE_STYLE.md) | Conventions, commit/release guidance, anti-patterns known so far | 2026-11-22T02:28:19+08:00 |
| 04 | [04_CHANGE_RULES.md](04_CHANGE_RULES.md) | Lockstep sets, hidden dependencies, high-risk areas, retest guidance | 2026-11-22T02:28:19+08:00 |
| 05 | [05_DEBUGGING_PLAYBOOK.md](05_DEBUGGING_PLAYBOOK.md) | Verification commands and symptom checks for this scaffold | 2026-11-22T02:28:19+08:00 |
| 06 | [06_FAILURE_STORIES.md](06_FAILURE_STORIES.md) | Incident reconstructions (none recorded) | 2026-11-22T02:28:19+08:00 |
| 07 | [07_DATABASE.md](07_DATABASE.md) | Data/storage state (not implemented) | 2026-11-22T02:28:19+08:00 |
| 08 | [08_API.md](08_API.md) | API state (not implemented) | 2026-11-22T02:28:19+08:00 |
| 09 | [09_SECURITY.md](09_SECURITY.md) | Security posture and gaps (requirements/template only) | 2026-11-22T02:28:19+08:00 |
| 10 | [10_DEPLOYMENT.md](10_DEPLOYMENT.md) | Release/deployment state and documented process | 2026-11-22T02:28:19+08:00 |
| 11 | [11_TESTING.md](11_TESTING.md) | Test/validation state (none present) | 2026-11-22T02:28:19+08:00 |
| 12 | [12_PERFORMANCE.md](12_PERFORMANCE.md) | Performance constraints (none implemented) | 2026-11-22T02:28:19+08:00 |
| 13 | [13_DEPENDENCIES.md](13_DEPENDENCIES.md) | Dependency/tooling inventory (none declared) | 2026-11-22T02:28:19+08:00 |
| 14 | [14_DEVELOPER_WORKFLOWS.md](14_DEVELOPER_WORKFLOWS.md) | Practical recipes for working in the current scaffold | 2026-11-22T02:28:19+08:00 |
| 15 | [15_KNOWN_LIMITATIONS.md](15_KNOWN_LIMITATIONS.md) | Gaps, drift risks, and redesign candidates | 2026-11-22T02:28:19+08:00 |
| 16 | [16_ENGINEERING_PRINCIPLES.md](16_ENGINEERING_PRINCIPLES.md) | Quotable rules grounded in observed evidence | 2026-11-22T02:28:19+08:00 |

## How to contribute

1. Prefer adding a rough entry to [INBOX.md](INBOX.md) when you cannot fully verify a finding. A rough, evidenced entry beats none.
2. If you can verify a change, edit the target document directly and keep the contribution's substance/credit (see [handoff.md](../../handoff.md) and 03 #Respect contributors).
3. Route contributions to the correct home: best practices → 03/14, methodology → 10/11/14, design choice → 01 (decision record), change rule → 04 (lockstep set), failure story → 06 (linked from 04/05/16), debugging tip → 05, limitation → 15, dependency note → 13, proven principle → 16.
4. Every rule needs a reason naming what breaks (16 #1). Mark silent failures as `Miss → ...` beside the preventing step (04, 14).
5. When refreshing, process [INBOX.md](INBOX.md), keep teammates' direct edits, retire outdated knowledge as **Superseded (date): ...** (do not delete), and append changelog entries here without renumbering documents.

## Changelog

| Date | Change | Verified against |
|---|---|---|
| 2026-11-22 | Initial generation of skills documents `00`–`16` and `INBOX` from current workspace state (scaffold-only ecosystem; no app/runtime code present). | Workspace snapshot 2026-11-22T02:28:19+08:00; subrepo HEADs `argos-api` c348c54, `argos-web` 0a5d9ec, `argos-android` 0ac5e0e, `argos-specs` no commits |
