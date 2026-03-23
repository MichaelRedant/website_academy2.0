# Auth/Roles Spike V1 (SPK-02)

- Datum: `2026-03-17`
- Scope: keuze van rollen- en permissiestrategie voor Laravel monolith (MVP)
- Referentie: `planning/SPRINT_1_TAKENBORD_V1.md` taak `T-003`

## Doel van de spike

Een pragmatische keuze maken voor authenticatie en autorisatie die:

1. snel implementeerbaar is in Sprint 1,
2. schaalbaar blijft voor LMS-flows,
3. expliciet auditeerbaar is voor support/admin.

## Opties

## Optie A: enkel native Laravel Gates/Policies

- Plus:
  - geen extra package.
  - volledige controle in eigen code.
- Min:
  - rollenbeheer moet volledig custom gebouwd worden.
  - extra werk voor beheer en toewijzing van permissies.

## Optie B: enkel RBAC package (Spatie Laravel Permission)

- Plus:
  - snelle rol/permissie modeling.
  - bewezen package, brede community.
  - middleware en helpers out-of-the-box.
- Min:
  - package-afhankelijkheid.
  - businessregels in policies blijven alsnog nodig.

## Optie C: hybride (Spatie voor RBAC + native Policies voor domeinregels)

- Plus:
  - snelle opstart met duidelijke rollen/permissies.
  - domeinspecifieke checks blijven in policies (leesbaar/testbaar).
  - goede balans tussen snelheid en controle.
- Min:
  - twee conceptlagen vereisen duidelijke conventies.

## Gekozen richting

`Optie C` wordt aanbevolen en gekozen voor MVP:

1. Spatie package voor rol/permissie-toewijzing.
2. Laravel Policies voor resource-logica (`Course`, `Lesson`, `Enrollment`, `Certificate`).
3. Middleware op routegroepniveau voor coarse-grained toegang.

## Voorstel MVP-rollen

1. `guest` (niet ingelogd, publieke catalogus)
2. `learner` (ingelogde cursist)
3. `instructor` (inhoud onderhoud binnen toegewezen scope)
4. `content_manager` (catalogusbeheer, publicatiecontrole)
5. `admin` (globale beheerrechten)

## Voorstel kernpermissies MVP

1. `catalog.view`
2. `course.view`
3. `course.manage`
4. `lesson.view`
5. `lesson.manage`
6. `enrollment.view_own`
7. `enrollment.manage`
8. `certificate.verify`
9. `user.manage_roles`

## Implementatieconventies

1. Rollen/permissies seeden via dedicated seeder (`RolesAndPermissionsSeeder`).
2. Policies bevatten altijd resource-context; geen businesslogica in controllers.
3. Controller/middleware checkt alleen coarse access, policy checkt fine-grained rule.
4. Naming van permissies blijft `domein.actie`.

## Risico's en mitigatie

1. Risico: permissies prolifereren te snel.
   Mitigatie: permissie-catalogus beheren in 1 centrale seeder + review in PR.
2. Risico: overlap tussen middleware en policy checks.
   Mitigatie: conventie documenteren en tests voorzien op policy-niveau.

## Output van de spike

1. Beslissing auth/roles strategie bevestigd.
2. Input klaar voor implementatietaak `T-004` (rollenmodel + policies).
