# QA Smoke Sprint 1

- Datum: `2026-03-18`
- Scope: `T-014` (QA smoke + testexecutie Sprint 1)
- Context: `US-010`, `US-011`, `US-012`, `US-020`, `US-021`, `US-030`, `US-031`

## Uitgevoerde checks

1. `npm run monolith:test`
2. `npm run monolith:build`
3. `npm run monolith:artisan -- migrate:fresh --seed --no-interaction`

## Resultaten

1. Testsuite: `PASS` (`15` tests, `100` assertions)
2. Build: `PASS` (Vite productiebuild succesvol)
3. DB reset + migrate + seed: `PASS` (inclusief `TaxonomySeeder`)

## Functionele smoke bewijsvoering

1. Publieke routes en search werden functioneel gevalideerd via feature-tests:
   - `HomePageTest`
   - `CoursesPageTest`
   - `HowTosPageTest`
   - `SearchEndpointTest`
2. Poging tot extra runtime smoke via background `artisan serve` in deze shell werd door policy geblokkeerd.

## Gekende gaps / vervolg

1. Auth/rollen gerelateerde QA-scenario's blijven buiten scope van Sprint 1 (`T-004` deferred naar Sprint 2).
2. Voor demo/UAT: manueel visueel nazicht op `http://127.0.0.1:8000` blijft aanbevolen.

## Besluit

`T-014` kan als afgerond beschouwd worden op basis van groene tests, succesvolle build en succesvolle migrate+seed smoke.
