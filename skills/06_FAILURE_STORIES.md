# 06 — Failure Stories

**Purpose:** Numbered incident reconstructions with what happened, why, how found, fix, and lesson. Read to avoid repeating known failures; link from 04/05/16 where relevant.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00. Investigated sources: root/component file inventory, `README.md`/`AGENTS.md`/spec docs, and git metadata in each component repo (`argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits). No git history beyond initial/no commits, no issue tracker exports, no runtime logs, and no `TODO/FIXME/HACK/workaround/legacy` markers were found in non-.git files during this scan. The code wins (see 16).

## Incidents

No verified incidents or production/runtime failures are recorded in this workspace.

| # | Status | Notes |
|---|---|---|
| — | None recorded | Absence of stories reflects scaffold state, not proof that failures never occurred elsewhere. |

## How to add a failure story (required fields)

When an incident is discovered or occurs, add a numbered entry (append-only) with:

1. **What happened:** observable impact, scope, and timeline (include exact error messages/codes where available).
2. **Why:** root cause and contributing factors; name concrete files/functions/config/commands.
3. **How it was found:** logs, alerts, tests, user report, `git log`/bisect, etc.
4. **Fix:** what changed, where (paths/commits/tags), and why it prevents recurrence.
5. **Lesson:** generalizable rule; link to the enforcing lockstep set (04), diagnostic path (05), and/or principle (16).
6. **Confidence in reconstruction:** verified / inferred / suspected, with evidence.

*Miss → the same incident pattern recurs because the preventative knowledge stays tribal or gets reintroduced during refactors.*

## Related links

- Prevention rules: [04_CHANGE_RULES.md](04_CHANGE_RULES.md)
- Diagnosis: [05_DEBUGGING_PLAYBOOK.md](05_DEBUGGING_PLAYBOOK.md)
- Principles promoted from incidents: [16_ENGINEERING_PRINCIPLES.md](16_ENGINEERING_PRINCIPLES.md)
- Unverified leads: [INBOX.md](INBOX.md)
