# Business Logic v1.1 (Proposed)

> Proposed MVP-focused revision of [business-logic-v1.0.md](C:/Users/caduy/Documents/SoftEng1/argos-ecosystem/argos-specs/business-logic-v1.1-proposed.md source baseline: `argos-specs/business-logic-v1.0.md`) for a faster time-to-market. This proposal realigns the specification to the stated product concept, closes MVP-completeness gaps, and explicitly defers non-essential capabilities.

## 1. Positioning (strengthened)

- **Product:** `Argos` (`AG`, AbTech) — a community PUV proximity alert app.
- **Primary platform for MVP:** Android (Kotlin), optimized for commuters on the go. Web may be used later for limited/info or admin surfaces, but MVP delivery focuses on the Android experience.
- **Target users:** Commuters in Eastern Visayas, especially students in Visayas State University (VSU) main campus, including those with changing class schedules and late-night commutes when vehicles are fewer.
- **Core problem:** Waiting for jeepneys/PUVs on unpredictable routes wastes time and creates uncertainty, particularly during off-peak/late hours.
- **Value proposition:** Nearby riders share quick “PUV spotted here” reports; other commuters receive short-lived, approximate proximity alerts so they can decide whether to wait, walk, or take another route.
- **Differentiation/trust:** Reports are anonymous in presentation, location is approximate, sightings expire quickly, visibility is aggregate-based, and no movements are tracked. No points, credits, or monetary rewards.
- **MVP success signal (practical):** A commuter can open the app, see recent nearby sightings/alerts (when available), submit a sighting in a few taps, and receive enough trustworthy signal to make a wait/walk/route decision.

## 2. Gaps identified in v1.0 (to close for a complete MVP)

| Gap | Why it matters for MVP | v1.1 direction |
| --- | --- | --- |
| **Product/entity mismatch** | v1.0 describes PUV proximity alerts, but requirements/features describe “road condition” reports (pothole/flooding/obstruction/accidents). | Replace road-condition entities/flows with **PUV sighting** entities/flows end-to-end. |
| **Core alert loop undefined** | MVP cannot ship without a clear report → validate/aggregate → notify/display → expire loop. | Define minimal sighting submission, nearby alert/feed behavior, expiry, and refresh semantics. |
| **Location & permission basics missing** | Sightings/nearby alerts require location, but consent and handling are unspecified. | Specify foreground location use, approximate display, and explicit permission/consent prompts. |
| **Aggregation/visibility rules incomplete** | “Aggregation threshold” is noted but not defined enough to implement consistently. | Define a simple configurable threshold/window and what users see before/after it is met. |
| **User roles/terminology inconsistent** | “Contributor (residents who submit/confirm road condition reports)” and “Moderator reviews flagged road reports” do not match PUV sightings. | Rename/align roles and permissions to sighting, confirmation, and flagging. |
| **Abuse handling minimal but unclear** | Moderation queue/guideline hits exist, but reportable reasons/actions and effect on visibility are vague. | Keep lightweight: flag sighting/report, moderator hide/remove or apply guideline hit, audit-minimal records. |
| **Privacy/retention stated but not operationalized** | “No per-user trails”, expiry, and retention need enforceable MVP rules. | Specify anonymous public display, minimal stored linkage for abuse control, expiry and deletion/retention behavior. |
| **Admin/ops essentials not scoped** | Tuning (radius/expiry/threshold) and backups are needed to operate MVP. | Include minimal configuration and backup/restore basics; exclude advanced analytics. |

## 3. MVP scope principles (time-to-market)

- **Ship the core loop first:** report sighting → nearby users see timely, approximate alert → sighting expires.
- **Minimize friction:** one-tap/low-input sighting submission; no required photo, no route planning, no rewards.
- **Privacy by default:** approximate location, no public user identity/trails, short-lived data.
- **Configurable but simple:** a few system parameters (expiry, radius, aggregation threshold) instead of complex algorithms.
- **Defer non-essentials:** anything not required for trustworthy nearby alerts, basic abuse control, and operability is out of MVP.

## 4. Proposed user levels (MVP)

| User level | Description | MVP access intent |
| --- | --- | --- |
| A. System Administrator | Maintains server/system configuration, parameters, and backups/restores. | Full system/config access. |
| B. Administrator | Manages general app settings and views essential aggregated operational metrics. | Settings + essential metrics. |
| C. Moderator | Reviews flagged sightings/users reports and applies community-guideline actions. | Moderation queue/actions. |
| D. Signed-in Commuter | Authenticated commuter who can submit, confirm, and flag PUV sightings. | Core contribution actions. |
| E. Guest | Unauthenticated user with limited, low-risk access. | View limited nearby/recent alerts only (no submit/confirm/flag). |

*Note:* “Signed-in Commuter” replaces “Contributor/resident reporting road conditions” to match the PUV-sighting domain. Public sighting display remains anonymous regardless of authentication.

