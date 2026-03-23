# T-019 Implementatienotitie (Admin backend skeleton)

- Datum: `2026-03-18`
- Taak: `T-019`
- Story: `US-050`

## Wat is geimplementeerd

1. Admin dashboard controller toegevoegd:
   - `app/Http/Controllers/Admin/AdminDashboardController.php`
2. Nieuwe admin layout met zij-navigatie en topbar:
   - `resources/views/layouts/admin.blade.php`
3. Admin dashboard view toegevoegd:
   - `resources/views/pages/admin/dashboard.blade.php`
4. Placeholder module view toegevoegd:
   - `resources/views/pages/admin/placeholder.blade.php`
5. Auth redirect-doel toegevoegd met login placeholder:
   - Route: `/login`
   - View: `resources/views/pages/auth/login-placeholder.blade.php`
6. Admin routes omgezet naar skeleton met auth guard:
   - `/admin`
   - `/admin/cursussen`
   - `/admin/lessen`
   - `/admin/taxonomie`
   - `/admin/gebruikers-rollen`
   - Middleware stack: `auth`, `can:access-admin`, `role_or_permission:...`

## Tests

Toegevoegd:

1. `tests/Feature/AdminSkeletonTest.php`
   - login placeholder bereikbaar
   - content_manager kan admin dashboard en navigatie openen
   - content_manager kan skeleton modules openen

Aangepast:

1. `tests/Feature/RouteProtectionTest.php`
   - guest krijgt nog steeds `403` op `/account/cursussen`
   - guest wordt voor admin routes naar `/login` gestuurd
   - content_manager ziet admin dashboard

## Validatie

1. `npm run monolith:test` OK
2. `npm run monolith:build` OK

## Resultaat

Er is nu een werkende, beveiligde admin-basis met layout en navigatie. Dit vormt de directe fundering voor `T-020` (course CRUD) en `T-021` (lesson CRUD).
