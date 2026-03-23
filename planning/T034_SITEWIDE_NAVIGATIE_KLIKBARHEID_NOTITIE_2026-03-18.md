# T034 Sitewide Navigatie & Klikbaarheid Notitie

- Datum: `2026-03-18`
- Scope: sitewide navigatie en klikbaarheid verbeteren op publiek + account + auth

## Wat is opgeleverd

- `public-header` uitgebreid naar consistente hoofdnavigatie:
  - desktop links: `Home`, `Cursussen`, `Lessen`, `Mijn account`/`Aanmelden`,
  - mobiele snelle navigatiechips met dezelfde links.
- Accountpagina's gebruiken nu ook deze gedeelde header:
  - dashboard,
  - account cursussen overzicht,
  - account cursusdetail,
  - account lesdetail,
  - profielpagina.
- Authpagina's gebruiken nu ook deze gedeelde header:
  - login,
  - registratie,
  - wachtwoord vergeten,
  - wachtwoord resetten.

## Klikbaarheid verbeterd

- Titels zijn nu ook klikbaar op kernoverzichten:
  - publieke cursussenlijst,
  - publieke lessenlijst,
  - account cursussenlijst,
  - lessenlijst binnen publieke cursusdetailpagina.

## Testdekking

- Nieuwe `SitewideNavigationTest`:
  - gast ziet sitewide links op publieke pagina's,
  - gast ziet sitewide links ook op loginpagina,
  - ingelogde learner ziet sitewide links op accountpagina's.
