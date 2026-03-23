# T070 Legacy Content Import Command

- Datum: `2026-03-19`
- Doel: admin-contenttabellen (`courses`, `lessons`) automatisch vullen vanuit bestaande bronbestanden.

## Opgeleverd

1. Nieuw artisan-commando:
   - `academy:import-content`
2. Bronnen:
   - `monolith/data/courses.php`
   - `monolith/data/howtos.php`
3. Importgedrag:
   - idempotente upsert (veilig opnieuw te draaien)
   - zet cursussen op `published`
   - zet lessen op `published`
   - vult video/info-velden waar beschikbaar
4. Taxonomie:
   - koppelt lescategorieen en afgeleide cursuscategorieen indien taxonomy-tabellen beschikbaar zijn

## Opties

1. `--reset-orders`
   - herzet `courses.display_order` en `lessons.order_index` volgens bronvolgorde
2. `--prune`
   - verwijdert lokale cursussen/lessen die niet meer in brondata zitten

## Validatie

1. Nieuwe test:
   - `LegacyContentImportCommandTest`
   - controleert dat import data toevoegt en idempotent is.
