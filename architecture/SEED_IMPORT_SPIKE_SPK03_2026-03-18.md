# SPK-03 Seed Import Approach

- Date: `2026-03-18`
- Source file: `C:\Users\michael.redant\OneDrive - dekimo.com\Apps\website_academy2.0\monolith\import/templates/legacy_taxonomy_template.csv`
- Total rows: `21`
- Valid rows: `21`
- Errors: `0`

## Counts By Type

- `course_category`: 5
- `lesson_category`: 16

## Counts By Domain

- `Boekhoudprogramma`: 8
- `Klantenportaal`: 6
- `Nieuw`: 2
- `global`: 5

## Validation

- Geen validatiefouten gevonden.

## Aanpak T-012

1. Gebruik `academy:import-taxonomy --write` om normalized input voor seeders te genereren.
2. Laat `DatabaseSeeder` een taxonomy seeder aanroepen op basis van `data/import/legacy_taxonomy.normalized.php`.
3. Houd mapping idempotent via `upsert` op stabiele sleutel (`entity_type + domain + slug`).

## Recommendation

Template is valide. Start T-012 met seeders op basis van data/import/legacy_taxonomy.normalized.php.
