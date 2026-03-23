# T030 Profiel Bewerken Flow Implementatie Notitie

- Datum: `2026-03-18`
- Scope: Profielbeheer in "Mijn account" activeren met veilige updateflow

## Wat is opgeleverd

- Nieuwe accountroutes:
  - `GET /account/profiel`
  - `PUT /account/profiel`
- Bestaande `AccountProfileController` gekoppeld op routes.
- Nieuwe profielpagina:
  - `pages/account/profile/edit`
  - update van naam en e-mailadres
  - optionele wachtwoordwijziging met `current_password` controle
- Dashboardkaart "Profiel" omgezet van placeholder naar werkende knop.

## Beveiliging en validatie

- E-mailadres moet uniek blijven.
- Bij e-mailwijziging wordt `email_verified_at` geleegd.
- Wachtwoordwijziging kan alleen met:
  - huidig wachtwoord,
  - bevestiging van nieuw wachtwoord,
  - minimaal 8 tekens met letters en cijfers.

## Testdekking

- Nieuwe feature test: `AccountProfileFlowTest`
  - profielpagina bereikbaar voor learner
  - naam/e-mail update werkt
  - unieke e-mail wordt afgedwongen
  - wachtwoordwijziging faalt zonder huidig wachtwoord
  - wachtwoordwijziging werkt met geldig huidig wachtwoord
- Routebescherming uitgebreid voor `/account/profiel` in `RouteProtectionTest`.
- Dashboardtest uitgebreid met profielactie in `AccountDashboardTest`.
