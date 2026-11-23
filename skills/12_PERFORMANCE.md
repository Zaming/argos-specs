# 12 — Performance

**Purpose:** Hard limits, hot paths, deliberate inefficiencies to leave alone, expensive operations, and profiling. Read before optimizing or setting SLO-like expectations.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00. No application/runtime code, benchmarks, load tests, profiling configs, query plans, or production telemetry were found in any component. Subrepo HEADs: `argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits. The code wins (see 16).

## Current state

**Not applicable / not measurable.** There are no implemented services, clients, databases, or workloads to profile in this workspace.

## Hard limits

None defined or enforced. *Miss → premature assumptions about throughput/latency/size limits that later conflict with architecture or platform constraints.*  
**When introduced:** document concrete limits (request size, rate limits, pagination caps, DB/query timeouts, mobile memory/network budgets) with config keys and enforcement locations.

## Hot paths

None known. **Inferred candidates (pending implementation):** authentication/session handling, primary list/detail API endpoints, sync flows, and startup/render paths in web/mobile clients. *Miss → optimizing non-critical code while real bottlenecks remain unmeasured.*

## Deliberate inefficiencies to leave alone

None recorded. If a future tradeoff favors clarity, safety, or correctness over speed (e.g. extra validation, audit logging, conservative retries), record it here with the measured cost and reason so it is not "optimized away." *Miss → regressions in security/correctness for negligible gains (06, 09).*

## Expensive operations

None implemented. **Future watchlist (inferred):** database migrations/backfills, full-table scans/unindexed queries, large file/media processing, cold-start initialization, and cross-repo CI/release workflows. *Miss → outages or slow deploys when these appear without safeguards (07, 10).*

## Profiling

| Area | Tooling / method | Status |
|---|---|---|
| API/backend | APM/profiler/tracing not selected | Not configured |
| Web frontend | Browser/devtools profiling baselines | Not configured |
| Android | Android Profiler/perf benchmarks | Not configured |
| Database | Query plans/index stats monitoring | Not configured |

**Guidance:** before optimizing, capture a baseline with reproducible inputs and document command/config/file locations. *Miss → "optimizations" with no evidence and possible regressions (11, 16 #2).*
