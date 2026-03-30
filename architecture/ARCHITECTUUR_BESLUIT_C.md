# Architectuurbesluit C 

- Datum: `2026-03-17`
- Status: bevestigd
- Referentie: `architecture/ARCHITECTUUR_KEUZEMATRIX.md`

## Beslissing

We kiezen voor **Optie C: full custom monolith**.

## Doelstack (V1)

1. Framework: Laravel monolith (huidige stabiele major op startmoment implementatie).
2. Rendering: server-side web met Blade als basis.
3. Database: PostgreSQL.
4. Caching/queue: Redis.
5. Auth: session-based auth met eigen rollenmodel.
6. CMS/admin: eigen admin in hetzelfde platform (geen headless WP).
7. LMS: eigen module voor courses, lessons, enrollments, progressie en certificaten.

## Waarom deze keuze

1. Maximaal controle over data, rollen en businesslogica.
2. Geen afhankelijkheid meer van de huidige WordPress/LearnDash pluginstack.
3. Eenduidige codebase voor frontend, backend en admin.

## Gevolgen voor roadmap

1. Fase 2 focust op monolith architectuurdetails in plaats van headless keuzes.
2. Fase 5-6 omvatten ook opbouw van eigen admin en LMS-kern.
3. Migratie van content en rechten vraagt expliciete datamapping en validatie.

## Open uitwerkingen (volgende stap)

1. Definitieve keuze frontend interactielaag binnen Laravel (Blade-only of met componentlaag).
2. Publicatieworkflow exact definiëren (draft/review/publish rechten en approvals).
