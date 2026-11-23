# 14 — Developer Workflows

**Purpose:** Setup and step-by-step recipes for common tasks in the current scaffold, with links to lockstep sets and failure-story guidance. Read when starting work or performing routine operations.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00 (Windows PowerShell environment). No build/test/run tooling or app code exists; recipes focus on verified inspection and documentation workflows. Subrepo HEADs: `argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits. The code wins (see 16).

## Setup (current state)

1. Open workspace root: `C:\Users\caduy\Documents\SoftEng1\argos-ecosystem`.
2. Confirm tool availability as needed: `git --version` (used by components), PowerShell 5.1+ compatible commands.
3. Read [00_INDEX.md](00_INDEX.md), [01_ARCHITECTURE.md](01_ARCHITECTURE.md), and [04_CHANGE_RULES.md](04_CHANGE_RULES.md) before cross-cutting edits.
4. **No package install/build bootstrap exists yet** (no manifests). *Miss → running guessed install commands can create unwanted files or fail noisily; add setup steps per component when manifests appear (13, 10).*

## Recipes

### Recipe 1 — Orient yourself in the ecosystem
**Use when:** starting any task.
1. List component states: `Get-ChildItem -Force` at root and in target component(s).
2. Inspect git per component (root is not a repo): `git -C argos-api status -sb`, repeat for `argos-web`, `argos-android`, `argos-specs` (05). *Miss → wrong-repo edits/commits (04, 01).*
3. Read relevant READMEs/specs/skills for the target area (00, 02).
4. Identify if the task touches a lockstep set (04). *Miss → partial updates and drift.*

Add what surprised you to [INBOX.md](INBOX.md).

### Recipe 2 — Execute or refresh skills documents (`argos-specs/skills/`)
**Use when:** running `handoff.md`, onboarding knowledge, or fixing stale guidance. Guards: 04 #3, 16 #1-#2.
1. Read [`handoff.md`](../../handoff.md) and required context files (root/custom instructions; component/spec docs as applicable).
2. Investigate current state: file tree, manifests/configs, git logs/remotes/branches per component, and any CI/tests (05). *Miss → documenting assumptions instead of evidence.*
3. Create/update `NN_TOPIC.md` files and `INBOX.md` without renumbering; include required headers and concrete evidence.
4. Update [00_INDEX.md](00_INDEX.md) inventory, reading guidance, and append changelog entry. *Miss → navigation and freshness become misleading (04 #3).*
5. Spot-check referenced paths/names/commands. *Miss → broken instructions on day one (16 #2).*

Add what surprised you to [INBOX.md](INBOX.md).

### Recipe 3 — Resolve project identity placeholders (spec/process alignment)
**Use when:** replacing `code-name`, prefixes, `<feature*>`, business-logic template fields. Guards: 04 #1, #2.
1. Record the canonical decision in [01_ARCHITECTURE.md](01_ARCHITECTURE.md) (decision record format).
2. Search for all affected tokens: `Select-String -Path argos-specs\*.md,argos-specs\skills\*.md -Pattern 'code-name|<feature|<Code Name>|<short-code>|WCN|BCN|ACN|SCN'` (adjust as needed). *Miss → mixed identity remains in untouched files.*
3. Update all lockstep locations in one change set where possible (04 #1/#2); keep semantics consistent.
4. If outputs depend on business logic (e.g. `argos-specs/sense-making.md` workflow), update or mark dependent artifacts/folders accordingly. *Miss → downstream planning artifacts become stale.*
5. Re-verify by searching for old tokens and reviewing diffs.

Add what surprised you to [INBOX.md](INBOX.md).

### Recipe 4 — Safe git operations in this multi-repo workspace
**Use when:** committing, branching, tagging, or inspecting history. Guards: 01 boundaries, 03 commit rules, 04 hidden dependencies, 10.
1. Identify the correct component repo and `cd`/use `git -C <component>` explicitly. *Miss → commit/tag in wrong repo (05 symptom).*
2. Check state: `git -C <component> status`, `log --oneline -n`, `remote -v`, `branch -a`.
3. For commits, follow `argos-specs/git-guidelines.md` scope/summary/body/ref rules and policy constraints (03). *Miss → noncompliant history.*
4. For tags/releases, follow timing and format rules in 10 and guidelines; never retag existing tags. *Miss → invalid release chronology/identifiers.*
5. Because `argos-specs` currently has no commits, confirm intended first-commit content before creating history. *Miss → accidental initial commit of wrong files.*

Add what surprised you to [INBOX.md](INBOX.md).

### Recipe 5 — Introduce first implementation in a component (future)
**Use when:** adding real code/tooling to `argos-api`, `argos-web`, or `argos-android`. Guards: 02, 04, 07–13 as applicable.
1. Define stack, directory layout, manifests, and `.gitignore` in the target component repo; document in 02/13.
2. Add minimal build/lint/test commands and CI; document in 03/10/11/14. *Miss → no repeatable validation path.*
3. If adding contracts/data/auth, update 07/08/09 and lockstep sets in 04 in the same change series. *Miss → cross-repo drift and integration failures.*
4. Run the smallest relevant validation and record results/evidence. *Miss → false confidence.*
5. Refresh affected skills docs and [00_INDEX.md](00_INDEX.md).

Add what surprised you to [INBOX.md](INBOX.md).
