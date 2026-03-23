# Performance Targets V1

- Datum: `2026-03-19`
- Status: `vastgelegd` voor MVP onder Architectuurkeuze C
- Scope: publieke kernroutes `/, /cursussen, /lessen, /certificaat-verificatie`

## 1) Doel

Een eenduidig performantiebudget vastleggen voor MVP zodat:

1. kwaliteit objectief bewaakt wordt;
2. regressies vroeg gedetecteerd worden;
3. go-live beslissingen op meetbare KPI's steunen.

## 2) KPI-targets (MVP)

### Core rendering targets

- `TTFB <= 800ms`
- `FCP <= 2000ms`
- `LCP <= 2500ms`
- `CLS <= 0.1`
- `DCL <= 2500ms`
- `Load <= 5000ms`

### Payload-budget (entry bundles)

- `CSS app bundle <= 120KB` (niet-gezipt build artifact)
- `JS app bundle <= 80KB` (niet-gezipt build artifact)

## 3) Meetmethode (gating)

Primair gate-commando:

1. `npm run qa:performance`

Bronbestand:

1. `scripts/qa_performance_smoke.mjs`

Rapport-output:

1. `audit/qa_performance_smoke.json`
2. `audit/qa_performance_smoke.md`

## 4) Baseline snapshot (laatste meting)

Bron: `audit/qa_performance_smoke.md` op `2026-03-19T12:23:06.224Z`.

| Route | FCP | LCP | CLS | TTFB | DCL | Load | Status |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| `/` | 300ms | 300ms | 0 | 254.3ms | 274.5ms | 276.2ms | PASS |
| `/cursussen` | 316ms | 316ms | 0 | 285.5ms | 311.2ms | 316.5ms | PASS |
| `/lessen` | 300ms | 300ms | 0 | 249.6ms | 278.6ms | 291.2ms | PASS |
| `/certificaat-verificatie` | 280ms | 280ms | 0 | 234.1ms | 255.8ms | 257.7ms | PASS |

## 5) Beslisregels

1. Een route is `PASS` als alle KPI's onder drempel blijven.
2. De performance smoke is `FAIL` als minstens 1 route faalt.
3. Bij `FAIL` wordt geen roadmap-afvink gezet op performantie-gerelateerde taken tot herstel.

## 6) Cadans

1. Minstens 1x per sprint: `npm run qa:performance`.
2. Verplicht voor releasevoorbereiding: `npm run qa:nonfunctional`.
3. Na significante UI-wijzigingen (layout/animatie/filtering): performance smoke opnieuw draaien.

## 7) Notitie over stabiliteit

De smoke gebruikt een warm-up pass voor meetstabiliteit op lokale/staging context. Dit voorkomt dat een eenmalige eerste-hit bootstrap de gate onterecht rood zet.
