# T062 Admin setup fallbacks

- Datum: `2026-03-19`
- Doel: adminomgeving robuust maken wanneer lokale databanktables (nog) ontbreken.

## Opgeleverd

- Admin dashboard crasht niet meer bij ontbrekende tabellen.
- Dashboard toont duidelijke setup-waarschuwing met ontbrekende tabellen.
- Admin modules (`cursussen`, `lessen`, `taxonomie`, `certificaten`) redirecten bij ontbrekende tabellen veilig naar dashboard.
- JSON-requests krijgen een `503` met duidelijke foutboodschap en lijst van ontbrekende tabellen.

## Technische wijzigingen

- Nieuwe middleware:
  - `App\Http\Middleware\EnsureAdminModuleSetupIsComplete`
  - alias: `academy.admin.setup_guard`
- Admin routegroep gebruikt nu deze setup-guard.
- `AdminDashboardController` gebruikt veilige telqueries met fallback i.p.v. harde crash.
- Dashboard view toont expliciete setup-instructies (`monolith:setup` of `migrate --force`).

## Validatie

- Nieuwe feature test:
  - `Tests\Feature\AdminSetupFallbackTest`
- Volledige suite geslaagd.
- Build geslaagd.
