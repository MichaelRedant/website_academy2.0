# T049 QA Baseline Automatisch

- Datum: `2026-03-18`
- Scope: geautomatiseerde QA-basis voor Fase 9 (unit, integratie, E2E).

## Wat is opgeleverd

- Nieuwe unit tests op kritieke modules:
  - `monolith/tests/Unit/CourseProgressServiceTest.php`
  - `monolith/tests/Unit/CertificateIssuerTest.php`
  - `monolith/tests/Unit/CertificateAdminServiceTest.php`
- Bestaande integratie/auth feature tests blijven actief voor:
  - registratie, login, wachtwoord reset, routeprotectie
  - account flows en adminbeheer
- Bestaande E2E test blijft actief:
  - `monolith/tests/Feature/CertificateJourneyE2eTest.php`

## Verificatie

- Volledige testsuite lokaal gedraaid:
  - `npm run monolith:test`
  - resultaat: `126 passed`, `630 assertions`

## Roadmap-impact

- Fase 9 QA:
  - `Unit tests op kritieke modules`: afgevinkt
  - `Integratietests op data- en auth flows`: afgevinkt
  - `E2E tests op kernjourneys`: afgevinkt
- Nog open in Fase 9 QA:
  - cross-browser, mobile, performance regressie, security smoke, accessibility audit
