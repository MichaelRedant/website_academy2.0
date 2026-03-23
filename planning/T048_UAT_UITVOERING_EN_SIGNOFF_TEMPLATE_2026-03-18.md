# T048 UAT Uitvoering En Sign-Off Template

- Datum template: `2026-03-18`
- Doel: eenduidige uitvoering en formele beslissing (`GO` / `NO-GO`) voor Octopus Academy.

## 1) UAT Sessiegegevens

- UAT datum:
- Omgeving:
  - URL:
  - Build/commit:
  - Database snapshot:
- Deelnemers:
  - Product:
  - Support:
  - Tech:

## 2) Scenarioresultaten (op basis van T047)

Gebruik scenario's uit `planning/T047_UAT_SCRIPTS_KERNJOURNEYS_2026-03-18.md`.

| Scenario | Beschrijving | Resultaat | Bevinding-ID's | Opmerkingen |
| --- | --- | --- | --- | --- |
| UAT-001 | Registratie en login learner | PASS / FAIL | | |
| UAT-002 | Cursus volgen en automatische certificaatuitgifte | PASS / FAIL | | |
| UAT-003 | PDF-download certificaat | PASS / FAIL | | |
| UAT-004 | Publieke verificatie geldig | PASS / FAIL | | |
| UAT-005 | Admin intrekking + publieke verificatie ingetrokken | PASS / FAIL | | |
| UAT-006 | Admin heruitgave + oude/nieuwe validatie | PASS / FAIL | | |

## 3) Bevindingenlog

| ID | Ernst | Scenario | Beschrijving | Verwacht | Effectief | Beslissing |
| --- | --- | --- | --- | --- | --- | --- |
| UAT-BUG-001 | P0/P1/P2 | UAT-00X | | | | fix nu / post-MVP |

## 4) Go/No-Go Beslissingskader

- `[ ]` Geen openstaande `P0`.
- `[ ]` Geen openstaande `P1` zonder expliciete businessacceptatie.
- `[ ]` Kernflows learner + certificaten zijn `PASS`.
- `[ ]` Support kan standaardvragen afhandelen met huidige UI.
- `[ ]` Product owner heeft release-risico expliciet geaccepteerd.

## 5) Formele Beslissing

- Beslissing:
  - `[ ] GO`
  - `[ ] NO-GO`
- Reden beslissing:
- Scopebeperkingen (indien van toepassing):
- Vereiste opvolgacties voor productie:

## 6) Sign-Off

- Product owner:
  - Naam:
  - Datum:
  - Handtekening:
- Support lead:
  - Naam:
  - Datum:
  - Handtekening:
- Tech lead:
  - Naam:
  - Datum:
  - Handtekening:
