# T026 Registratie Flow Implementatie Notitie

- Datum: `2026-03-18`
- Scope: werkende accountregistratie voor Octopus Academy

## Opgeleverd

- Publieke registratieroute:
  - `GET /register`
  - `POST /register`
- Nieuwe controller: `RegisteredUserController`
- Nieuwe view: `resources/views/pages/auth/register.blade.php`
- Loginpagina verwijst nu ook naar registratie.

## Gedrag

- Gebruiker registreert met naam, e-mail en wachtwoord (+ bevestiging).
- E-mail moet uniek zijn.
- Wachtwoord moet minimaal 8 tekens bevatten, met letters en cijfers.
- Nieuwe gebruiker krijgt automatisch rol `learner`.
- Na registratie wordt gebruiker automatisch ingelogd en doorgestuurd naar `/account/cursussen`.

## Validatie

- Feature tests toegevoegd:
  - `AuthRegistrationFlowTest`
- Suite groen na implementatie.
