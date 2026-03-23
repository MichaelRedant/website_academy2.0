# T057 Incident Runbook

- Datum: `2026-03-19`
- Doel: snelle, consistente incidentafhandeling voor Octopus Academy.
- Context: voorbereid voor launchfase; nu al bruikbaar in staging/dev.

## 1) Severity model

- `P0`:
  - volledige onbeschikbaarheid van kritieke flow (home/login/account/cursus/les/certificaatverificatie)
  - of datacorruptie/security-incident
  - reactietijd: onmiddellijk
- `P1`:
  - zware degradatie zonder complete outage
  - belangrijke flow onbruikbaar voor significante groep gebruikers
  - reactietijd: binnen 15 minuten
- `P2`:
  - beperkte impact, workaround mogelijk
  - reactietijd: binnen 4 werkuren

## 2) Rollen tijdens incident

- Incident commander (tech lead):
  - leidt triage, beslist herstelpad/rollback
- Communicatie-owner (product/support):
  - interne updates en gebruikerscommunicatie
- Executor:
  - voert technische acties uit (safe state, rollback, fix)
- Notulist:
  - tijdlijn + beslissingen registreren

## 3) Detectiekanalen

- Monitoring/alerts (5xx, latency, availability)
- Supportmeldingen
- Handmatige smoke checks
- QA signalen bij release-activiteiten

## 4) Eerste 15 minuten (triageprotocol)

1. Incident-ID aanmaken: `INC-YYYYMMDD-XXX`.
2. Severity bepalen (`P0/P1/P2`).
3. Impact afbakenen:
   - welke route/flow
   - welke doelgroep (guest/learner/admin)
4. Beslissen:
   - Safe State inschakelen? (admin writes blokkeren)
   - onmiddellijke rollback nodig?
5. Eerste statusupdate uitsturen (intern + support).

## 5) Standaard herstelacties

### A) Login/account flow faalt

1. Controleer app-availability en foutpercentage.
2. Controleer recente deploy/config wijziging.
3. Draai gerichte tests:
   - `npm run monolith:artisan -- test --filter=AuthLoginFlowTest`
4. Indien P0 aanhoudt:
   - rollback starten volgens `T056`.

### B) Cursus/les flows stuk

1. Gerichte checks op:
   - `/cursussen`
   - `/lessen`
   - `/account/cursussen`
2. Gerichte tests:
   - `npm run monolith:artisan -- test --filter=AccountLessonProgressFlowTest`
3. Bij datamutatie-risico:
   - Safe State inschakelen op admin dashboard.

### C) Certificaatflow of verificatie faalt

1. Check:
   - `/account/certificaten/{token}`
   - `/certificaat-verificatie`
2. Gerichte tests:
   - `npm run monolith:artisan -- test --filter=AccountCertificateFlowTest`
   - `npm run monolith:artisan -- test --filter=PublicCertificateVerificationTest`
3. Indien kernflow onbeschikbaar:
   - classificeren als `P0` of `P1` en rollbackbeslissing nemen.

## 6) Communicatiesjablonen

### Eerste interne update

`Incident [INC-ID] - Severity [P0/P1/P2] - impact op [flow].`
`Starttijd [tijd]. Team bezig met triage. Volgende update binnen 15 min.`

### Update naar support

`We onderzoeken momenteel een probleem op [flow].`
`Impact: [kort]. Tijdelijke workaround: [indien beschikbaar].`
`Volgende update om [tijd].`

### Resolutiebericht

`Incident [INC-ID] opgelost om [tijd].`
`Root cause (voorlopig): [kort].`
`Natraject/postmortem volgt op [datum].`

## 7) Exitcriteria incident

- Kritieke flow weer stabiel.
- Geen actieve P0-impact.
- Monitoring terug binnen normale bandbreedte.
- Supportbriefing verstuurd.
- Incidentlog volledig ingevuld.

## 8) Post-incident (binnen 48u)

1. Postmortem uitvoeren:
   - oorzaak
   - impactduur
   - waarom detectie/escalatie wel of niet snel genoeg was
2. Correctieve acties oplijsten met owner + deadline.
3. Roadmap/backlog updaten.

## 9) Quick references

- Freeze plan: `planning/T053_FREEZE_WINDOW_PLAN_2026-03-19.md`
- Finale content sync: `planning/T055_FINALE_CONTENT_SYNC_PLAN_2026-03-19.md`
- DNS/rollback: `planning/T056_DNS_SWITCH_EN_ROLLBACKPLAN_2026-03-19.md`
- Safe State implementatie: `planning/T054_SAFE_STATE_MODE_IMPLEMENTATIE_2026-03-19.md`
