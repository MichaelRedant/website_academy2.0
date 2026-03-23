# Teststrategie V1 (Fase 3)

- Datum: `2026-03-17`
- Scope: Sprint 1 en MVP-opbouw

## Testpiramide

1. Unit tests voor domeinlogica (modellen, services, policies).
2. Integratietests voor DB/query/auth/permissions.
3. E2E smoke tests voor kernflows (home, catalogus, login, zoeken).

## Verplicht per PR

1. Alle relevante unit tests groen.
2. Minstens 1 integratietest voor nieuwe endpoint of policy.
3. Geen kritieke security lint/scan issues.

## Sprint 1 testset

1. Auth:
   - login succesvol
   - login faalt bij fout wachtwoord
   - routebescherming per rol
2. Catalogus:
   - home bereikbaar
   - cursussenlijst toont data
   - how-to lijst toont data
3. Search/filter:
   - zoekterm geeft relevante resultaten
   - filters op categorie/tag/level werken
4. Data:
   - seed script maakt minimale dataset aan
   - migration scripts zijn idempotent in testomgeving

## Niet-functioneel in teststrategie

1. Performance smoke:
   - p95 response tijd voor catalogus endpoint binnen target
2. Security smoke:
   - auth-required routes geven 401/403 zonder sessie
3. Accessibility smoke:
   - basis keyboard navigation op publieke pagina's

## UAT voorbereiding (vanaf Sprint 2)

1. UAT scenario's aligneren met support/business.
2. Checklist per flow met expected result.
