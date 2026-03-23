# T052 UAT Business/Support Dossier

- Datum dossier: `2026-03-19`
- Doel: directe uitvoering met business/support op basis van bestaande technische validatie.

## 1) UAT Sessiegegevens

- Geplande UAT datum: `in te vullen`
- Omgeving:
  - URL: `http://127.0.0.1:8000`
  - Build/commit: `n/a` (lokale workspace zonder git-revisie)
  - Database snapshot: lokale testdata + seeders
- Deelnemers:
  - Product: `in te vullen`
  - Support: `in te vullen`
  - Tech: `in te vullen`

## 2) Scenarioresultaten (vooringevuld op basis van technische dry-run)

| Scenario | Beschrijving | Resultaat (tech pre-UAT) | Bevinding-ID's | Opmerkingen voor business/support |
| --- | --- | --- | --- | --- |
| UAT-001 | Registratie en login learner | PASS | - | Live laten uitvoeren door support om copy/gebruiksgemak te valideren. |
| UAT-002 | Cursus volgen en automatische certificaatuitgifte | PASS | - | Live laten valideren op begrijpelijkheid van flow. |
| UAT-003 | PDF-download certificaat | PASS | - | Live controleren op leesbaarheid/branding in browser van support. |
| UAT-004 | Publieke verificatie geldig | PASS | - | Live valideren met effectief gecopieerd certificaatnummer. |
| UAT-005 | Admin intrekking + publieke verificatie ingetrokken | PASS | - | Live valideren dat support statussen correct uitlegt. |
| UAT-006 | Admin heruitgave + oude/nieuwe validatie | PASS | - | Live valideren dat heruitgifteproces operationeel duidelijk is. |

## 3) Uitgevoerde technische bewijsrun

```bash
npm run qa:uat:tech-dryrun
```

- Resultaat op `2026-03-19`: `27 passed` (`134 assertions`).
- Referentie: `planning/T051_UAT_TECHNISCHE_DRYRUN_2026-03-18.md`

## 4) Bevindingenlog (live UAT in te vullen)

| ID | Ernst | Scenario | Beschrijving | Verwacht | Effectief | Beslissing |
| --- | --- | --- | --- | --- | --- | --- |
| UAT-BUG-001 | P0/P1/P2 | UAT-00X | | | | fix nu / post-MVP |

## 5) Go/No-Go Checklist

- `[ ]` Geen openstaande `P0`.
- `[ ]` Geen openstaande `P1` zonder expliciete businessacceptatie.
- `[ ]` Support bevestigt dat kernflows uitlegbaar en werkbaar zijn.
- `[ ]` Product owner accepteert resterende risico's.

## 6) Formele Beslissing

- Beslissing:
  - `[ ] GO`
  - `[ ] NO-GO`
- Reden beslissing:
- Scopebeperkingen:
- Vereiste opvolgacties:

## 7) Sign-Off

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
