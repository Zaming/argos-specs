# 08 — API

**Purpose:** Response envelope, route inventory with auth, how to add an endpoint, existing validators, versioning, and common mistakes. Read before designing or changing client-server contracts.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00. Inspected `argos-api/` (only `README.md`, `AGENTS.md`, `.git/`) and `argos-web/`/`argos-android/` for routes/controllers/clients/OpenAPI specs; none found. `argos-api/README.md` states it "communicates between the database API and the  web/Android clients for Argos" (typos as-is). Subrepo HEADs: `argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits. The code wins (see 16).

## Current state

**Not implemented.** No HTTP routes, handlers, controllers, RPC definitions, OpenAPI/GraphQL schemas, request/response DTOs, validators, auth middleware, or API client code were found.

## Response envelope

Unknown / not defined. *Miss → clients implement ad-hoc parsing and error handling diverges per endpoint.*  
**When introduced:** document a single canonical envelope (success/data/error shape, pagination, request IDs) with concrete types and example payloads; record locations in 04 as a lockstep set.

## Route inventory (with auth)

| Method | Path | Auth | Handler | Status |
|---|---|---|---|---|
| — | — | — | — | No routes implemented |

**Spec intent (template, not verified implementation):** `argos-specs/business-logic-v1.0.md` requires Google Sign-In integration (System Requirement #1) and lists feature/access placeholders. *Miss → assuming auth/authorization exists because it is mentioned in a template.*

## How to add an endpoint (future procedure template)

1. Define contract (method/path/request/response/errors/auth) in spec or API contract artifact and update 08 inventory. *Miss → undocumented endpoints and client drift.*
2. Implement handler/controller and wire routing in `argos-api/` (exact paths TBD). *Miss → endpoint unreachable or misrouted.*
3. Add validation and auth checks at the boundary (09). *Miss → invalid input or unauthorized access reaches business logic.*
4. Update persistence/service logic and migrations if needed (07). *Miss → runtime errors or inconsistent data.*
5. Add/update tests and client integrations (11; `argos-web`, `argos-android`). *Miss → regressions across components.*
6. Record lockstep dependencies in 04 and add workflow notes to 14.

Add surprises to [INBOX.md](INBOX.md).

## Existing validators

None found. When added, list validator modules/functions, shared schemas, and error formats here. *Miss → duplicated validation logic with inconsistent behavior.*

## Versioning

- **API versioning:** not defined in code/specs (beyond placeholder commit/tag conventions in `git-guidelines.md`).
- **Breaking-change signaling:** follow commit convention `!` and `BREAKING CHANGE:` trailer for API-affecting commits when applicable (03). *Miss → clients deploy incompatible changes without migration notice.*

## Common mistakes (preventive, pending real API)

| Mistake | Why costly | Prevention (once applicable) |
|---|---|---|
| Implementing endpoints without updating 08/contract inventory | Clients and testers guess behavior | Treat inventory/docs as lockstep with route definitions (04). |
| Mixing authn/authz rules across layers without a single source | Privilege leaks or inconsistent denials | Centralize policy checks; document layers in 09. |
| Returning inconsistent error shapes/codes | Fragile client handling and poor observability | Standardize envelope/error codes and log correlation IDs. |
| Assuming template business-logic access matrix is enforced | Unauthorized feature exposure | Verify enforcement in code and tests, not docs alone (09, 11). |
