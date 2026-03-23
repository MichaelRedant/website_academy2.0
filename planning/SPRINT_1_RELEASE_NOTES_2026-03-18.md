# Sprint 1 Release Notes

- Datum: `2026-03-18`
- Sprint: `Sprint 1` (Optie C monolith)
- Scope: oplevering van foundation + public catalog + search/filter + data foundation

## Opgeleverd

1. Platform foundation:
   - Laravel monolith workspace, setup wrappers en OneDrive-proof writable handling.
   - Omgevingstemplates voor `dev`, `staging`, `prod`.
2. Publieke pagina's:
   - `/`
   - `/cursussen`
   - `/how-tos`
3. Search/filter foundation:
   - API endpoint: `GET /api/search`
   - Ondersteunde filters: `type`, `category`, `level`, `language`
   - UI koppeling op `/cursussen` (live zoek/filter interactie)
   - Search benchmark artifacts en gekozen MVP-strategie (DB-first)
4. Data foundation:
   - Taxonomy import spike (`academy:import-taxonomy --write`)
   - Taxonomy migration + idempotente `TaxonomySeeder`
   - Minimale dataset via `DatabaseSeeder`
5. Migratievoorbereiding:
   - Mapping template V1 (`pages/courses/lessons/categories/tags`)
   - Redirects ready export V1 (`301` + `410`)
6. QA:
   - Sprint 1 smoke-run gedocumenteerd
   - Tests/build/migrate+seed groen

## Kwaliteitsstatus

1. Laravel test-suite: `15` tests `PASS` (`100` assertions)
2. Productiebuild: `PASS`
3. `migrate:fresh --seed`: `PASS`

## Belangrijke artefacten

1. `planning/QA_SMOKE_SPRINT1_2026-03-18.md`
2. `planning/MAPPING_TEMPLATE_V1.csv`
3. `planning/REDIRECTS_READY_V1.csv`
4. `architecture/SEARCH_BENCHMARK_SPK01_2026-03-18.md`
5. `architecture/SEED_IMPORT_SPIKE_SPK03_2026-03-18.md`

## Niet in Sprint 1 (bewust uitgesteld)

1. `T-004` Rollenmodel + policies implementatie (`Deferred -> Sprint 2`)

## Bekende aandachtspunten

1. Een beperkt aantal lesson mappings is best-effort inferentie (zie `note` in mapping CSV).
2. Volledige account/auth rollenvalidatie volgt in Sprint 2.

## Volgende stap

1. Sprint demo uitvoeren met demo checklist.
2. Start Sprint 2 scope: rollen/policies + contentbeheer backend.
