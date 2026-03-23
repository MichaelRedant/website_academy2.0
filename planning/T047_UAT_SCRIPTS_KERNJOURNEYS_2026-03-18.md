# T047 UAT Scripts Kernjourneys

- Datum: `2026-03-18`
- Doel: support/product een concrete, afvinkbare UAT-run geven voor de belangrijkste MVP-flows.

## Voorbereiding

1. Start lokaal:
   - `npm run monolith:setup`
   - `npm run monolith:serve`
2. Open `http://127.0.0.1:8000`.
3. Voor admin-tests:
   - gebruik credentials uit `planning/LOCAL_TEST_LOGIN_CREDENTIALS.md`.
4. Voor learner-tests:
   - registreer een nieuw account via `/register`.

## UAT Scenario's

### UAT-001 - Registratie en login learner

- Stap:
  1. Registreer nieuw learner-account.
  2. Log uit.
  3. Log opnieuw in met dat account.
- Verwacht:
  1. Redirect naar `/account`.
  2. Mijn account zichtbaar zonder foutmeldingen.
- Status: `[ ] PASS` `[ ] FAIL`
- Notities:

### UAT-002 - Cursus volgen en automatische certificaatuitgifte

- Stap:
  1. Open `/account/cursussen`.
  2. Open een gepubliceerde cursus.
  3. Markeer alle gepubliceerde lessen als voltooid.
- Verwacht:
  1. Op laatste les ontstaat automatisch certificaat.
  2. Redirect naar certificaatpagina.
  3. Cursusdetail toont certificaatstatus.
- Status: `[ ] PASS` `[ ] FAIL`
- Notities:

### UAT-003 - PDF-download certificaat

- Stap:
  1. Open certificaatpagina.
  2. Klik `Download PDF`.
- Verwacht:
  1. Er wordt een echte `.pdf` file gedownload.
  2. Certificaat bevat naam, cursus, certificaatnummer en verificatiecode.
- Status: `[ ] PASS` `[ ] FAIL`
- Notities:

### UAT-004 - Publieke verificatie geldig

- Stap:
  1. Kopieer certificaatnummer.
  2. Open `/certificaat-verificatie`.
  3. Verifieer met certificaatnummer.
- Verwacht:
  1. Status toont `Geldig certificaat`.
  2. Correcte deelnemer en cursus zichtbaar.
- Status: `[ ] PASS` `[ ] FAIL`
- Notities:

### UAT-005 - Admin intrekking en publieke verificatie ingetrokken

- Stap:
  1. Log in als content manager/admin.
  2. Open `/admin/certificaten`.
  3. Klik `Intrekken` op actief certificaat.
  4. Verifieer opnieuw via publieke verificatiepagina.
- Verwacht:
  1. Certificaatstatus in admin op `Ingetrokken`.
  2. Publieke verificatie toont `Ingetrokken certificaat`.
- Status: `[ ] PASS` `[ ] FAIL`
- Notities:

### UAT-006 - Admin heruitgave en nieuwe validatie

- Stap:
  1. In adminmodule klik `Heruitgeven`.
  2. Verifieer oud certificaatnummer.
  3. Verifieer nieuw certificaatnummer.
- Verwacht:
  1. Oud nummer blijft `Ingetrokken`.
  2. Nieuw nummer wordt `Geldig`.
  3. Auditinformatie zichtbaar in adminoverzicht.
- Status: `[ ] PASS` `[ ] FAIL`
- Notities:

## Defect logging tijdens UAT

- Gebruik per bevinding:
  - ID: `UAT-BUG-XXX`
  - Ernst: `P0` / `P1` / `P2`
  - Scenario-ref: `UAT-00X`
  - Beschrijving
  - Verwacht vs. effectief resultaat
  - Beslissing: `fix nu` / `post-MVP`

## UAT Sign-off blok

- Datum uitvoering:
- Uitvoerders:
  - Product:
  - Support:
  - Tech:
- Resultaat:
  - `[ ] GO`
  - `[ ] NO-GO`
- Open P0/P1 issues:
- Handtekening product owner:
