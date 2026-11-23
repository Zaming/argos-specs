# 01 — Architecture

**Purpose:** One-paragraph ecosystem model, components and ownership, data flows, boundaries, decisions, tradeoffs, and debt. Read first.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00 (root is not a git repository). Subrepo HEADs observed: `argos-api/` `c348c54` (`Initial commit`, remote `git@github.com:Zaming/argos-api.git`), `argos-web/` `0a5d9ec` (`Initial commit`, remote `git@github.com:Zaming/argos-web.git`), `argos-android/` `0ac5e0e` (`Initial commit`, remote `git@github.com:Zaming/argos-android.git`), `argos-specs/` no commits on `main` (remote `git@github.com:Zaming/argos-specs.git`). Only `README.md`/`AGENTS.md` stubs, `handoff.md`, and `argos-specs/*` template docs were present; no application code, manifests, routes, schemas, migrations, configs, CI, or tests were found. The code wins (see 16).

## One-paragraph model

**Verified (limited):** Argos is organized as an ecosystem workspace containing four top-level components: `argos-api/` (backend API, per README), `argos-web/` (frontend web app), `argos-android/` (Android app), and `argos-specs/` (product ecosystem specifications). **Inferred:** the intended runtime flow is clients (`argos-web`, `argos-android`) communicating with `argos-api`, which mediates data/storage concerns, while `argos-specs` defines requirements and conventions; this flow is not implemented in the current workspace. **Suspected:** components may be developed/released independently because each is a separate git repository with its own remote.

## Components and ownership (observed)

| Component | Path | Observed role (source) | Git state (verified) | Owns (inferred/pending) |
|---|---|---|---|---|
| Workspace root | [`/`](../../) | Local container for handoff and component folders (`handoff.md`, `AGENTS.md`) | Not a git repository | Cross-component coordination only; no shared build/runtime observed |
| API | [`argos-api/`](../../argos-api/) | "The back-end web application that is used to  communicates between the database API and the  web/Android clients for Argos." ([`argos-api/README.md`](../../argos-api/README.md), text as-is) | `main` @ `c348c54`, remote `origin` `git@github.com:Zaming/argos-api.git` | Server-side behavior, persistence access, client-facing contracts (not present) |
| Web | [`argos-web/`](../../argos-web/) | "Frontend web application for Argos" ([`argos-web/README.md`](../../argos-web/README.md)) | `main` @ `0a5d9ec`, remote `origin` `git@github.com:Zaming/argos-web.git` | Browser UI/client behavior (not present) |
| Android | [`argos-android/`](../../argos-android/) | "The Android application for Argos." ([`argos-android/README.md`](../../argos-android/README.md)) | `main` @ `0ac5e0e`, remote `origin` `git@github.com:Zaming/argos-android.git` | Mobile UI/client behavior (not present) |
| Specs | [`argos-specs/`](../../argos-specs/) | "Contains the product ecosystem specifications for Argos." ([`argos-specs/README.md`](../../argos-specs/README.md)) | No commits on `main`, remote `origin` `git@github.com:Zaming/argos-specs.git` | Requirements, conventions, planning artifacts (templates present) |

## Data flows (end to end)

| Flow | Status | Evidence / note |
|---|---|---|
| Web client → API → data store | Not implemented | No routes, clients, schemas, or manifests found in `argos-web/` or `argos-api/`. README states intended communication role. |
| Android client → API → data store | Not implemented | No app code/manifests/build files found in `argos-android/` or `argos-api/`. |
| Authentication (Google Sign-In) | Specified as requirement, not implemented | [`argos-specs/business-logic-v1.0.md`](../business-logic-v1.0.md) System Requirement #1; no auth code/config found. |
| Specs → implementation | Manual/informal (inferred) | `argos-specs/` contains templates/guidelines; no traceability links or generated artifacts observed. *Miss → implementation diverges from spec without detection (no tests/contracts/checklists enforced).* |

## Hard boundaries

