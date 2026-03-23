# T065 Legacy card stijl en admin bundeling

- Datum: `2026-03-19`
- Doel: visuele kaartstijl dichter bij legacy Academy brengen en backend uitbreiden voor lesbundeling per cursus.

## 1) Legacy stijlreferentie

- Legacy pagina gecontroleerd: `https://academy.octopus.be/nl/cursussen/`
- Vaststelling:
  - duidelijke cursuscards met visuele cover,
  - vaste beeldratio,
  - CTA per kaart.

## 2) Publieke kaartverbeteringen

- Cursussenoverzicht (`/cursussen`) toont nu per cursus een thumbnail-card.
- Lessenoverzicht (`/lessen`) toont nu per les een thumbnail-card.
- Cursusdetail (`/cursussen/{slug}`) toont lescards met thumbnail.
- Fallback voorzien wanneer geen thumbnail beschikbaar is.

## 3) Legacy thumbnails gekoppeld

- `CatalogData` vult cursusafbeeldingen automatisch aan via slug-map naar legacy beeld-URL's.
- Les-thumbnails komen uit de bestaande video-sitemap metadata (`thumbnail_url`) met cursuscover als fallback.

## 4) Admin backend uitbreidingen

- Nieuwe velden:
  - `courses.cover_image_url`
  - `lessons.cover_image_url`
- Admin formulieren ondersteunen nu cover-URL input voor cursus en les.
- Cursus edit ondersteunt nu bundeling:
  - bestaande lessen uit andere cursussen selecteren en verplaatsen,
  - volgorde (`order_index`) van gekoppelde lessen aanpassen in dezelfde save.
- Fallback bij slug-conflict:
  - conflicterende les blijft in oorspronkelijke cursus,
  - update blijft slagen met duidelijke statusmelding.

## 5) Accountweergave

- Account cursusoverzicht toont nu ook cursus-cover.
- Cursusleslijst in account gebruikt nu visuele lescards met cover.

## 6) Migratie en validatie

- Migratie toegevoegd: `2026_03_19_220000_add_cover_image_url_to_courses_and_lessons.php`
- Volledige validatie:
  - `npm run monolith:test` -> geslaagd
  - `npm run monolith:build` -> geslaagd