## 5. Concise MVP feature set

| # | Feature | Description (MVP) | Access |
| --- | --- | --- | --- |
| 1 | **Google Sign-In** | Authenticate users for contribution and moderation actions; support sign-out. | D,C,B,A (as applicable) |
| 2 | **Nearby PUV alert feed/map** | Show recent, approximate nearby PUV sightings/alerts (time-since-spotted, coarse area/distance) within a configured radius; guests see limited view. | E,D,C,B,A |
| 3 | **Submit PUV sighting** | Signed-in user submits a sighting at current/selected approximate location with minimal input (default “PUV spotted now”; optional simple type/note only if already trivial to include—otherwise omit). | D,C,B,A |
| 4 | **Confirm sighting still present** | Signed-in user confirms an active nearby sighting to reinforce validity/extend usefulness per rules. | D,C,B,A |
| 5 | **Flag sighting** | Signed-in user flags a false/abusive/misleading sighting for moderator review. | D,C,B,A |
| 6 | **Moderation queue & guideline actions** | Moderator reviews flagged items and can dismiss, hide/remove sighting, or apply a guideline hit/action per policy (minimal workflow). | C,B,A |
| 7 | **Essential configuration & ops** | Configure key parameters (expiry duration, proximity radius, aggregation threshold, retention limit) and perform basic backup/restore of system data. | B (settings/metrics, limited) / A (full + backups) |
| 8 | **Privacy & data handling controls** | Enforce anonymous public display, approximate location, expiry, retention/deletion, and no per-user movement trails in product behavior. | System-wide (all roles) |

## 6. Key MVP rules and flows

### 6.1 Sighting lifecycle (core loop)
1. Signed-in commuter submits a PUV sighting (approximate location, timestamp).
2. Sighting is stored with expiry time; confirmations can indicate it is still present (within rules) but do not create permanent history.
3. App shows active sightings/alerts to users within configured proximity as **approximate** signals (no precise tracking, no public identity).
4. Sighting expires after the configured duration (and/or becomes inactive) unless validly re-confirmed per configured rules.
5. Data is deleted after the configured retention limit.

### 6.2 Aggregation and visibility (simple, configurable)
- A sighting/alert becomes broadly visible only after the configured **aggregation/confirmation threshold** is met within the active time window (to reduce false/noisy reports).
- Before threshold is met, the system may keep the report non-public or minimally visible only as needed for confirmation logic—implementation must avoid exposing individual movement trails.
- Exact threshold/window values are configuration, not hardcoded product constants.

### 6.3 Privacy and security baseline (MVP must-haves)
- Request and use **location permission transparently**; collect/use location only as needed for nearby alerts and sighting submission.
- Show **approximate** location/proximity to users; do not expose reporter identity or per-user location history.
- Apply **expiry and retention limits**; avoid storing data longer than necessary for MVP operation/moderation.
- No points, credits, monetary rewards, or public reputation/leaderboards.
- Abuse handling via **flags and guideline hits/actions**, not social scoring.

### 6.4 Moderation (lightweight)
- Inputs: flagged sightings (reason categories kept minimal, e.g. false/spam/abusive).
- Actions: dismiss flag, hide/remove sighting, record/apply guideline hit per policy.
- Goal: protect alert quality and safety with minimal operational overhead.

## 7. Explicitly out of scope for MVP (defer)

- Real-time vehicle tracking, route prediction/ETA, or transport operator integrations.
- Photos/media uploads, comments/chat, social features, or user profiles beyond basic auth identity.
- Rewards, points, credits, gamification, or public contribution reputation.
- Advanced analytics dashboards, data resale/sharing workflows, or complex reporting exports.
- Multi-city/complex route management features beyond basic proximity-based alerts.
- Full web parity; iOS app; offline-first guarantees beyond basic graceful handling.

## 8. Open decisions to confirm (kept minimal)

- Whether guests can view any alerts without sign-in or only a very limited teaser (balance friction vs. abuse/privacy).
- Default/configurable values for expiry, radius, aggregation threshold, and retention (to be set during implementation/testing).
- Whether a sighting needs an optional coarse vehicle/category label in MVP or can remain a generic “PUV spotted” signal for simplicity.
- Minimal guideline-hit policy details (thresholds/consequences) required for moderator action.

## 9. Summary of v1.1 changes vs v1.0

- Realigns requirements, features, and roles from road-condition reporting to **PUV proximity sighting alerts** (matching the product description).
- Defines a complete, minimal MVP core loop (submit/confirm/flag → aggregate/show nearby → expire/delete) with privacy-by-design constraints.
- Strengthens positioning around VSU/Eastern Visayas commuter pain, fast decision support, and trust (anonymous/approximate/short-lived/no rewards).
- Keeps scope concise for faster time-to-market by deferring tracking, media, social/gamification, and advanced analytics/integrations.
