# 09 — Security

**Purpose:** Threat model, authentication, authorization layers, secrets handling, injection surfaces, debug gates, accepted gaps, and a change checklist. Read before implementing auth, data handling, or external interfaces.

**Confidence note:** Verified against workspace snapshot on 2026-11-22T02:28:19+08:00. Evidence: [`argos-specs/business-logic-v1.0.md`](../business-logic-v1.0.md) (template), `handoff.md` ("No secrets"), absence of code/config/infra in components, and git remote URLs observed locally. Subrepo HEADs: `argos-api` `c348c54`, `argos-web` `0a5d9ec`, `argos-android` `0ac5e0e`, `argos-specs` no commits. The code wins (see 16).

## Current state

**No security implementation verified.** No auth code, authorization middleware/policies, secret management config, TLS/proxy config, dependency scanning, or runtime environment definitions were found. Any security posture below is requirement intent (template) or general baseline guidance, labeled accordingly.

## Threat model (initial, inferred/pending)

| Asset / surface | Potential threat | Current control | Gap / Miss → impact |
|---|---|---|---|
| User identity/auth sessions (future) | Account takeover, token misuse | None implemented; business logic template requires Google Sign-In | Undefined flows/storage/validation. *Miss → insecure auth rollout.* |
| Client-server traffic (future web/mobile ↔ API) | Interception, tampering | None verified | Transport protections and cert handling not defined. *Miss → credential/data exposure.* |
| Persistent data (future DB/storage) | Unauthorized access, over-retention, privacy violations | Template states "Security and privacy by design..." (DPA compliance, location protection, retention limits, etc.) but not implemented | No schema/policies/enforcement. *Miss → compliance and breach risk (07, 15).* |
| Source/spec repositories | Secret leakage, unauthorized changes | No secret scanning/hooks/CI observed; remotes are GitHub SSH URLs | Secrets could be committed; reviews/policies not evidenced. *Miss → credential compromise and audit gaps.* |
| Admin/config interfaces (future) | Privilege escalation | User levels defined as template only | No RBAC/ABAC implementation. *Miss → unauthorized actions.* |

## Authentication

- **Specified intent (template):** "The app shall allow the users to authenticate using Google Sign-In integration." ([`argos-specs/business-logic-v1.0.md`](../business-logic-v1.0.md), System Requirements #1).
- **Verified implementation:** none.
- *Miss → treating requirement text as shipped capability; document actual provider config, token validation, session handling, and logout/revocation once implemented (08, 04).*

## Authorization layers

- **Specified intent (template):** user levels A–E and MVP feature access table exist but contain placeholders/empty cells.
- **Verified implementation:** none (no policy code, route guards, or role checks).
- *Miss → relying on UI-only restrictions; enforce authorization server-side/API-side and test per role (08, 11).*

## Secrets handling

| Rule | Why / what breaks |
|---|---|
| Name environment variables/secrets by key only; never commit values | Prevents leakage in git history, logs, and docs (handoff "No secrets"). *Miss → rotation, incident response, possible account compromise.* |
| Do not paste tokens/keys into issue text, specs, screenshots, or commit messages | Copies propagate beyond intended scope. *Miss → long-lived exposure.* |
| Define secret storage/injection per component before first deploy (CI/CD, device, server) | Ad-hoc handling leads to plaintext files. *Miss → accidental commits and insecure runtime defaults (10, 13).* |

## Injection surfaces

No executable inputs or query surfaces implemented yet. When added, enumerate and harden all surfaces (SQL/NoSQL queries, OS commands, template rendering, HTML/JS sinks, deserialization, path/file handling). *Miss → injection/XSS/RCE classes depending on stack.*

## Debug gates

- No debug endpoints, feature flags, or environment-gated diagnostics found.
- **Future rule:** gate debug/admin tooling by environment and authorization; ensure defaults are safe for production. *Miss → information disclosure or privileged operations exposed publicly.*

## Accepted gaps (current, explicit)

| Gap | Why accepted now | Revisit trigger |
|---|---|---|
| No implemented authn/authz, encryption-at-rest/in-transit controls, scanning, or monitoring | No running system/code exists | First implementation or deployment design |
| Business-logic security/privacy requirements are template-level only | Requirements not finalized | Before implementation of data collection, auth, or storage |
| No verified dependency/security tooling | No dependency manifests | When manifests/package managers are introduced (13) |

## Change checklist (security)

- [ ] Identify affected assets/data flows and update threat assumptions if needed.
- [ ] Confirm no secrets/PII added to code, docs, logs, or examples.
- [ ] Validate authn/authz impact for every new/changed endpoint or privileged action (08).
- [ ] Assess injection, deserialization, path traversal, and XSS risks for new inputs/outputs.
- [ ] Define/update retention, consent, and privacy behavior when handling user/location data (07, 15).
- [ ] Add or update tests/checks for security-relevant behavior (11).
- [ ] Record decisions/gaps in 01/09/15 and lockstep impacts in 04.

Add surprises to [INBOX.md](INBOX.md).
