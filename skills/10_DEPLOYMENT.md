# 10 — Deployment

**Purpose:** Release order across components, how each deployable ships and what it needs, tags, and a release checklist. Read before building, tagging, or shipping.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00. Evidence: [`argos-specs/git-guidelines.md`](../git-guidelines.md) (Part 2, Release Tags), component repo states/remotes, and absence of CI/CD configs, build artifacts, deployment manifests, or environment definitions. Subrepo HEADs: `argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits. The code wins (see 16).

## Current state

**No deployables or deployment pipelines verified.** Components contain stubs only; release/tag tables in `git-guidelines.md` are empty and next-release baselines are templated.

## Release order across components

Not defined. **Inferred risk:** because `argos-api`, `argos-web`, and `argos-android` are separate repos and likely coupled by contracts (01, 08), release ordering/compatibility must be decided explicitly once implemented. *Miss → clients ship against incompatible API versions or uncoordinated schema changes.*

## How each deployable ships and what it needs

| Component | How it ships | Prereqs / config | Status |
|---|---|---|---|
| `argos-api` (BCN per guidelines) | Unknown | Runtime, env vars/secrets, DB/migrations, build pipeline not defined | Not implemented |
| `argos-web` (WCN per guidelines) | Unknown | Build toolchain, hosting, API base URL/config, auth config not defined | Not implemented |
| `argos-android` (ACN per guidelines) | Unknown | Android build/signing/distribution, API/auth config not defined | Not implemented |
| `argos-specs` (SCN per guidelines) | Spec revisions/tags (documented concept) | Review/approval workflow for baseline; no commits yet in repo | Process documented, not practiced |

## Tags and versioning (documented in `git-guidelines.md`)

| Topic | Documented rule | Verified practice in this workspace |
|---|---|---|
| Format | `<prefix>.0X.Y.00Z` (`WCN/BCN/ACN/SCN`) with pre-release `a/b/rc` iterations | No tags recorded in guideline tables; no evidence of tag creation in observed histories |
| Cadence | Weekly `00Z` increments per commit-containing week; tag only after Friday 17:00 local; no retag/move | Not practiced (initial/no-commit repos) |
| Promotion/maintenance | Major/minor/patch semantics, candidate flow, post-production maintenance lifecycle | Not applicable yet |
| Repo-level tags | Each component repo tagged independently (implied by separate repos/prefixes) | **Unverified operational detail**; confirm per-repo convention before first tag. *Miss → tags created in wrong repo or wrong prefix mapping.* |

## Release checklist (scaffold-aware)

1. **Confirm target repo and branch:** `git -C <component> status -sb`, `remote -v`, `log -1`. *Miss → tag/release in wrong repository (01, 05).*
2. **Confirm identity/prefix mapping is finalized:** no unresolved `code-name`/prefix placeholders for the release being cut (04 #1). *Miss → invalid or ambiguous release identifiers.*
3. **Confirm timing/cadence rules:** ISO week, commits present, Friday 17:00 local passed, no existing tag for week (per guidelines). *Miss → noncompliant tag history.*
4. **Verify quality gates:** run relevant build/lint/tests and approvals for the component (11). *Miss → shipping unverified artifacts (currently no gates exist).*
5. **Document/tag correctly:** create annotated tag on the intended commit (per component policy), update `git-guidelines.md` release tables if that is the chosen record, and record changes in relevant docs. *Miss → undocumented releases and drift.*
6. **Coordinate dependents:** check API/client/spec compatibility and release order (01, 04, 08). *Miss → broken integrations.*

## Future deployment needs (to define before first ship)

- Environment matrix (dev/stage/prod), secret management, and config sources (09).
- CI/CD pipelines per component, artifact storage, signing/distribution (Android), and rollback strategy.
- Database migration/deploy sequencing and backup/restore verification for `argos-api` if applicable (07).
- Monitoring/logging/alerting and incident response hooks (05, 06).
