# Sprint 2 Takenbord V1

- Datum: `2026-03-18`
- Sprint: `Sprint 2` (10 werkdagen)
- Status: klaar voor uitvoering

## Teamrollen (voorgesteld)

1. `Lead FS` (integratie, architectuur, scope guard)
2. `Backend` (roles, policies, CRUD services)
3. `Frontend` (admin views/forms + protected pages)
4. `QA` (auth/policy/crud regressie + smoke)

## Takenbord

| Taak ID | Story/Spike | Type | Prioriteit | Owner | Schatting | Dagvenster | Afhankelijkheden | Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| T-016 | US-003 Rollenmodel + permissies implementatie (uit Sprint 1 deferred) | Story | Must | Backend | 1.5d | D1-D2 | SPK-02 | Done |
| T-017 | US-041 Policy middleware + route bescherming | Story | Must | Backend | 1.0d | D2-D3 | T-016 | Done |
| T-018 | US-040 Rollen toewijzing basisflow (admin) | Story | Should | Backend | 0.5d | D3 | T-016 | To do |
| T-019 | US-050 Admin backend skeleton (layout, nav, auth guard) | Story | Should | Frontend | 1.0d | D3-D4 | T-017 | Done |
| T-020 | US-051 Course CRUD (create/edit/list) | Story | Must | Backend | 1.5d | D4-D5 | T-019 | Done |
| T-021 | US-052 Lesson CRUD (create/edit/list) | Story | Must | Backend | 1.5d | D5-D6 | T-020 | Done |
| T-022 | US-053 Archive/deactivate flow voor courses/lessons | Story | Must | Backend | 1.0d | D6 | T-020,T-021 | Done |
| T-023 | US-054 Taxonomy beheer in admin (categorie/tag) | Story | Should | Frontend | 1.0d | D6-D7 | T-019 | Done |
| T-024 | US-060 Protected cursusdetail route + policy checks | Story | Must | Frontend | 1.0d | D7-D8 | T-017,T-020 | Done |
| T-025 | US-061 Protected lesdetail + navigatie | Story | Must | Frontend | 1.0d | D8 | T-024,T-021 | Done |
| T-026 | US-062 Basis \"mijn cursussen\" flow | Story | Should | Frontend | 0.5d | D8 | T-024 | To do |
| T-027 | US-070/071 QA auth/policy/crud testexecutie + smoke | QA | Must | QA | 1.0d | D9 | T-016..T-026 | To do |
| T-028 | Sprint 2 demo prep + release notes | Delivery | Must | Lead FS | 0.5d | D10 | T-027 | To do |
| T-029 | SPK-04 Admin UX keuze (formulier/editor aanpak) | Spike | Could | Lead FS | 0.5d | D4 | T-019 | To do |
| T-030 | SPK-05 Media upload lifecycle (valideren + opslagstrategie) | Spike | Could | Backend | 0.5d | D7 | T-021 | To do |

## Dagelijkse ceremonie focus

1. Dagstart: blockers + auth/policy risico's expliciet bespreken.
2. Mid-sprint: CRUD stabiliteit + scopecheck op Must.
3. Eind sprint: demo op echte admin flow zonder DB shortcuts.

## Done-criteria per taak

1. Code in branch met review.
2. Relevante tests toegevoegd of geupdate.
3. Korte technische notitie in PR.
4. Geen blocker open op taakniveau.
