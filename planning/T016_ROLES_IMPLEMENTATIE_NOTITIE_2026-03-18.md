# T-016 Implementatienotitie (Rollen en Permissies)

- Datum: `2026-03-18`
- Taak: `T-016`
- Story: `US-003`

## Wat is geimplementeerd

1. `spatie/laravel-permission` package toegevoegd.
2. Permission package migration gepubliceerd:
   - `database/migrations/2026_03_18_085033_create_permission_tables.php`
3. Permission config gepubliceerd:
   - `config/permission.php`
4. `User` model role-capable gemaakt met `HasRoles` trait.
5. `RolesAndPermissionsSeeder` toegevoegd met MVP catalogus:
   - Rollen: `guest`, `learner`, `instructor`, `content_manager`, `admin`
   - Permissies:
     - `catalog.view`
     - `course.view`
     - `course.manage`
     - `lesson.view`
     - `lesson.manage`
     - `enrollment.view_own`
     - `enrollment.manage`
     - `certificate.verify`
     - `user.manage_roles`
6. `DatabaseSeeder` bijgewerkt zodat rollen/permissies standaard mee geseed worden.

## Tests

Toegevoegd:

1. `tests/Feature/RolesAndPermissionsSeederTest.php`
   - expected roles/permissions bestaan
   - admin rol heeft alle permissies
   - `DatabaseSeeder` seedt zowel roles/perms als taxonomy

## Validatie

1. `npm run monolith:artisan -- migrate:fresh --seed --no-interaction` OK
2. `npm run monolith:test` OK
3. `npm run monolith:build` OK

## Resultaat

Rollen en permissies zijn operationeel in de database en klaar voor policy/middleware koppeling in `T-017`.