| Boundary | Rule | Why / what breaks |
|---|---|---|
| Component repos are separate | Treat `argos-api/`, `argos-web/`, `argos-android/`, `argos-specs/` as independent git repositories (each has `.git/`, own `origin`). | Root is not a git repo; committing/tagging in the wrong directory creates fragmented history and invalid release/version assumptions (see 03, 10). *Miss → changes appear "done" locally but are not recorded in the intended component repo.* |
| Specs vs. implementation | `argos-specs/` documents intent/conventions; implementation repos own runnable behavior when created. | Keeping intent and behavior distinct prevents template text/placeholders from being mistaken for shipped behavior (15). |
| Secrets/config values | Do not add secret values to specs or code; document env var names only (handoff standard). | Leaked credentials/keys cause security incidents and require rotation; no secret-management tooling is defined yet (09). |

## Decision records

### Decision: Ecosystem split into four component repositories (date unknown, author unknown)
**Status:** accepted (inferred from repository layout)  
**Context:** Workspace contains `argos-api/`, `argos-web/`, `argos-android/`, `argos-specs/` as separate git checkouts with distinct remotes under `Zaming/*`.  
**Choice:** Maintain components as separate repositories/folders rather than one monorepo root.  
**Alternatives:** Single git repository at root (not observed); unknown.  
**Consequences:** Independent history/remotes/tags per component; coordination overhead for cross-cutting changes and lockstep rules (04). Root-level tooling/CI cannot assume a single git context.

### Decision: Initialize with placeholder specs and AGENTS stubs (date unknown, author unknown)
**Status:** accepted (observed)  
**Context:** `argos-specs/business-logic-v1.0.md` is a template with `<...>` placeholders; `AGENTS.md` files are empty; `git-guidelines.md` is detailed but contains generic placeholders (e.g. `code-name`, `<feature1>`).  
**Choice:** Commit/preserve scaffolding and policy templates before implementation details exist.  
**Alternatives:** Wait for concrete project identity/architecture before adding docs (not chosen).  
**Consequences:** Faster onboarding for process, but high drift risk until placeholders are resolved and code appears (04, 15). Skills must label confidence carefully (16 #2).

## Inherited tradeoffs

| Tradeoff | Benefit now | Cost / risk |
|---|---|---|
| Template-heavy specs, no implementation | Establishes process vocabulary (commit/release/sense-making) early | Readers may mistake templates for decisions; lockstep names (prefixes, code name) are undefined (15). |
| Separate component repos with initial-only/no commits | Clean starting points per product | No provenance/history to explain intent; root automation cannot span repos without explicit design. |
| Minimal root instructions (`AGENTS.md` files empty) | Avoids premature constraints | Contributors lack verified local guidance until skills/docs and per-repo AGENTS are filled (03, 14). |

## Debt register (ranked)

| Rank | Debt | Evidence | Impact | First mitigation |
|---|---|---|---|---|
| 1 | Project identity/placeholders unresolved (`code-name`, product prefixes, feature names, business-logic fields) | [`argos-specs/git-guidelines.md`](../git-guidelines.md), [`argos-specs/business-logic-v1.0.md`](../business-logic-v1.0.md) | Commits/tags/specs become inconsistent or meaningless; downstream docs copy wrong names. *Miss → rework across repos and invalid release identifiers.* | Define canonical names once, then apply lockstep updates (04 #1, #2). |
| 2 | No implemented architecture/code/contracts | Empty component dirs except stubs/`.git`; no manifests/routes/schema/tests | Cannot validate flows, boundaries, or quality gates. | Record decisions in 01 as they are made; add minimal manifests/CI/tests per component when implementation starts (10, 11). |
| 3 | No root git history and fragmented component histories | Root `git status` fails as non-repo; subrepos at initial/no commits | Hard to audit workspace-level changes and cross-repo coordination. | Decide and document workspace versioning/release coordination strategy (10, 14). |
| 4 | Skills freshness risk in a fast-changing bootstrap phase | Initial skills generation, scaffold state | Stale guidance can mislead as soon as code is added. | Refresh after first real commits/decisions; process `INBOX.md` (00, 14). |
