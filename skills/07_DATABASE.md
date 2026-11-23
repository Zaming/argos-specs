# 07 — Database

**Purpose:** Identity strategy, constraints, deletes, table map, migration strategy, integrity invariants, dangerous operations, and indexing. Read before designing or changing persistent data.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00. Searched for schema/migration/database artifacts (`*.sql`, `migrations/`, `schema`, ORM configs, `prisma`, `typeorm`, `flyway`, `alembic`, etc.) in all components; none found. `argos-api/README.md` mentions "database API" conceptually but no implementation exists. Subrepo HEADs: `argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits. The code wins (see 16).

## Current state

**Not implemented.** No database engine, schema, migrations, seed data, repositories/ORM models, or data-access configuration were found in this workspace.

## Required topics (to fill when data storage is introduced)

| Topic | Current evidence | Guidance until implemented |
|---|---|---|
| Identity strategy | None | Decide and document PK/UUID/ULID strategy, generation location, and external ID exposure rules. *Miss → conflicting IDs across services/clients and hard migrations.* |
| Constraints | None | Define PK/FK/unique/check/not-null constraints in schema and document intent. *Miss → silent data corruption and duplicate records.* |
| Deletes | None | Specify hard vs soft delete, cascade rules, retention, and audit implications per table. *Miss → data loss, orphaned rows, or privacy/retention violations (09, 15).* |
| Table map | None | Maintain a table/module ownership map with key columns and relationships. *Miss → changes break hidden consumers.* |
| Migration strategy | None | Choose tooling, naming/order, forward/rollback policy, and environment apply process. *Miss → schema drift between environments and failed deploys (10).* |
| Integrity invariants | None | Document invariants that code must preserve (e.g. uniqueness, state transitions, aggregates). *Miss → subtle bugs not caught by type checks (06, 11).* |
| Dangerous operations | None | List high-risk ops (drops, rewrites, backfills, lock-heavy migrations) with safeguards and approvals. *Miss → outages or irreversible data loss.* |
| Indexing | None | Record query-driven indexes and write-cost tradeoffs; tie to measured hot paths (12). *Miss → slow queries or unnecessary write amplification.* |

## Cross-component implications (inferred, pending verification)

- `argos-api` README implies mediation between clients and data; when implemented, DB contracts will become a lockstep dependency with API and possibly client expectations (01, 04, 08).
- `argos-specs/business-logic-v1.0.md` includes "Security and privacy by design..." as a required solution layer (template text); any future schema must encode retention/protection decisions explicitly (09). *Miss → noncompliant data handling discovered late.*

## Verification checklist (when first DB work lands)

1. Add schema/migration locations and commands to this doc and 14.
2. Record lockstep sets (migrations ↔ models ↔ API/contracts ↔ tests) in 04.
3. Add backup/restore and migration safety steps to 10/11 as applicable.
4. Update [00_INDEX.md](00_INDEX.md) confidence/changelog.
