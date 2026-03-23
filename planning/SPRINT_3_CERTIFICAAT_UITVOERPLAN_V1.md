# Sprint 3 Certificaat Uitvoerplan V1

- Datum: `2026-03-18`
- Scope: certificaattraject voor gratis cursussen met account-opvolging
- Doel: van "cursus gevolgd" naar verifieerbaar certificaat in productieklare flow

## Uitgangspunten

- Cursussen en lessen blijven gratis.
- Account is nodig om volledige cursusopvolging en certificaatuitgifte mogelijk te maken.
- Certificaat wordt alleen uitgereikt bij correcte voltooiing.

## Werkvolgorde

### 1) Voltooiingsregels vastleggen

- [x] Per cursus bepalen wanneer status `voltooid` is (100% verplicht of met uitzonderingen).
- [x] Regels voor optionele lessen vastleggen.
- [x] Productbeslissing documenteren in `architecture/` of `planning/`.

### 2) Datamodel + migraties

- [x] Tabel/model voor `certificates` toevoegen (`user_id`, `course_id`, `certificate_number`, `issued_at`, `verification_token`, `revoked_at`).
- [x] Unieke indexen voorzien op `certificate_number` en `verification_token`.
- [x] Relaties toegevoegd op `User` en `Course`; `Enrollment` volgt zodra het model in scope zit.

### 3) Voortgang naar voltooid

- [x] Progressieregel implementeren die cursusstatus op `voltooid` zet.
- [x] Herberekening voorzien bij wijziging van lesstatus of cursusinhoud.
- [x] Edge-cases afdekken (gearchiveerde les/cursus, terugzetten naar draft).

### 4) Certificaatuitgifte

- [x] Service maken voor uitgifte met idempotente logica (geen dubbele certificaten).
- [x] Certificaatnummerformat vastleggen (`OCA-YYYY-XXXXXX`).
- [x] Automatische certificaatuitgifte voorzien bij correcte cursusvoltooiing.
- [x] PDF-export voorzien met naam gebruiker, cursus, datum en certificaatnummer.

### 5) Certificaatweergave voor gebruiker

- [x] Account cursusdetail aangevuld met certificaatstatus.
- [x] Bekijk/printknop tonen bij uitgereikt certificaat.
- [x] Detailpagina voorzien met basisgegevens van certificaat.

### 6) Publieke verificatieflow

- [x] Publieke route/pagina voorzien voor verificatie op token of certificaatnummer.
- [x] Verificatie-uitkomst tonen (`geldig`, `ingetrokken`, `niet gevonden`).
- [x] Basis anti-abuse voorzien (rate limiting).

### 7) Backoffice beheer

- [x] Admin-actie voorzien: certificaat heruitgeven.
- [x] Admin-actie voorzien: certificaat intrekken.
- [x] Audittrail/logging voorzien op beheeracties.

### 8) QA + acceptatie

- [x] Feature tests voor uitgifte, download, verificatie en intrekking.
- [x] End-to-end testpad: aanmelden -> cursus volgen -> certificaat -> publieke verificatie.
- [ ] UAT checklist met support/product doorlopen.

## Definition of Done Sprint 3

- [x] Certificaat kan automatisch uitgereikt worden na correcte cursusvoltooiing.
- [x] Gebruiker kan certificaat downloaden vanuit account.
- [x] Publieke verificatie werkt betrouwbaar.
- [x] Backoffice kan certificaat heruitgeven/intrekken.
- [x] Alle relevante tests zijn groen.
