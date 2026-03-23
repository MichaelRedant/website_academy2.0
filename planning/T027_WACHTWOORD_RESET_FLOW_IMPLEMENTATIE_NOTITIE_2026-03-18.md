# T027 Wachtwoord Reset Flow Implementatie Notitie

- Datum: `2026-03-18`
- Scope: volledige resetflow voor accounttoegang

## Opgeleverd

- Publieke auth-routes:
  - `GET /forgot-password`
  - `POST /forgot-password`
  - `GET /reset-password/{token}`
  - `POST /reset-password`
- Nieuwe controllers:
  - `PasswordResetLinkController`
  - `NewPasswordController`
- Nieuwe views:
  - `resources/views/pages/auth/forgot-password.blade.php`
  - `resources/views/pages/auth/reset-password.blade.php`
- Loginpagina verwijst nu naar "Wachtwoord vergeten".

## Gedrag

- Aanvraag resetlink op e-mail.
- Bij geldige token kan gebruiker nieuw wachtwoord instellen.
- Ouder wachtwoord wordt vervangen; remember token wordt vernieuwd.
- Bij ongeldige/verlopen token duidelijke foutmelding.

## Validatie

- Feature tests toegevoegd:
  - `AuthPasswordResetFlowTest`
- Suite groen na implementatie.
