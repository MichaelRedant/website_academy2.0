# T-023 Implementatienotitie (Taxonomy beheer in admin)

- Datum: `2026-03-18`
- Taak: `T-023`
- Story: `US-054`

## Wat is geimplementeerd

1. Taxonomy domeinmodel toegevoegd:
   - `app/Models/TaxonomyTerm.php`
   - ondersteunde types:
     - `course_category`
     - `lesson_category`
     - `course_tag`
2. Taxonomy testfactory toegevoegd:
   - `database/factories/TaxonomyTermFactory.php`
3. Validatie en normalisatie toegevoegd:
   - `app/Http/Requests/Admin/TaxonomyTermRequest.php`
   - stable key wordt automatisch opgebouwd als `entity_type|domain|slug`
   - voor `course_category` en `course_tag` wordt `domain` geforceerd naar `global`
   - voor `lesson_category` wordt `parent_slug` automatisch afgeleid uit domein indien leeg
4. Taxonomy admin controller toegevoegd:
   - `app/Http/Controllers/Admin/TaxonomyCrudController.php`
   - acties:
     - `index`, `create`, `store`, `edit`, `update`
     - `deactivate`, `activate`
5. Taxonomy admin routes gekoppeld:
   - `GET /admin/taxonomie`
   - `GET /admin/taxonomie/nieuw`
   - `POST /admin/taxonomie`
   - `GET /admin/taxonomie/{taxonomyTerm}/bewerken`
   - `PUT /admin/taxonomie/{taxonomyTerm}`
   - `POST /admin/taxonomie/{taxonomyTerm}/deactiveren`
   - `POST /admin/taxonomie/{taxonomyTerm}/activeren`
6. UI voor taxonomybeheer toegevoegd:
   - `resources/views/pages/admin/taxonomy/index.blade.php`
   - `resources/views/pages/admin/taxonomy/form.blade.php`
   - inclusief filters per type, statusbadges en actieve/inactieve toggles.

## Tests

Toegevoegd:

1. `tests/Feature/AdminTaxonomyCrudTest.php`
   - learner krijgt geen toegang
   - content_manager kan overview + create-form openen
   - content_manager kan tag aanmaken met genormaliseerde stable key
   - content_manager kan term updaten + deactiveren + activeren

Aangepast:

1. `tests/Feature/AdminSkeletonTest.php`
   - `/admin/taxonomie` is nu echte module en wordt daarop geassert.

## Validatie

1. `npm run monolith:test` OK
2. `npm run monolith:build` OK

## Resultaat

Categorieen en tags zijn nu beheerbaar via admin zonder manuele DB-ingrepen. Dit dekt de scope van `US-054` voor Sprint 2.
