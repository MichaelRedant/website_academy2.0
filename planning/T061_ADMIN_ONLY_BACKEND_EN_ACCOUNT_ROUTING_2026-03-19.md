# T061 Admin-only backend en account routing

- Datum: `2026-03-19`
- Doel: backend exclusief toegankelijk maken voor admins en de "Mijn account"-navigatie voor admins rechtstreeks naar het admin dashboard sturen.

## 1) Beslissing

- `/admin/*` is enkel bereikbaar voor gebruikers met rol `admin`.
- Content managers verliezen toegang tot admin routes.
- Als een admin in de publieke site op "Mijn account" klikt, gaat de link naar `/admin`.

## 2) Technische implementatie

- Admin route middleware aangepast naar `role:admin`.
- Gate `access-admin` beperkt tot `admin`.
- Login redirect:
  - `admin` -> `/admin`
  - overige rollen (incl. `content_manager`) -> `/account`
- Publieke navigatie/accountlinks (`header`, `footer`, contact, certificaatverificatie) sturen admins nu naar `admin.dashboard`.

## 3) Beveiligingseffect

- Een niet-admin kan niet meer in de backend CRUD-modules.
- Alle CRUD-acties (gebruikers, cursussen, lessen, taxonomie, certificaten) blijven functioneel voor admins.

## 4) Validatie

- `npm run monolith:test` geslaagd (`138` tests).
- `npm run monolith:build` geslaagd.

## 5) Resultaat

- Backend is nu eenduidig en veilig: enkel admins beheren data.
- UX is duidelijker: admin "Mijn account" = admin dashboard.
