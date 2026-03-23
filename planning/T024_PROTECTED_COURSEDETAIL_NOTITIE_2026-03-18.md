# T-024 Implementatienotitie (Protected cursusdetail + policy checks)

- Datum: `2026-03-18`
- Taak: `T-024`
- Story: `US-060`

## Wat is geimplementeerd

1. Nieuwe gate voor cursusdetail toegang:
   - `view-course-detail` in `app/Providers/AppServiceProvider.php`
   - Regels:
     - `content_manager`/`admin` (of manage permissies) mogen alle cursussen zien.
     - `learner`/`instructor` mogen enkel `published` cursussen zien.
2. Nieuwe protected route in leeromgeving:
   - `GET /account/cursussen/{course:slug}`
   - middleware:
     - `can:view-learning-area`
     - `can:view-course-detail,course`
3. Nieuwe account controller:
   - `app/Http/Controllers/Account/AccountCourseDetailController.php`
   - toont cursusdetail met lessen (gesorteerd op `order_index`).
4. Nieuwe view:
   - `resources/views/pages/account/courses/show.blade.php`
   - bevat cursusmetadata en leslijst.

## Tests

Toegevoegd:

1. `tests/Feature/ProtectedCourseDetailTest.php`
   - guest krijgt `403` op protected cursusdetail
   - learner kan `published` cursusdetail openen
   - learner krijgt `403` op `draft`/`archived`
   - content_manager kan `archived` cursusdetail openen

## Validatie

1. `npm run monolith:test` OK
2. `npm run monolith:build` OK

## Resultaat

Cursusdetail is nu effectief beschermd op basis van rol/permissie en cursusstatus. Dit legt de basis voor `T-025` (protected lesdetail + navigatie).
