# T053 Freeze Window Plan

- Datum: `2026-03-19`
- Scope: voorbereiding op go-live van Octopus Academy.
- Status: `v1 - voorstel`.
- Context:
  - Omdat Octopus Academy nog niet live staat, is dit nu een toekomst-playbook.
  - Voor huidige werking zonder downtime is `Safe State` voorzien (zie `planning/T054_SAFE_STATE_MODE_IMPLEMENTATIE_2026-03-19.md`).

## 1) Doel van de freeze

Het risico op regressies vlak voor livegang beperken door een gecontroleerde periode met wijzigingsstop.

## 2) Voorstel timing (werkhypothese)

- Freeze start: `2026-03-30 09:00` (CET)
- Freeze einde: `2026-04-03 18:00` (CET)
- Geplande go-live window: `2026-04-07 07:00 - 10:00` (CET)

Opmerking:
- Definitieve activatie van dit venster gebeurt pas na formele UAT sign-off (`GO`).

## 3) Wat valt onder freeze

- Code changes op productiegerelateerde routes, controllers, views, policies, migrations.
- Contentwijzigingen op cursus- en lesdata die meegaan naar de live sync.
- Wijzigingen aan auth/account/certificaat flows.
- Wijzigingen aan infrastructuur- of deployscripts voor productie.

## 4) Wat is nog toegelaten tijdens freeze

- `P0` fixes (kritiek, blocker voor live).
- `P1` fixes enkel met expliciete goedkeuring van product owner + tech lead.
- Niet-functionele updates zonder risico op regressie (documentatie, interne checklists).

## 5) Change control tijdens freeze

Elke uitzondering bevat verplicht:

1. Ticket-ID + risico-inschatting.
2. Omschrijving impact op learner/admin flows.
3. Testbewijs (gericht + regressie).
4. Expliciete approvals van:
   - Product owner
   - Tech lead

## 6) Rollen en verantwoordelijkheid

- Product owner:
  - finale business-go/no-go
  - goedkeuring P1 uitzonderingen
- Tech lead:
  - technische risico-evaluatie
  - vrijgave van hotfixes
- Support lead:
  - bevestiging operationele readiness
  - validatie van FAQ/supportflow

## 7) Entry criteria freeze

- QA checklist Fase 9 volledig groen (reeds gehaald).
- UAT uitgevoerd met business/support.
- Open `P0 = 0`.
- Open `P1 = 0` of expliciet geaccepteerd.

## 8) Exit criteria freeze

- Finale content sync bevestigd.
- DNS/switch + rollbackplan bevestigd.
- Incident runbook en on-call planning bevestigd.
- Go-live checklist op groen.

## 9) Beslismomenten

- `2026-03-27 15:00`: freeze readiness check.
- `2026-03-30 09:00`: freeze start decision.
- `2026-04-03 16:00`: pre-launch go/no-go meeting.
- `2026-04-07 06:30`: launch execution call.
