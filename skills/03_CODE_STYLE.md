# 03 — Code Style

**Purpose:** Commenting intent, tooling status, naming/error/logging guidance (current and pending), commit conventions, preferred/anti-patterns. Read before writing code or docs.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00. Evidence sources: [`argos-specs/git-guidelines.md`](../git-guidelines.md), [`handoff.md`](../../handoff.md), component `README.md` files, empty `AGENTS.md` files, and absence of code/manifests/linters/tests in all components. Subrepo HEADs: `argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits. The code wins (see 16).

## Comment philosophy (the why, at the line)

| Context | Rule | Why / what breaks |
|---|---|---|
| Skills/spec docs (this repo) | Write the *why* and name what breaks; keep procedures concrete (files/commands/error codes when known) (see `handoff.md`). | Newcomers can read code but not incident history or rejected alternatives. *Miss → repeated mistakes and cargo-cult guards.* |
| Future implementation code | Comment non-obvious intent, invariants, workarounds, and risk at the relevant line/block; avoid narrating obvious syntax. | Self-evident comments rot quickly; missing rationale hides constraints. *Miss → "cleanup" refactors remove needed guards.* |
| Generated/template placeholders | Do not leave `<placeholder>` / `code-name` / `...` tokens as if resolved; mark pending decisions explicitly. | Templates can be mistaken for real values (15). *Miss → wrong scopes/tags/requirements propagated (04 #1, #2).* |

## Tooling (verified state)

| Area | Observed | Implication |
|---|---|---|
| Linters/formatters | None found (no ESLint/Prettier/ktlint/detekt/ruff/etc. configs or manifests) | No automated style enforcement yet. *Miss → inconsistent style once code lands; add tooling per component early (11, 13).* |
| Build/package managers | None found (`package.json`, Gradle files, Maven, etc. absent) | No standard build/test commands available. |
| CI | No `.github/workflows/` or other CI configs found | No automated checks on commits/PRs. *Miss → regressions and convention drift go unnoticed (10, 11).* |
| Git hooks | Only sample hooks in `.git/hooks/*.sample` inside subrepos (default, inactive) | No enforced commit-message validation observed. *Miss → nonconforming commits/tags.* |

## Naming conventions

| Domain | Convention / signal | Evidence | Notes |
|---|---|---|---|
| Component folders | `argos-api`, `argos-web`, `argos-android`, `argos-specs` | Workspace layout (02) | Stable component identity. |
| Skills docs | `NN_TOPIC.md`, stable numbering, `INBOX.md` | `handoff.md` | Append, never renumber on refresh (00). |
| Commit scopes (documented) | Prefer `code-name-api/<feature>:`, `code-name-web/<feature>:`, `code-name-app/<feature>:`, `code-name-specs/<feature>:`, or product-level/general scopes as defined | [`argos-specs/git-guidelines.md`](../git-guidelines.md) | **Placeholders unresolved:** `code-name`, `<feature1>/<feature2>`; app prefix text uses `code-name-app` for Android (verify before use). *Miss → ambiguous history and wrong release mapping (04 #1).* |
| Release tags (documented) | `<prefix>.0X.Y.00Z` with product prefixes `WCN/BCN/ACN/SCN` and pre-release suffixes `a/b/rc` (+iteration) | [`argos-specs/git-guidelines.md`](../git-guidelines.md) Part 2 | Tag tables are empty; "next release" baselines shown as `*.01.0.001`. *Miss → out-of-order or invalid tags (04 #2, 10).* |

## Error handling and logging

- **Verified:** No runtime code, logging configuration, or error envelopes exist in this workspace.
- **Rule (pending implementation):** Define per-component error handling/logging patterns where code lives and document them here with concrete file/function/logger names. *Miss → inconsistent client behavior and hard-to-debug failures (05, 08).*
- **Specs/docs:** When documenting failures or commands, include exact messages/exit codes observed (05, 16 #2).

## Commit conventions (from `git-guidelines.md`, verified as documented)

| Rule | Requirement | Why / what breaks |
|---|---|---|
| Subject format | `scope: Imperative summary` (≤ 50 chars summary, sentence case, no period) | Tooling/readability; unclear history. *Miss → future maintainers cannot infer intent from `git log`.* |
| Scope choice | Prefer specific product/subsystem or documented general scopes; split commits if multiple independent scopes | Preserves atomic history and traceability. |
| Body/references | Optional but encouraged; blank line before body; include human-readable ticket descriptions with refs | Diff shows *what*; body should explain *why*. |
| Breaking changes | `!` after scope and `BREAKING CHANGE:` trailer when applicable | Signals migration/compat risk. *Miss → consumers break without warning (04, 10).* |
| AI authorship | "Any AI agent should not be added as author of any commits, tags, releases, or PRs." | Explicit project policy in guidelines. *Miss → policy violation and audit confusion.* |
| No generic/vague commits | Avoid vague summaries, ticket-only subjects, multi-purpose commits (examples in guidelines) | Harms bisect/review/release notes. |

**Caveat:** Guidelines contain placeholder identity tokens and are not yet evidenced by real commits in these repos (subrepos only have `Initial commit`; `argos-specs` has none). Treat as policy intent until validated in practice.

## Preferred patterns (current)

| Pattern | Why |
|---|---|
| Document decisions and rules next to the spec/guideline that owns them; cross-link by doc number (00–16) | Keeps rationale discoverable and refreshable. *Miss → duplicated, conflicting guidance.* |
| Verify paths/names/commands against the workspace before recording them | Prevents stale instructions in a scaffold that will change quickly (16 #2). |
| Small, scoped changes per component repo (when committing) | Matches separate-repo architecture and commit-scope policy (01, git-guidelines). |

## Anti-patterns and costs

| Anti-pattern | Cost / why banned (or to ban) | Status |
|---|---|---|
| Treating template placeholders as finalized project identity | Invalid tags/scopes/spec claims; rework across all docs/repos | Observed risk (15) |
| Editing the wrong component repo / assuming root is a git repo | Lost history, wrong remotes, release confusion | Observed risk (01, 05) |
| Adding secrets/credential values to docs or code | Security incident and forced rotation | Prohibited (09, handoff) |
| Large mixed-scope commits spanning unrelated concerns | Hard review, revert, and release classification | Prohibited by guideline intent |
| Creating skills/planning files without confidence labels or evidence | Teaches wrong things confidently | Prohibited by handoff/16 |

## Commit conventions checklist (before committing, per component repo)

1. Confirm you are in the intended repo: `git -C <component> rev-parse --show-toplevel` and `git -C <component> remote -v`. *Miss → commit lands in wrong history.*
2. Choose a resolved, project-correct scope (no unresolved `code-name` placeholders). *Miss → noncompliant/ambiguous commit subject (04 #1).*
3. Write imperative, specific summary; add body for non-trivial rationale; include refs with descriptions. *Miss → untraceable changes.*
4. Do not add AI co-author/author trailers unless policy changes; follow repo policy. *Miss → guideline violation.*

Add surprises to [INBOX.md](INBOX.md).
