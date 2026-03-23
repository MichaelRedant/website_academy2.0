# T029 Account Dashboard Route Fix Notitie

- Datum: `2026-03-18`
- Scope: "Mijn account" laten openen op stabiele dashboardroute en databasefout vermijden

## Probleem

- Klik op "Mijn account" leidde naar `/account/cursussen`.
- In niet-volledig opgezette lokale DB (`courses` tabel ontbreekt) gaf dit een `QueryException`.

## Oplossing

- Nieuwe route toegevoegd:
  - `GET /account` als account-dashboard.
- Headerlink "Mijn account" wijst nu naar `/account`.
- Login/registratie redirecten voor learner/instructor naar account-dashboard.
- `/account/cursussen` kreeg table-check fallback:
  - als vereiste tabellen ontbreken, geen crash maar duidelijke setup-melding.

## Resultaat

- "Mijn account" opent altijd een bruikbare pagina.
- Geen SQL-crash meer op de account-cursuspagina wanneer migrations ontbreken.

## Validatie

- Nieuwe feature test:
  - `AccountDashboardTest`
- Bestaande auth/route tests geüpdatet.
