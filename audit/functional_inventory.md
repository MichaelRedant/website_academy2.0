# Functionele Inventaris (Fase 1)

- Datum: `2026-03-17`
- Scope: publiek toegankelijke flows en pagina's op `academy.octopus.be/nl`

## 1) Login flow

- URL: `https://academy.octopus.be/nl/my-account/`
- Gedetecteerd:
  - Loginformulier aanwezig
  - Inputvelden: `username`, `password`, `rememberme`, `redirect`, `user-registration-login-nonce`
  - Relevante accountlinks:
    - `/nl/my-account/edit-profile/`
    - `/nl/my-account/edit-password/`
    - `/nl/my-account/mijn-cursussen/`
    - `/nl/my-account/user-logout/`
  - Anti-spam/captcha marker gevonden in pagina-assets

## 2) Registratie flow

- URL: `https://academy.octopus.be/nl/registratie/`
- Gedetecteerd:
  - Registratieformulier aanwezig
  - Belangrijke velden:
    - `first_name`, `last_name`, `user_email`, `user_login`, `user_pass`, `user_confirm_password`
    - `ur_frontend_form_nonce`, `ur-user-form-id`, `ur-redirect-url`
  - Anti-spam markers:
    - `honeypot`
    - captcha marker gevonden in pagina-assets

## 3) Mijn account & mijn cursussen

- URLs:
  - `https://academy.octopus.be/nl/my-account/`
  - `https://academy.octopus.be/nl/my-account/mijn-cursussen/`
- Gedetecteerd:
  - Accountnavigatie aanwezig (profiel, wachtwoord, mijn cursussen, logout)
  - "Mijn cursussen"-pagina publiek bereikbaar als endpoint, maar toegang tot gebruikersinhoud hangt af van loginstatus/rollen

## 4) Cursus/les structuur

- Sitemaps tonen:
  - `10` cursus-URL's (`sfwd-courses`)
  - `94` les-URL's (`sfwd-lessons`)
- URL-patronen:
  - Cursussen: `/nl/Cursussen/<slug>/`
  - Lessen: `/nl/lessons/<slug>/` en via geneste cursuscontext in video sitemap

## 5) Certificaat-verificatie

- URL: `https://academy.octopus.be/nl/certificate-verification/`
- Gedetecteerd:
  - Specifieke certificaatverificatiepagina aanwezig
  - LearnDash certificate plugin assets geladen

## 6) Zoek/filter

- Algemene zoekinput (`name="s"`) aanwezig op kernpagina's
- Cursusoverzichten aanwezig:
  - `/nl/cursussen/`
  - `/nl/cursussen/alle-cursussen/`
  - `/nl/how-tos/`
- Taxonomie-endpoints in sitemap:
  - Categorieen (`/course-category/...`)
  - Tags (`/course-tag/...`)

## 7) Open punten voor verdiepingsaudit

- Nog functioneel testen:
  - exacte rechtenmodel per rol (student/admin/support)
  - complete certificaatverificatie-flow inclusief foutcases
  - filtergedrag en sortering op alle-cursussen pagina
  - edge cases registratie/login (duplicate account, wachtwoordpolicy, throttling)
