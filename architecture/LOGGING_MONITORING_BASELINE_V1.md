# Logging & Monitoring Baseline V1

- Datum: `2026-03-19`
- Status: `vastgelegd` voor MVP onder Architectuurkeuze C
- Scope: Laravel monolith (`publiek`, `account`, `admin`, `certificaten`)

## 1) Doel

Een duidelijke baseline vastleggen voor observability zodat:

1. incidenten sneller gedetecteerd worden;
2. oorzaakanalyse sneller en consistenter verloopt;
3. go/no-go beslissingen op meetbare signalen steunen.

## 2) Logging baseline

### Logkanalen per omgeving

1. `dev/local`:
   - default `stack` met `single` of `daily`;
   - niveau: `debug` toegestaan voor lokale troubleshooting.
2. `staging/prod`:
   - default `stack` met gecentraliseerde output (`stderr`, `syslog`, of externe sink);
   - niveau minimaal `info`, met alerts vanaf `error/critical`.

### Verplichte velden op applicatielogs

1. `timestamp`
2. `level`
3. `message`
4. `environment`
5. `route` (indien beschikbaar)
6. `request_id` of correlatie-id
7. `user_id` (indien ingelogd)
8. `ip` (geminimaliseerd waar nodig voor privacy)

### Te loggen eventtypes (MVP)

1. Auth events:
   - login success/fail
   - register success/fail
   - password reset aangevraagd/afgerond
2. Autorisatie events:
   - toegang geweigerd op admin/account beveiligde routes
3. Admin mutaties:
   - CRUD op cursussen/lessen/taxonomie
   - safe-state activatie/deactivatie
4. Certificaat events:
   - uitgifte
   - heruitgifte
   - intrekking
   - publieke verificatie (samengevat, met rate-limit context)
5. Systeemevents:
   - onverwachte exceptions (`error`/`critical`)
   - deployment/startup issues

### Niet loggen

1. Wachtwoorden, tokens, secrets, volledige credentials.
2. Volledige persoonlijke payloads waar het niet nodig is.
3. Overmatige debug-ruis in productie.

## 3) Monitoring baseline

### Availability & health

1. Health endpoint: `/up` moet actief bewaakt worden.
2. Kernschema voor uptime-checks:
   - `/`
   - `/cursussen`
   - `/lessen`
   - `/certificaat-verificatie`
3. Frequentie: om de 1 minuut in productie (of equivalent).

### Applicatie KPI's

1. HTTP 5xx rate
2. HTTP 4xx spikes op auth/certificaatroutes
3. P95 latency op kernroutes
4. TTFB regressies (in lijn met `PERFORMANCE_TARGETS_V1`)

### Alertdrempels (MVP-startpunt)

1. `P0` alert:
   - uptime-check faalt 3 opeenvolgende metingen op kritieke route;
   - of 5xx-rate >= 10% gedurende 5 minuten op kernflow.
2. `P1` alert:
   - 5xx-rate >= 3% gedurende 10 minuten;
   - of P95 latency > 2x normale baseline gedurende 10 minuten.
3. `P2` alert:
   - herhaaldelijke 4xx/rate-limit spikes op auth/certificaatverificatie.

## 4) Retentie & toegang

1. Applicatielogs:
   - minimum retentie `14 dagen` (align met huidige `daily` default).
2. Auditgegevens certificaten:
   - bewaren conform business/legal behoefte (minstens volledige MVP-periode).
3. Toegang:
   - enkel bevoegde admins/support;
   - least-privilege principe toepassen.

## 5) Incidentkoppeling

1. Severity- en triageflow volgen `planning/T057_INCIDENT_RUNBOOK_2026-03-19.md`.
2. Alerts moeten bruikbare context bevatten:
   - route/flow
   - fouttype
   - starttijd
   - eerste impactinschatting

## 6) Operationele checks per release

Voor release-go/no-go:

1. Logging actief op targetomgeving en schrijfbaar.
2. Alertingpad getest (testalert of gecontroleerde trigger).
3. Uptime checks op kernroutes groen.
4. Laatste niet-functionele smoke (`npm run qa:nonfunctional`) zonder blockers.

## 7) Cadans

1. Wekelijks: korte review van error trends en top incidents.
2. Per sprint: baseline valideren op nieuwe routes/features.
3. Voor launch: final alert tuning op echte traffic.
