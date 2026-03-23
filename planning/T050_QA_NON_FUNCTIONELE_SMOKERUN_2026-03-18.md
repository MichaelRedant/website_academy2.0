# T050 QA Niet-Functionele Smokerun

- Datum: `2026-03-18`
- Doel: roadmap Fase 9 QA-punten (cross-browser, mobile, performance, security, accessibility) objectief valideren.

## Wat is toegevoegd

- Playwright QA-config en smoke-tests:
  - `playwright.config.mjs`
  - `tests/e2e/cross-browser-smoke.spec.mjs`
  - `tests/e2e/mobile-smoke.spec.mjs`
  - `tests/e2e/accessibility-smoke.spec.mjs`
- Performance smoke script + wrapper:
  - `scripts/qa_performance_smoke.mjs`
  - `scripts/performance_smoke.ps1`
- Security smoke wrapper:
  - `scripts/security_smoke.ps1`
- NPM scripts:
  - `qa:cross-browser`
  - `qa:mobile`
  - `qa:performance`
  - `qa:security`
  - `qa:accessibility`
  - `qa:nonfunctional`

## Belangrijke functionele fix tijdens QA

- Mobiele klikbaarheid verbeterd:
  - decoratieve blur-elementen kregen `pointer-events-none` zodat ze geen taps/clicks meer blokkeren.
  - toegepast op publieke pagina-templates (home, cursus/les, faq/contact, auth, certificaatverificatie, lessenoverzicht).

## Uitgevoerde validatie

- Command:
  - `npm run qa:nonfunctional`
- Resultaat:
  - cross-browser smoke: `PASS`
  - mobile smoke: `PASS`
  - performance smoke: `PASS`
  - security smoke: `PASS`
  - accessibility smoke: `PASS`

## Rapporten

- `audit/qa_performance_smoke.json`
- `audit/qa_performance_smoke.md`
- `audit/playwright-report/` (HTML report)

## Roadmap-impact

- Fase 9 QA-checks staan nu afgevinkt:
  - Cross-browser testen
  - Mobile device testen
  - Performance regressietesten
  - Security smoke tests
  - Accessibility audit uitvoeren
