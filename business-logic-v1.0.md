# Business Logic

> Development of a `Android-based` `Community PUV Proximity Alert App` using `Kotlin` for `Commuters in Eastern Visayas, specially Students in Visayas State University - Main Campus`

- Allowed Platforms: Web, Android

## Project Details

- Company/Startup/Team Name: `AbTech`
- Project Code Name: `Argos`
- Project Short Code: `AG`
- Short Description: `Commuters anonymously report where a jeepney or PUV is, and nearby riders get a short-lived alert.`
- Long Description: `Waiting for a ride along unpredictable routes wastes commuters' time, and it is harder for students whose class schedules change often and who may finish late at night, when fewer vehicles are on the road. This app lets riders tap to report a PUV spotted at their location, and the report expires after a few minutes. Nearby commuters, including students heading home after late classes, see approximate proximity alerts and can decide whether to wait, walk, or take another route. Reports are anonymized and shown only in aggregate once enough people confirm, so no one's movements are tracked. Abuse is handled through community-guideline hits instead of visible reputation or rewards.`

## User Levels

> Note: Modify/rename the list of users based on the actual users that you expect to use the system.

| User Level              | Description |
| ----------------------- | ----------- |
| A. System Administrator | Maintains/overrides system/server configurations and performs regular backups. |
| B. Administrator        | Manages the general settings of the system and generates periodic system analytics and reports. |
| C. Moderator            | Reviews flagged road reports and applies community-guideline hits. |
| D. Contributor          | Logged-in residents who submit and confirm road condition reports. |
| E. Guest                | Users who do not log in, but view limited contents on the app/web. |

## System Requirements

1. The app shall allow the users to authenticate using Google Sign-In integration.
2. The app shall allow the users to report a road condition (pothole, flooding, obstruction, accidents) pinned to the map.
3. The app shall allow the users to attach an optional photo to a report.
4. The app shall allow the users to view current road reports on a map and filter by condition type.
5. The app shall allow the users to confirm that a reported condition is still present.
6. The app shall allow the users to flag false or abusive reports.
7. The app shall allow moderators to review flagged reports and apply community-guideline hits.

## Required Solution Layers

1. Security and privacy by design. Data Privacy Act compliance, location protection, retention limits, no per-user trails, aggregation thresholds, and consent for any data resale.

## MVP Features and Access

> See the User Levels table for reference.

| Feature               | Access      |
| --------------------- | ----------- |
| 1. View road condition map (limited for guests) | A,B,C,D,E   |
| 2. Submit a road condition report | A,B,C,D     |
| 3. Confirm a report is still active | A,B,C,D     |
| 4. Filter by condition type | A,B,C,D     |
| 5. Moderation queue and guideline hits | A,B,C       |
| 6. Aggregated road condition analytics | A,B         |
| 7. System configuration and backups | A           |

## Notes
- Reports expire after a set time unless re-confirmed, and are deleted after the retention limit.
- A report becomes visible only after the aggregation threshold of confirmations is met, to reduce false reports.
- No points, credits, or monetary rewards.
