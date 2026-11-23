# 11 — Testing

**Purpose:** Honest coverage, how the team gains confidence, what must be tested, manual drills, mocking, and dimensions that break. Read before claiming correctness.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00. Searched for test directories/files/configs (`test`, `tests`, `spec`, `__tests__`, `*.test.*`, `*.spec.*`, `pytest`, `jest`, `junit`, `gradle test` configs, CI workflows); none found in any component. Subrepo HEADs: `argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits. The code wins (see 16).

## Honest coverage

| Area | Automated tests | Manual/other validation | Confidence |
|---|---|---|---|
| `argos-api` | None | README/stub inspection only | No runtime confidence |
| `argos-web` | None | README/stub inspection only | No runtime confidence |
| `argos-android` | None | README/stub inspection only | No runtime confidence |
| `argos-specs` | None | Manual document review; placeholder consistency not enforced | Low (template drift risk) |
| Cross-component integration | None | None | None |

## How the team gains confidence today

1. **Direct inspection:** verify files/paths/content with `view`, `Get-ChildItem`, and `Select-String` (05). *Miss → assumptions based on filenames/templates rather than actual state.*
2. **Git state verification per component:** check branch/HEAD/remote/status in the correct repo (01, 05). *Miss → operating on wrong history.*
3. **Policy/spec review:** compare changes against `git-guidelines.md`, business logic, and skills docs (03, 04). *Miss → undocumented drift.*

This is necessary but insufficient for behavioral correctness once code exists.

## What must be tested (when implementation begins)

| Dimension | Examples / focus | Why / Miss → impact |
|---|---|---|
| Contract correctness | API request/response shapes, auth requirements, error codes (08) | Client-server breakage across repos. |
| Authn/authz | Google Sign-In flow integration points, role/access enforcement per business logic (09) | Unauthorized access or broken login. |
| Data integrity | Migrations, constraints, delete/retention behavior (07) | Corruption, data loss, privacy issues. |
| Critical user flows | MVP features once defined; cross-client parity where required | Feature regressions in primary journeys. |
| Release/tag process adherence | Version/tag scripts/checks if introduced (10) | Invalid release identifiers and audit confusion. |
| Spec consistency checks (optional automation) | Placeholder detection, link/path validation for docs | Stale or contradictory guidance (04, 15). |

## Manual drills (useful now and later)

| Drill | Steps | Expected signal |
|---|---|---|
| Workspace reality check | List non-.git files; confirm intended component homes (02) | No accidental cross-component placement. |
| Placeholder scan before spec "finalization" | Search for `<...>`, `code-name`, `xxx`, `...` in target docs | Unresolved tokens surfaced explicitly (04 #1, #2). |
| Repo-context check before git operations | Run `git -C <component> status -sb` and `remote -v` | Correct repo/remote targeted. |

## Mocking (future guidance)

No code/tests to mock. When tests are added: mock external providers (e.g. Google identity, third-party APIs) and time/network boundaries at clear seams; avoid mocking core business invariants so tests still catch logic errors. *Miss → brittle tests or false confidence.*

## Dimensions that break (risk register)

| Dimension | Why likely here |
|---|---|
| Cross-repo compatibility | Separate repos for API/web/android/specs with no contracts yet (01). |
| Windows/PowerShell command differences | Environment-specific shell behavior can invalidate documented commands (05). |
| Placeholder-to-real transition | Identity, scopes, business rules, and release tables are templated (04, 15). |
| Process compliance without enforcement | No hooks/CI to validate commit/tag/release rules (03, 10). |
