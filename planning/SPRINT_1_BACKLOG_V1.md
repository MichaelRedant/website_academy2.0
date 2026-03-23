# Sprint 1 Backlog V1 (Optie C Monolith)

- Datum: `2026-03-17`
- Sprintduur: `2 weken` (10 werkdagen)
- Doel: fundament leggen voor custom monolith en eerste publieke flow

## Sprintdoel

Werkende basis opleveren van het nieuwe platform met:

1. Laravel monolith skeleton.
2. Publieke basisflow zonder rollenstructuur (rollen verschoven na Sprint 1).
3. Basis contentmodel (`Course`, `Lesson`, `Category`, `Tag`).
4. Publieke pagina skeleton (`home`, `cursussen`, `how-tos`).
5. Eerste zoek/filter endpoint (database-first).

## User Stories (MVP)

### Epic E1 - Platform Foundation

1. `US-001` Als developer wil ik een gestandaardiseerde Laravel projectbasis zodat teamleden op dezelfde structuur werken.
2. `US-002` Als developer wil ik dev/staging/prod config-sjablonen zodat deployment voorspelbaar is.
3. `US-003` Als admin wil ik een basis rollenmodel zodat toegang correct afgedwongen kan worden.

### Epic E2 - Public Catalog

1. `US-010` Als bezoeker wil ik de homepagina kunnen openen zodat ik de Academy kan ontdekken.
2. `US-011` Als bezoeker wil ik het cursusoverzicht zien zodat ik beschikbare leerinhoud kan bekijken.
3. `US-012` Als bezoeker wil ik het how-to overzicht zien zodat ik snel praktische topics vind.

### Epic E3 - Search/Filter Foundation

1. `US-020` Als bezoeker wil ik zoeken op titel zodat ik sneller relevante cursussen vind.
2. `US-021` Als bezoeker wil ik filteren op categorie/tag/level zodat ik gerichter kan browsen.

### Epic E4 - Data and Migration Foundation

1. `US-030` Als developer wil ik importeerbare seedstructuur voor taxonomieen zodat testdata consistent is.
2. `US-031` Als developer wil ik een eerste mapping-template van oude naar nieuwe content zodat migratie voorbereid is.

## MoSCoW Prioritering (Sprint 1)

## Must

1. `US-001`, `US-002`
2. `US-010`, `US-011`, `US-012`
3. `US-020`
4. `US-030`

## Should

1. `US-021`
2. `US-031`

## Could

1. Basis skeleton voor certificaatverificatie route (zonder finale logica)

## Won't (in Sprint 1)

1. Volledige LMS progressie
2. Video playback integratie
3. Complete account self-service
4. `US-003` Rollenmodel + policies (deferred naar Sprint 2)

## Technische Spikes (Sprint 1)

1. `SPK-01` Laravel zoekimplementatie benchmark (PostgreSQL FTS + trigram).
2. `SPK-02` Rollen en permissiestrategie in Laravel (policies/gates) voor LMS domein.
3. `SPK-03` Seed/import aanpak voor legacy taxonomy data.

## Planning per werkdag (indicatief)

1. Dag 1-2: repo/bootstrap, environment templates, CI skeleton.
2. Dag 3-4: publieke routes + controllers + Blade templates.
3. Dag 5-6: search endpoint + filters + DB indexing.
4. Dag 7-8: seed/import templates + mapping-template.
5. Dag 9: smoke tests en sprint QA.
6. Dag 10: bugfix, polish, sprint demo voorbereiding.

## Sprint 1 Definition of Done

1. Alle Must stories op staging bewezen.
2. Unit en integratietests voor kritieke paden groen.
3. Basis performance smoke test uitgevoerd.
4. Demo aan stakeholders mogelijk zonder mockups.

## Open afhankelijkheden

1. Definitieve hostingomgeving en secretsbeleid.
2. Toegang tot productie-export voor migratievoorbereiding.
3. Teamcapaciteit bevestiging.
4. Lokale Laravel runtime bevestigd via `scripts/check_prereqs.ps1`.
