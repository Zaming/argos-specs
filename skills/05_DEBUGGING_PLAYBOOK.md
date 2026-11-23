# 05 — Debugging Playbook

**Purpose:** Where to look for evidence and how to diagnose common issues in the current scaffold. Read when something is missing, inconsistent, or a command fails.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00 (Windows environment; root not a git repo). Commands below were chosen for this workspace state; no application logs/services/tests exist. Subrepo HEADs: `argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits. The code wins (see 16).

## Where the logs are

| Source | Location | Status |
|---|---|---|
| Application/runtime logs | N/A (no implemented apps/services) | Not present. *Miss → debugging must rely on git state, file inspection, and command output until runtime logging exists.* |
| Build/test/CI logs | N/A (no build/test/CI configs) | Not present. |
| Git history (per component) | `argos-api/.git`, `argos-web/.git`, `argos-android/.git`, `argos-specs/.git` | Present; histories are minimal/empty (see symptoms below). |
| Skills/spec evidence | `argos-specs/*.md`, `argos-specs/skills/*.md`, component `README.md`/`AGENTS.md` | Present; many placeholders/templates. |

## Symptom → causes → diagnostics

### Symptom: `fatal: not a git repository (or any of the parent directories): .git`
**Where observed:** Running git at workspace root (`C:\Users\caduy\Documents\SoftEng1\argos-ecosystem`).  
**Likely causes (by frequency):**
1. Command executed in root, but root is intentionally not a git repo (verified).
2. Wrong working directory when intending to operate on a component repo.

**Diagnostic shortcut:**
```powershell
git -C argos-api status -sb
git -C argos-web status -sb
git -C argos-android status -sb
git -C argos-specs status -sb
```
*Miss → assuming git is "broken" and reinitializing the wrong location, fragmenting history further (01, 04).*

### Symptom: `fatal: your current branch 'main' does not have any commits yet`
**Where observed:** `git -C argos-specs log --oneline -10`.  
**Likely causes:**
1. `argos-specs` repository has no commits on `main` (verified).
2. Looking at wrong branch/repo.

**Diagnostic shortcut:**
```powershell
git -C argos-specs branch -a
git -C argos-specs remote -v
Get-ChildItem argos-specs -Force
```
*Miss → treating missing log as data loss; avoid destructive git operations without evidence.*

### Symptom: "File not found" / missing expected docs, code, or folders
**Examples:** `argos-specs/planning/sense-making.csv` target folder not present; no `src/`, manifests, CI, or tests anywhere.  
**Likely causes:**
1. Feature/artifact not implemented yet (common in current scaffold).
2. Looking in wrong component (separate repos/boundaries).
3. Path assumption from template (e.g. `*-specs/planning/...` in `sense-making.md`) not materialized.

**Diagnostic shortcut:**
```powershell
Get-ChildItem -Recurse -Force -File | Select-Object FullName
Get-ChildItem argos-specs\planning -Force 2>&1
```
*Miss → creating duplicate structures in wrong locations; confirm intended home per 02/04 before adding files.*

### Symptom: Inconsistent project identity (e.g. `code-name`, `CN`, `<feature1>`, `<Team Name>`)
**Where observed:** `argos-specs/git-guidelines.md`, `argos-specs/business-logic-v1.0.md`.  
**Likely causes:**
1. Templates not yet customized (verified).
2. Partial manual replacement.

**Diagnostic shortcut:**
```powershell
Select-String -Path argos-specs\*.md -Pattern 'code-name|<feature|<Team Name>|<Code Name>|<short-code>|^# .*<|xxx|\.\.\.' -Context 0,0
```
*Miss → new commits/tags/docs propagate unresolved placeholders (04 #1, #2).*

### Symptom: PowerShell command syntax errors or unexpected parsing
**Likely causes:**
1. Using Bash heredoc/`&&`/Unix-only syntax in Windows PowerShell 5.1+ context.
2. Assuming `grep`/`sed` behavior differs from PowerShell cmdlets.

**Diagnostic shortcut:** prefer PowerShell-native commands (`Select-String`, `Get-Content`, `Get-ChildItem`) or `git -C <path> ...`; check tool/environment notes.  
*Miss → wasted iterations and misleading partial output.*

## Useful commands (verified applicable)

| Goal | Command (PowerShell, from workspace root) | Notes |
|---|---|---|
| Inspect all component git states | `foreach($r in 'argos-api','argos-web','argos-android','argos-specs'){ "`n=== $r ==="; git -C $r status -sb; git -C $r log --oneline -5 }` | Run components individually if one errors (e.g. no commits). |
| Find placeholders/drift tokens | `Select-String -Path argos-specs\*.md,arg os-specs\skills\*.md -Pattern 'code-name|<feature|<Platform>|TODO|FIXME|HACK|TBD'` | Adjust path/pattern as needed. |
| Inventory files quickly | `Get-ChildItem -Recurse -Force -File | Where-Object { $_.FullName -notmatch '\\.git\\' } | Select-Object FullName` | Excludes most noise; inspect `.git` separately when needed. |
| Verify a documented path exists | `Test-Path <path>; Get-Item <path>` | Do before asserting in docs (16 #2). |
| Read large docs in chunks | `Get-Content <file> -TotalCount N` / `-Tail N` | Use when `view` reports file too large. |

## Escalation / when to stop

- If diagnosis requires secrets, external systems, or repository access not available in this workspace, record evidence and ask the user (environment limitations). *Miss → guessing can create incorrect docs or unsafe actions.*
- Add newly discovered symptoms/fixes to [INBOX.md](INBOX.md) or 05 during the same change when verified.
