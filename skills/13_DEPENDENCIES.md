# 13 — Dependencies

**Purpose:** Dependency policy and inventory (reason, upgrade traps, deliberate rejections). Read before adding or upgrading libraries/tools.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00. Searched for dependency manifests/lockfiles (`package.json`, `pnpm-lock.yaml`, `yarn.lock`, `requirements*.txt`, `Pipfile`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `pom.xml`, `build.gradle*`, `gradle/libs.versions.toml`, etc.) and CI/tooling configs; none found. Subrepo HEADs: `argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits. The code wins (see 16).

## Policy (current baseline)

| Rule | Why / what breaks |
|---|---|
| Add dependencies only when needed for the task; prefer existing platform/ecosystem capabilities once stacks are chosen | Reduces attack surface, maintenance, and upgrade risk. *Miss → unnecessary supply-chain and compatibility burden.* |
| Record each non-trivial dependency here (reason, version constraints, upgrade traps, owner/context) at introduction time | Future maintainers need to know why it exists and what breaks on upgrade. *Miss → cargo-cult dependencies and risky blind upgrades (06).* |
| Pin/lock versions according to component ecosystem conventions (once established) and review transitive impacts | Reproducible builds and controlled updates. *Miss → "works on my machine" and surprise breakage in CI/deploy (10, 11).* |
| Evaluate license, security posture, and maintenance health before adoption | Legal/compliance and vulnerability exposure risks (09). *Miss → blocked releases or emergency remediation.* |
| Do not add dependencies just to create artifacts for skill/documentation output | Violates minimal-change principle and pollutes repos. *Miss → noise and maintenance cost without product value.* |

## Inventory

| Dependency | Component | Version / constraint | Reason | Upgrade traps | Status |
|---|---|---|---|---|---|
| — | — | — | — | — | No dependencies declared |

## Tooling/runtime prerequisites (observed externally, not declared)

| Tool | Evidence | Notes |
|---|---|---|
| Git | `.git/` present in all component dirs; git commands used for inspection | Required for per-repo history/remote operations (01, 05). Versions/config not recorded. |
| Windows PowerShell | Environment context (current session) | Shell syntax differs from Bash; commands in docs must be compatible or labeled (05). |
| Language runtimes/build tools (Node/Java/Kotlin/Android SDK/Python/etc.) | Not found/declared | Choose and document per component when implementation starts (02, 10, 11). |

## Deliberate rejections

None recorded. When a dependency/tool is evaluated and rejected, document: alternative chosen, reason, and conditions that would justify revisiting. *Miss → repeated evaluation churn and inconsistent choices across components.*
