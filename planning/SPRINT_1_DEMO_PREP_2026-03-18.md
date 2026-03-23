# Sprint 1 Demo Prep

- Datum: `2026-03-18`
- Doel: gecontroleerde demo van Sprint 1 opleveringen

## Demo omgeving opstarten

Vanaf repository root:

1. `npm install`
2. `npm run monolith:setup`
3. `npm run monolith:serve`
4. (optioneel) `npm run monolith:dev`

Demo URL:

1. `http://127.0.0.1:8000`

## Demo script

1. Home pagina:
   - open `/`
   - toon branding (`Octopus Academy`) en highlight cards.
2. Cursussen overzicht:
   - open `/cursussen`
   - toon zoekveld + filtercontrols.
3. Search/filter flow:
   - zoek op `peppol`
   - filter op type `course`
   - toon dat resultaten/facets updaten.
4. How-to overzicht:
   - open `/how-tos`
   - toon dat lessonslijst geladen wordt.
5. API bewijs:
   - open `/api/search?q=peppol&type=course`
   - toon paginatie + active filters + items.
6. Data foundation:
   - toon dat taxonomy seeding/migratie klaar staat via:
     - `npm run monolith:artisan -- migrate:fresh --seed --no-interaction`
7. Migratievoorbereiding:
   - toon `planning/MAPPING_TEMPLATE_V1.csv`
   - toon `planning/REDIRECTS_READY_V1.csv`

## Demo checklist

- [ ] `monolith:test` is groen
- [ ] `monolith:build` is groen
- [ ] `/` geeft `200`
- [ ] `/cursussen` geeft `200`
- [ ] `/how-tos` geeft `200`
- [ ] `/api/search` geeft JSON met expected structuur
- [ ] Mapping + redirects artifacts zijn beschikbaar
- [ ] Bekende scopegrenzen zijn benoemd (rollen deferred naar Sprint 2)

## Fallbacks

1. Als `127.0.0.1:8000` bezet is:
   - `npm run monolith:artisan -- serve --host=127.0.0.1 --port=8001`
2. Als assets niet updaten:
   - herstart `npm run monolith:dev`
3. Als DB fout meldt:
   - `npm run monolith:setup` opnieuw uitvoeren.
