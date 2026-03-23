# T-025 Implementatienotitie (Protected lesdetail + navigatie)

- Datum: `2026-03-18`
- Taak: `T-025`
- Story: `US-061`

## Wat is geimplementeerd

1. Nieuwe gate voor lesdetail toegang:
   - `view-lesson-detail` in `app/Providers/AppServiceProvider.php`
   - Regels:
     - `content_manager`/`admin` (of manage permissies) mogen alle lessen zien.
     - `learner`/`instructor` mogen enkel `published` lessen zien binnen een `published` cursus.
     - les moet altijd tot de opgegeven cursus behoren.
2. Nieuwe protected lesdetailroute:
   - `GET /account/cursussen/{course:slug}/lessen/{lesson:slug}`
   - middleware:
     - `can:view-learning-area`
     - `can:view-lesson-detail,course,lesson`
   - route gebruikt scoped bindings zodat lesson-slug binnen de cursuscontext gevalideerd wordt.
3. Nieuwe account controller:
   - `app/Http/Controllers/Account/AccountLessonDetailController.php`
   - levert vorige/volgende lesnavigatie op basis van zichtbare lessen voor de ingelogde gebruiker.
4. Nieuwe lesdetailview:
   - `resources/views/pages/account/lessons/show.blade.php`
   - toont lesinhoud en vorige/volgende navigatie.
5. Cursusdetail geupdated:
   - `resources/views/pages/account/courses/show.blade.php`
   - leslijst toont nu enkel zichtbare lessen en linkt door naar protected lesdetail.
6. Cursusdetailcontroller geupdated:
   - `app/Http/Controllers/Account/AccountCourseDetailController.php`
   - filtert lessen op basis van lesson-access gate.

## Tests

Toegevoegd:

1. `tests/Feature/ProtectedLessonDetailTest.php`
   - guest krijgt `403`
   - learner kan published les openen en navigeren
   - learner krijgt `403` op draft/archived lessons en lessons in draft course
   - content_manager kan archived/unpublished content openen
   - routebinding is scoped (mismatch course/lesson geeft `404`)

Aangepast:

1. `tests/Feature/ProtectedCourseDetailTest.php`
   - learner ziet geen draft les in cursusdetail.
2. `tests/Feature/RouteProtectionTest.php`
   - guest krijgt `403` op protected course/lesson detail routes.

## Validatie

1. `npm run monolith:test` OK
2. `npm run monolith:build` OK

## Resultaat

Lesdetail en lesnavigatie werken nu met rol- en statusgedreven toegangscontrole. Dit rondt de protected LMS-kern af richting `T-026` (basis mijn cursussen flow).
