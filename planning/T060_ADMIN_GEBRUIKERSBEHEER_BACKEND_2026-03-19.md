# T060 Admin Gebruikersbeheer Backend

- Datum: `2026-03-19`
- Doel: een volwaardige backendmodule voorzien voor beheer van gebruikersrollen.
- Scope: admin gebruikersoverzicht, rolbeheer, permissiebeveiliging, regressietests.

## 1) Opgeleverde backendfunctionaliteit

- Placeholder op `/admin/gebruikers-rollen` vervangen door echte module.
- Nieuwe controller:
  - `App\Http\Controllers\Admin\UserManagementController`
- Nieuwe requestvalidatie:
  - `App\Http\Requests\Admin\UserRoleUpdateRequest`
- Nieuwe admin view:
  - `resources/views/pages/admin/users/index.blade.php`
- Nieuwe routes:
  - `GET /admin/gebruikers-rollen` (`admin.users.roles`)
  - `PUT /admin/gebruikers-rollen/{user}` (`admin.users.roles.update`)

## 2) Security en toegangscontrole

- Routebeveiliging uitgebreid met `user.manage_roles` in admin middlewareketen.
- Gebruikersbeheerpagina vereist expliciet `can:user.manage_roles`.
- Content managers zonder deze permissie kunnen de module niet openen.
- Bescherming toegevoegd tegen lockout:
  - de laatste admin kan niet gedegradeerd worden.

## 3) UX voor adminbeheer

- Zoek op naam/e-mail.
- Filter op rol (`learner`, `instructor`, `content_manager`, `admin`).
- Tellingen per rol en totaalaantal gebruikers.
- Inline rolupdate per gebruiker in tabel.

## 4) Verificatie

- Nieuwe testsuite:
  - `Tests\Feature\AdminUserManagementTest`
- Gevalideerde scenario's:
  - learner geblokkeerd
  - content manager zonder permissie geblokkeerd
  - admin ziet overzicht
  - admin wijzigt rol succesvol
  - laatste admin kan niet gedegradeerd worden
- Volledige regressie:
  - `npm run monolith:test` geslaagd
  - `npm run monolith:build` geslaagd

## 5) Resultaat

- Admin backend is nu duidelijk completer en operationeel voor zowel contentbeheer als gebruikersrolbeheer.
- Toegangscontrole is scherper en veiliger voor productiegebruik.
