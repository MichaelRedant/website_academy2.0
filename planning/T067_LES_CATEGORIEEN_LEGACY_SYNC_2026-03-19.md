# T067 Lescategorieen legacy-sync

- Datum: `2026-03-19`
- Doel: categorieen per les vollediger en correcter overnemen vanuit de legacy Academy.

## 1) Probleem

- De lessenset stond op `94` items, maar categorieen kwamen deels uit course-defaults.
- Daardoor waren sommige lescategorieen te generiek of onvolledig.

## 2) Aanpak

- `tools/sync_howtos_full.php` uitgebreid met categorie-enrichment:
  - leest legacy termen via `wp-json/wp/v2/ld_lesson_category`,
  - crawlt publieke `lesson-category/{slug}` archieven (met paginatie),
  - extraheert les-slugs uit archive links,
  - koppelt parent-categorieen automatisch mee,
  - gebruikt bestaande fallbackcategorieen wanneer geen legacy-match bestaat.

## 3) Resultaat

- `monolith/data/howtos.php` opnieuw opgebouwd met categorieen uit legacy-archieven.
- Dekking:
  - `94` lessen totaal,
  - `92` lessen met categorieen rechtstreeks uit legacy-categoriearchieven,
  - `2` lessen met veilige fallback.
- Geen lege categorieen meer in de dataset.

## 4) Validatie

- `npm run monolith:test` geslaagd (`141` tests).
- `npm run monolith:build` geslaagd.
