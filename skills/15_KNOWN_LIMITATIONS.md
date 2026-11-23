# 15 — Known Limitations

**Purpose:** Gaps ordered by how likely they are to surprise contributors: drift, deferred features, architectural constraints, security weaknesses, bugs, and redesign candidates. Read to calibrate expectations and plan work.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00. Evidence: empty/minimal component contents, template docs (`argos-specs/business-logic-v1.0.md`, `git-guidelines.md`, `sense-making.md`), empty `AGENTS.md` files, separate git repos (api/web/android initial commits; specs no commits), and absence of manifests/code/tests/CI. The code wins (see 16).

## Gaps likely to surprise (ordered)

| Rank | Limitation | Type | Evidence | Impact / Miss → surprise |
|---|---|---|---|---|
| 1 | Project identity and process tokens are placeholders (`code-name`, `CN`, prefixes usage context, `<feature*>`, business-logic fields) | Drift / incomplete definition | `argos-specs/git-guidelines.md`, `argos-specs/business-logic-v1.0.md` | Contributors may produce inconsistent scopes/tags/specs or treat templates as final. *Miss → rework and invalid release history (04 #1, #2).* |
| 2 | No implemented application/runtime behavior in any component | Deferred feature / architectural incompleteness | Only `README.md`, `AGENTS.md`, `.git/` in `argos-api/web/android`; specs has docs only | Questions about API/DB/UI behavior cannot be answered from code. *Miss → assumptions leak into implementation and docs (01, 07, 08).* |
| 3 | Root is not a git repo; components are separate repos with minimal history | Architectural constraint / coordination gap | Root git commands fail; subrepos at initial/no commits with distinct remotes | Easy to run git commands in wrong context; no unified workspace audit trail. *Miss → lost or misplaced commits/tags (05, 10).* |
| 4 | No automated validation (lint/build/test/CI/hooks) | Quality/process gap | No manifests, test files, workflows, or active hooks found | Conformance (style, commits, releases, behavior) is manual only. *Miss → regressions and policy drift unnoticed (03, 11, 10).* |
| 5 | Security and privacy requirements are stated only as template intent | Security/compliance gap | `business-logic-v1.0.md` includes DPA/privacy-related requirement text but no controls | No verified authz, retention, consent, or protection mechanisms exist. *Miss → unsafe implementation choices or false compliance confidence (09).* |
| 6 | Business logic and planning artifacts are incomplete/templates | Drift / deferred definition | `business-logic-v1.0.md` placeholders; `sense-making.md` is an instruction template; `argos-specs/planning/` not present | Requirements/access/features and evidence artifacts may be missing or stale. *Miss → building against undefined scope (04 #2).* |
| 7 | Skills docs are an initial snapshot of a scaffold | Freshness risk | Generated 2026-11-22 from mostly-empty repos | First real code/decisions will quickly invalidate parts of 01–14. *Miss → stale guidance followed confidently if not refreshed (00, 16 #2).* |

## Deferred features (specified but not implemented)

| Item | Source | Status |
|---|---|---|
| Google Sign-In integration | `argos-specs/business-logic-v1.0.md` System Requirement #1 | Not implemented (no code/config) |
| System requirements #2–#7 and MVP feature/access details | `argos-specs/business-logic-v1.0.md` | Placeholder/unspecified |
| User-level-specific capabilities (A–E) beyond template descriptions | `argos-specs/business-logic-v1.0.md` | Undefined/unenforced |

## Architectural constraints (current)

| Constraint | Consequence |
|---|---|
| Separate git repositories per component | Cross-cutting changes require coordinated commits/tags/docs across repos (01, 04, 10). |
| No shared root build/test orchestration | Validation and setup must be defined per component; workspace-level automation is absent (11, 14). |
| Specs separated from implementation repos | Traceability must be maintained manually until tooling/contracts are introduced (04). |

## Security weaknesses / accepted gaps

- No implemented authentication, authorization enforcement, secret management, secure transport configuration, scanning, or audit logging (09).
- Risk is partially theoretical today due to no deployed/runtime system, but becomes immediate upon first implementation/deployment. *Miss → insecure defaults carried into production.*

## Bugs

No verified software bugs recorded (no executable code/runtime evidence). Documentation/template inconsistencies (e.g. placeholder tokens, minor README typos such as double spaces in `argos-api/README.md`) are tracked as drift/quality gaps, not runtime defects.

## Redesign candidates (ranked)

| Rank | Candidate | Why | Precondition / caution |
|---|---|---|---|
| 1 | Establish canonical project identity and resolved spec baseline | Unblocks consistent commits, tags, architecture decisions, and implementation planning | Agree on names/prefixes/features and update lockstep sets (04 #1, #2, 01). |
| 2 | Define per-component stack, structure, and minimal CI/test harness | Enables real development with repeatable validation | Record decisions and workflows in 02, 03, 10, 11, 13, 14. |
| 3 | Introduce contract-first boundaries between API and clients | Reduces cross-repo integration drift once code exists | Requires initial API/auth/data model decisions (07, 08, 09). |
| 4 | Add workspace-level coordination conventions/tooling (optional) | Simplifies multi-repo operations and release coordination | Must not obscure per-repo ownership/history; evaluate after components mature (01, 10). |
