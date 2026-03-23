# Sprint 1 Takenbord V1

- Datum: `2026-03-17`
- Sprint: `Sprint 1` (10 werkdagen)
- Status: klaar voor uitvoering

## Teamrollen (voorgesteld)

1. `Lead FS` (architectuur, integratie, codekwaliteit)
2. `Backend` (domein, auth, policies, search query)
3. `Frontend` (Blade views, UX skeleton, filters UI)
4. `QA` (testcases, regressie, smoke)

## Takenbord

| Taak ID | Story/Spike | Type | Prioriteit | Owner | Schatting | Dagvenster | Afhankelijkheden | Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| T-001 | US-001 Laravel skeleton bootstrap | Story | Must | Lead FS | 1.5d | D1-D2 | runtime geverifieerd | Done |
| T-002 | US-002 Environment templates + config baseline | Story | Must | Lead FS | 1.0d | D1-D2 | T-001 | Done |
| T-003 | SPK-02 Auth/roles policy spike | Spike | Must | Backend | 1.0d | D2 | T-001 | Done |
| T-004 | US-003 Rollenmodel + policies implementatie | Story | Must | Backend | 1.5d | D3-D4 | T-003 | Deferred (Sprint 2) |
| T-005 | US-010 Home route/controller/view | Story | Must | Frontend | 1.0d | D5 | T-001 | Done |
| T-006 | US-011 Cursusoverzicht route/controller/view | Story | Must | Frontend | 1.5d | D5-D6 | T-001 | Done |
| T-007 | US-012 How-to overzicht route/controller/view | Story | Must | Frontend | 1.0d | D6 | T-001 | Done |
| T-008 | SPK-01 Search benchmark (FTS + trigram) | Spike | Must | Backend | 1.0d | D7 | T-001 | Done |
| T-009 | US-020 Search endpoint implementatie | Story | Must | Backend | 1.5d | D7-D8 | T-008 | Done |
| T-010 | US-021 Filter endpoint + UI koppeling | Story | Should | Frontend | 1.0d | D8 | T-009 | Done |
| T-011 | SPK-03 Seed/import aanpak | Spike | Should | Backend | 0.5d | D9 | T-001 | Done |
| T-012 | US-030 Seeders + minimale dataset | Story | Must | Backend | 1.0d | D9 | T-011 | Done |
| T-013 | US-031 Mapping-template pages/courses/lessons | Story | Should | Lead FS | 0.5d | D9 | audit input | Done |
| T-014 | QA smoke + testexecutie Sprint 1 | QA | Must | QA | 1.0d | D9-D10 | T-005..T-012 | Done |
| T-015 | Sprint demo prep + release notes | Delivery | Must | Lead FS | 0.5d | D10 | T-014 | Done |

## Dagelijkse ceremonie focus

1. Dagstart: blockers + scope guard op Must.
2. Midden sprint (D5): scopecheck Should/Could.
3. Eind sprint (D10): demo + retro + action items.

## Done-criteria per taak

1. Code in branch met review.
2. Relevante tests toegevoegd of geupdate.
3. Korte technische notitie in PR.
4. Geen blocker open op taakniveau.
