# Architectuurdocument V1 (Optie C)

- Datum: `2026-03-17`
- Status: klaar voor goedkeuring
- Architectuurrichting: `C` (full custom monolith)

## Beslissingen samengevat

1. Platform: Laravel monolith met eigen CMS-admin en LMS module.
2. Data: PostgreSQL + Redis.
3. Auth: session-based met eigen rollenmodel.
4. Zoek/filter: database-first in PostgreSQL (FTS + trigram), upgradepad naar search engine.
5. Video: externe managed video provider met server-side access control.
6. Domain model: `DOMAIN_MODEL_V1` bevroren voor MVP.
7. URL policy: `URL_POLICY_V1` bevroren voor MVP.
8. Publicatie: `PUBLICATIEWORKFLOW_V1` bevroren voor MVP.
9. Performancebudget: `PERFORMANCE_TARGETS_V1` vastgelegd voor MVP-gating.
10. Security baseline: `SECURITY_BASELINE_V1` vastgelegd (OWASP, secrets, rate limiting).
11. Logging/monitoring baseline: `LOGGING_MONITORING_BASELINE_V1` vastgelegd voor observability en incidentdetectie.

## Referenties

1. `architecture/ARCHITECTUUR_KEUZEMATRIX.md`
2. `architecture/ARCHITECTUUR_BESLUIT_C.md`
3. `architecture/DOMAIN_MODEL_V1.md`
4. `architecture/URL_POLICY_V1.md`
5. `architecture/SEARCH_FILTER_STRATEGY_V1.md`
6. `architecture/VIDEO_HOSTING_STRATEGY_V1.md`
7. `architecture/PUBLICATIEWORKFLOW_V1.md`
8. `architecture/PERFORMANCE_TARGETS_V1.md`
9. `architecture/SECURITY_BASELINE_V1.md`
10. `architecture/LOGGING_MONITORING_BASELINE_V1.md`

## Open punt

1. Formele goedkeuring door product owner/stakeholders.
