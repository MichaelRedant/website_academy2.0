# T031 Auth Anti-Spam Implementatie Notitie

- Datum: `2026-03-18`
- Scope: Captcha/anti-spam bescherming op publieke auth formulieren

## Wat is opgeleverd

- Anti-spam middleware toegevoegd:
  - `ValidateAcademyAntiSpam`
  - controle op honeypot veld + minimum/maximum submit-tijd
- Middleware alias geregistreerd:
  - `academy.anti_spam`
- Publieke auth POST routes afgeschermd:
  - `/login`
  - `/register`
  - `/forgot-password`
  - `/reset-password`
- Auth forms uitgebreid met verborgen anti-spam velden via herbruikbare partial:
  - `partials/anti-spam-fields.blade.php`

## Extra hardening

- Rate limiting toegevoegd per route met sleutel op IP + e-mail:
  - `academy-login`
  - `academy-register`
  - `academy-password-email`
  - `academy-password-reset`

## Configuratie

- Nieuwe instellingen in `config/academy.php`:
  - `anti_spam.enabled`
  - `anti_spam.honeypot_field`
  - `anti_spam.timestamp_field`
  - `anti_spam.minimum_submit_seconds`
  - `anti_spam.maximum_submit_seconds`
- Environment variabelen toegevoegd in `.env.example`:
  - `ACADEMY_ANTISPAM_ENABLED`
  - `ACADEMY_ANTISPAM_HONEYPOT_FIELD`
  - `ACADEMY_ANTISPAM_TIMESTAMP_FIELD`
  - `ACADEMY_ANTISPAM_MIN_SECONDS`
  - `ACADEMY_ANTISPAM_MAX_SECONDS`

## Testdekking

- Nieuwe feature test `AuthAntiSpamTest`:
  - ingevulde honeypot wordt geblokkeerd
  - te snelle submit wordt geblokkeerd
- Bestaande auth flow tests aangepast met geldige anti-spam payload:
  - `AuthLoginFlowTest`
  - `AuthRegistrationFlowTest`
  - `AuthPasswordResetFlowTest`
