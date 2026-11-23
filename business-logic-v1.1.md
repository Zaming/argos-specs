# Business Logic

> Development of an `Android-based` `Community PUV Proximity Alert App` using `Kotlin` for `Commuters in Eastern Visayas, especially Students in Visayas State University`.

- Allowed Platforms: Web, Android (MVP delivery focuses on the Android app)

## Project Details

- Company/Startup/Team Name: `AbTech`
- Project Code Name: `Argos`
- Project Short Code: `AG`
- Short Description: `Commuters anonymously report where a jeepney or PUV is spotted, and nearby riders get short-lived, approximate alerts.`
- Long Description: `Waiting for a ride along unpredictable routes wastes commuters' time, especially for students whose class schedules change often and who may finish late at night when fewer vehicles are on the road. This app lets signed-in commuters submit a quick "PUV spotted" report at an approximate location, and the report expires after a configured short duration. Nearby commuters, including students heading home after late classes, see recent approximate proximity alerts and can decide whether to wait, walk, or take another route. Reports are anonymous in public display, shown as approximate signals, and made broadly visible only after a configured aggregation/confirmation threshold is met, so no one's movements are tracked. Abuse is handled through flags and community-guideline actions instead of visible reputation or rewards.`

## User Levels

| User Level              | Description |
| ----------------------- | ----------- |
| A. System Administrator | Maintains system/server configuration and key parameters, and performs regular backups/restores. |
| B. Administrator        | Manages general app settings and views essential aggregated operational metrics. |
| C. Moderator            | Reviews flagged PUV sightings and applies community-guideline actions (dismiss, hide/remove, or guideline hit). |
| D. Signed-in Commuter   | Authenticated commuter who submits, confirms, and flags PUV sightings. Public sighting display remains anonymous. |
| E. Guest                | Unauthenticated user with limited access to view recent, approximate nearby PUV alerts. |

## System Requirements

1. The app shall allow users to authenticate using Google Sign-In for contribution and moderation actions, and to sign out.
2. The app shall allow users to view recent, approximate nearby PUV sightings/alerts (such as coarse area/distance and time since spotted) within a configured proximity radius, with limited access for guests.
3. The app shall allow signed-in commuters to submit a PUV sighting at an approximate current/selected location with minimal input.
4. The app shall allow signed-in commuters to confirm that an active nearby PUV sighting is still present.
5. The app shall allow signed-in commuters to flag a false, abusive, or misleading sighting for moderator review.
6. The app shall allow moderators to review flagged sightings and dismiss flags, hide/remove sightings, or apply guideline actions per policy.
7. The app shall allow authorized administrators to configure essential parameters (expiry duration, proximity radius, aggregation/confirmation threshold, and retention limit), view essential aggregated operational metrics, and perform basic backup/restore of system data.
8. The app shall enforce privacy and data-handling controls: anonymous public display, approximate location, no per-user movement trails, expiry of sightings, and deletion after the configured retention limit.

## Required Solution Layers

1. Security and privacy by design. Data privacy compliance, transparent location permission/use, location protection with approximate display, retention/expiry limits, no per-user movement trails, aggregation thresholds for visibility, and no public identity or rewards.

## MVP Features and Access

> See the User Levels table for reference.

| Feature               | Access      |
| --------------------- | ----------- |
| 1. Google Sign-In (sign in/out for contribution and moderation actions) | A,B,C,D     |
| 2. View nearby PUV alert feed/map (limited for guests) | A,B,C,D,E   |
| 3. Submit a PUV sighting | A,B,C,D     |
| 4. Confirm a sighting is still present | A,B,C,D     |
| 5. Flag a sighting for review | A,B,C,D     |
| 6. Moderation queue and guideline actions | A,B,C       |
| 7. Essential configuration, operational metrics, and backups | A,B (settings/metrics), A (backups/full config) |
| 8. Privacy and data-handling controls (system-wide) | A,B,C,D,E   |

## Notes
- PUV sightings are short-lived: they expire after the configured duration and are deleted after the configured retention limit; confirmations may reinforce that a sighting is still present within configured rules.
- A sighting/alert becomes broadly visible only after the configured aggregation/confirmation threshold is met within the active time window, to reduce false or noisy reports.
- Public display is anonymous and approximate; the app does not expose reporter identity, per-user movement trails, precise tracking, or public reputation.
- No points, credits, or monetary rewards.

## Sections changed
- Intro and platform line (realigned to PUV proximity alerts and MVP platform focus)
- `## Project Details`
- `## User Levels`
- `## System Requirements`
- `## Required Solution Layers`
- `## MVP Features and Access`
- `## Notes`
