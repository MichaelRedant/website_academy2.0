# Sprint 2 Backlog V1 (Optie C Monolith)

- Datum: `2026-03-18`
- Sprintduur: `2 weken` (10 werkdagen)
- Doel: rollen/policies activeren en contentbeheer backend opleveren voor cursussen + lessen

## Sprintdoel

Werkende beveiligde basis opleveren van het nieuwe platform met:

1. Rollenmodel en policy enforcement op kritieke routes.
2. Admin backend voor cursus- en lesbeheer.
3. Public/private lesson toegang op basis van policy checks.
4. Basis publicatieflow (`draft`, `published`, `archived`) in contentbeheer.

## User Stories (Sprint 2 focus)

### Epic E1 - Auth & Roles Activation

1. `US-003` Als admin wil ik een basis rollenmodel zodat toegang correct afgedwongen kan worden.
2. `US-040` Als admin wil ik gebruikersrollen kunnen toewijzen zodat beheer beheersbaar blijft.
3. `US-041` Als developer wil ik policy middleware op kernroutes zodat ongeautoriseerde toegang geblokkeerd wordt.

### Epic E2 - Contentbeheer Backend

1. `US-050` Als content manager wil ik een admin-overzicht van cursussen en lessen.
2. `US-051` Als content manager wil ik cursussen kunnen aanmaken en aanpassen.
3. `US-052` Als content manager wil ik lessen kunnen aanmaken en aanpassen.
4. `US-053` Als content manager wil ik cursussen/lessen kunnen deactiveren of archiveren.
5. `US-054` Als content manager wil ik categorieen en tags kunnen beheren.

### Epic E3 - LMS Protected Core

1. `US-060` Als gebruiker wil ik cursusdetail kunnen openen volgens toegangsregels.
2. `US-061` Als gebruiker wil ik lesdetail en lesnavigatie gebruiken volgens toegangsregels.
3. `US-062` Als ingelogde gebruiker wil ik een basis "mijn cursussen" flow zien.

### Epic E4 - QA & Security Hardening

1. `US-070` Als team wil ik auth/policy regressietests zodat toegang niet regressief breekt.
2. `US-071` Als team wil ik smoke checks op admin routes en CRUD flows.

## MoSCoW Prioritering (Sprint 2)

## Must

1. `US-003`, `US-041`
2. `US-051`, `US-052`, `US-053`
3. `US-060`, `US-061`
4. `US-070`

## Should

1. `US-050`, `US-054`
2. `US-062`
3. `US-071`

## Could

1. Bulkacties in admin (multi-select archive/unpublish)
2. Basis auditlog op contentwijzigingen

## Won't (in Sprint 2)

1. Finale certificaatgenerator en verificatie-automatisatie
2. Geavanceerde analytics dashboards
3. Volledige meertalige contentworkflow

## Technische Spikes (Sprint 2)

1. `SPK-04` Admin UX keuze voor formulieren/editor (Blade native vs component package).
2. `SPK-05` Media upload lifecycle (validatie, opslag, cleanup policy).

## Planning per werkdag (indicatief)

1. Dag 1-2: roles/permissies + middleware/policies.
2. Dag 3-5: admin routes + course/lesson CRUD.
3. Dag 6-7: publicatiestatus + taxonomy beheer.
4. Dag 8: protected course/lesson detail routes.
5. Dag 9: QA auth/policy/crud tests.
6. Dag 10: demo + release notes + retro input.

## Sprint 2 Definition of Done

1. Alle Must stories aantoonbaar werkend op staging/local demo.
2. Auth/policy tests groen met regressiecoverage op kritieke routes.
3. CRUD flow voor cursus/les bruikbaar voor content manager rol.
4. Demo mogelijk zonder manuele DB-ingrepen.

## Open afhankelijkheden

1. Definitieve keuze rond admin editor/rijke contentvelden.
2. Richtlijnen rond soft delete vs hard delete voor content.
3. Afstemming met business over publicatiecriteria per les.
