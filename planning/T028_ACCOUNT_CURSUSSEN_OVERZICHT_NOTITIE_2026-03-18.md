# T028 Account Cursussen Overzicht Notitie

- Datum: `2026-03-18`
- Scope: route en pagina voor "Mijn account" corrigeren naar een bruikbaar cursusoverzicht

## Opgeleverd

- Route `/account/cursussen` gebruikt nu een echte controller i.p.v. placeholder response.
- Nieuwe controller: `AccountCoursesOverviewController`.
- Nieuwe view: `resources/views/pages/account/courses/index.blade.php`.
- Overzicht toont cursussen, status, aantal lessen en certificaatstatus.
- Link "Mijn account" in de header wijst correct naar dit overzicht.

## Gedrag

- Learner/instructor ziet enkel gepubliceerde cursussen.
- Content manager/admin ziet alle cursusstatussen.
- Als certificaat bestaat voor een cursus, verschijnt directe link naar certificaatpagina.

## Validatie

- Feature tests toegevoegd:
  - `AccountCoursesOverviewTest`
- Bestaande route-protectie test geüpdatet.
