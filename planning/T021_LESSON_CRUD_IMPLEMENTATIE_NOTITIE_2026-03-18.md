# T-021 Implementatienotitie (Lesson CRUD)

- Datum: `2026-03-18`
- Taak: `T-021`
- Story: `US-052`

## Wat is geimplementeerd

1. Nieuwe datalaag voor lessen:
   - Migration: `database/migrations/2026_03_18_130000_create_lessons_table.php`
   - Model: `app/Models/Lesson.php`
   - Relatie op `Course` model: `lessons()`
   - Factory: `database/factories/LessonFactory.php`
2. Validatie voor lesson create/update:
   - `app/Http/Requests/Admin/LessonRequest.php`
   - Includes slug-normalisatie en unieke slug per cursus.
3. Admin CRUD controller toegevoegd:
   - `app/Http/Controllers/Admin/LessonCrudController.php`
   - Acties: `index`, `create`, `store`, `edit`, `update`
4. Admin routes voor lesson CRUD gekoppeld:
   - `GET /admin/lessen`
   - `GET /admin/lessen/nieuw`
   - `POST /admin/lessen`
   - `GET /admin/lessen/{lesson}/bewerken`
   - `PUT /admin/lessen/{lesson}`
5. Admin UI voor lesson beheer toegevoegd:
   - `resources/views/pages/admin/lessons/index.blade.php`
   - `resources/views/pages/admin/lessons/form.blade.php`
   - Form bevat cursuskoppeling, volgorde, status, preview, duur en video (Vimeo/YouTube).
6. Dashboardtekst geactualiseerd naar volgende focus (`T-022` archive flow).

## Tests

Toegevoegd:

1. `tests/Feature/AdminLessonCrudTest.php`
   - learner heeft geen toegang tot lesson admin routes
   - content_manager kan lijst en create-form openen
   - content_manager kan les aanmaken
   - content_manager kan les bijwerken

Aangepast:

1. `tests/Feature/AdminSkeletonTest.php`
   - `/admin/lessen` assert nu op echte lessonmodule i.p.v. placeholder.

## Validatie

1. `npm run monolith:test` OK
2. `npm run monolith:build` OK

## Resultaat

Er is nu een werkende basis voor lesbeheer in de admin, gekoppeld aan cursussen. Hiermee is de beheerflow klaar voor `T-022` (archive/deactivate).
