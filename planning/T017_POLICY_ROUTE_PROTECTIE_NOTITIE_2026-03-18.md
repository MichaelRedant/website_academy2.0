# T-017 Implementatienotitie (Policy Middleware en Routebescherming)

- Datum: `2026-03-18`
- Taak: `T-017`
- Story: `US-041`

## Wat is geimplementeerd

1. Spatie middleware aliases geregistreerd in bootstrap:
   - `role`
   - `permission`
   - `role_or_permission`
2. Gates gedefinieerd in `AppServiceProvider`:
   - `view-learning-area`
   - `access-admin`
3. Routebescherming toegevoegd:
   - `/account/cursussen` beschermd via `can:view-learning-area`
   - `/admin` beschermd via combinatie:
     - `can:access-admin`
     - `role_or_permission:content_manager|admin|course.manage|lesson.manage`

## Tests

Toegevoegd:

1. `tests/Feature/RouteProtectionTest.php`
   - guest krijgt `403` op protected routes
   - learner krijgt toegang tot `account/cursussen` maar niet tot `admin`
   - content_manager krijgt toegang tot `admin`

## Validatie

1. `npm run monolith:artisan -- migrate:fresh --seed --no-interaction` OK
2. `npm run monolith:test` OK
3. `npm run monolith:build` OK

## Resultaat

Er is nu een werkende, testbare toegangslaag op route-niveau voor learning-area en admin-area, klaar om verder uit te breiden in de volgende Sprint 2 taken.
