# T-020 Implementatienotitie (Course CRUD)

- Datum: `2026-03-18`
- Taak: `T-020`
- Story: `US-051`

## Wat is geimplementeerd

1. Nieuwe datalaag voor cursussen:
   - Migration: `database/migrations/2026_03_18_120000_create_courses_table.php`
   - Model: `app/Models/Course.php`
   - Factory: `database/factories/CourseFactory.php`
2. Validatie toegevoegd voor create/update:
   - `app/Http/Requests/Admin/CourseRequest.php`
   - Includes slug-normalisatie en unique slug check.
3. Admin CRUD controller toegevoegd:
   - `app/Http/Controllers/Admin/CourseCrudController.php`
   - Acties: `index`, `create`, `store`, `edit`, `update`
4. Admin routes voor course CRUD gekoppeld:
   - `GET /admin/cursussen`
   - `GET /admin/cursussen/nieuw`
   - `POST /admin/cursussen`
   - `GET /admin/cursussen/{course}/bewerken`
   - `PUT /admin/cursussen/{course}`
5. Admin UI voor course beheer toegevoegd:
   - `resources/views/pages/admin/courses/index.blade.php`
   - `resources/views/pages/admin/courses/form.blade.php`
   - `resources/views/layouts/admin.blade.php` aangepast voor correcte actieve navigatie.

## Tests

Toegevoegd:

1. `tests/Feature/AdminCourseCrudTest.php`
   - learner heeft geen toegang tot course admin routes
   - content_manager kan lijst en create-form openen
   - content_manager kan cursus aanmaken
   - content_manager kan cursus bijwerken

Aangepast:

1. `tests/Feature/AdminSkeletonTest.php`
   - `/admin/cursussen` assert nu op echte cursusmodule i.p.v. placeholder.

## Validatie

1. `npm run monolith:test` OK
2. `npm run monolith:build` OK

## Resultaat

Er is nu een werkende basis voor cursusbeheer in de admin. Content managers kunnen cursussen oplijsten, aanmaken en aanpassen, klaar als fundament voor `T-021` (Lesson CRUD).
