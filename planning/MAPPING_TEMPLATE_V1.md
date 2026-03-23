# Mapping Template V1 (US-031)

- Datum: `2026-03-18`
- Status: `draft ready`
- Bestand: `planning/MAPPING_TEMPLATE_V1.csv`
- Brondata:
  - `audit/urls_inventory.csv`
  - `architecture/URL_POLICY_V1.md`

## Doel

Eerste werktemplate om oude WordPress-URL's te mappen naar nieuwe Octopus Academy routes voor:

1. pages
2. courses
3. lessons
4. categories
5. tags

## Inhoud (huidige export)

1. `page`: 20
2. `course`: 10
3. `lesson`: 94
4. `category`: 8
5. `tag`: 4
6. Totaal: 136 rijen

## Kolommen

1. `mapping_id`: stabiele rij-id (`MAP-0001`, ...).
2. `entity_type`: `page`, `course`, `lesson`, `category`, `tag`.
3. `legacy_url`: volledige oude URL.
4. `legacy_path`: oude path.
5. `legacy_slug`: afgeleide slug uit oude path.
6. `proposed_new_path`: voorgestelde nieuwe routepath.
7. `new_content_key`: sleutel voor nieuwe content (`course:<slug>`, `lesson:<slug>`, ...).
8. `migration_action`: `canonical`, `redirect`, `migrate+redirect`, `review`, `deprecate`.
9. `redirect_status`: voorgestelde HTTP status (`301`, `410`, `review`).
10. `mapping_status`: werkstatus (`todo` als default).
11. `note`: extra context voor beslissingen.
12. `source_sitemap`: bron-sitemap.
13. `legacy_lastmod`: laatste wijzigingsdatum uit sitemap.

## Conventies

1. Lowercase URL's.
2. Trailing slash behouden.
3. `home` consolideren naar `/nl/`.
4. Technische pagina's op `deprecate` met `410`.
5. Lessons zonder expliciete legacy course-koppeling kregen een best-effort koppeling met notitie op rijniveau.

## Volgende stap

1. Vul `mapping_status` per rij: `todo` -> `in_progress` -> `done`.
2. Valideer de inferentie-rijen in `note` (o.a. legacy 404 en generieke slugs zoals `les-3`).
3. Gebruik de finale versie als input voor redirects (`Fase 8`) en contentmigratie (`Fase 7`).
