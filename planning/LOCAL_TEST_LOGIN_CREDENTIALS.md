# Lokale Test Login (Octopus Academy)

- Laatst bijgewerkt: `2026-03-18`
- Doel: snelle lokale testtoegang voor adminflow

## Admin login (lokaal)

- URL: `http://127.0.0.1:8000/login`
- E-mail: `admin@octopusacademy.test`
- Wachtwoord: `OctopusAdmin!2026`

## Belangrijk

- Deze credentials zijn enkel bedoeld voor lokale development/test.
- Niet gebruiken in staging of productie.
- Je kan deze waarden aanpassen in `monolith/.env`:
  - `ACADEMY_ADMIN_NAME`
  - `ACADEMY_ADMIN_EMAIL`
  - `ACADEMY_ADMIN_PASSWORD`

## Seeder

- Seeder: `LocalAdminUserSeeder`
- Manueel draaien:

```bash
npm run monolith:artisan -- db:seed --class=LocalAdminUserSeeder
```
