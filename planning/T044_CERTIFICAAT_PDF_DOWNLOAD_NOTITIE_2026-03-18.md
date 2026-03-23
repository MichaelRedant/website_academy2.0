# T044 Certificaat PDF Download Notitie

- Datum: `2026-03-18`
- Scope: echte PDF-download voor certificaten in accountflow

## Wat is opgeleverd

- PDF-engine toegevoegd:
  - package `dompdf/dompdf` (v3.0.0)
- Nieuwe beveiligde route:
  - `GET /account/certificaten/{certificate}/download`
  - route name: `account.certificates.download`
- `AccountCertificateController` uitgebreid met `download()`:
  - zelfde toegangscontrole als certificaatweergave,
  - rendert dedicated PDF-template,
  - force-download met bestandsnaam op basis van cursus + certificaatnummer.
- Nieuwe PDF-template:
  - `resources/views/pages/account/certificates/pdf.blade.php`
  - A4 landscape, merkstijl en certificaatmetadata.

## UI-aanpassingen

- Certificaatpagina:
  - knop `Download PDF`
  - aparte `Print` knop blijft beschikbaar
- Mijn cursussen:
  - extra `Download PDF` knop bij bestaande certificaten
- Cursusdetail in account:
  - extra `Download PDF` knop in certificaatblok

## Testdekking

- `AccountCertificateFlowTest`
  - owner kan PDF downloaden (`content-type: application/pdf`)
  - niet-owner kan PDF niet downloaden (`404`)
- `AccountCoursesOverviewTest`
  - downloadlink zichtbaar wanneer certificaat aanwezig is

## Verificatie

- Gerichte tests op certificaatflow en accountoverzicht geslaagd.
- Volledige regressie en build daarna opnieuw groen.
