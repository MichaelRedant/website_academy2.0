# T032 Cursusdetailpagina Implementatie Notitie

- Datum: `2026-03-18`
- Scope: Cursusdetailpagina afronden voor publieke bezoekers en accountgebruikers

## Wat is opgeleverd

- Publieke cursusdetail (`/cursussen/{courseSlug}`):
  - lessenlijst wordt nu altijd getoond (ook zonder login),
  - CTA en copy afgestemd op gratis toegang + accountvoordeel,
  - detailpagina toont geen videoplatform-labels meer.
- Account cursusdetail (`/account/cursussen/{course:slug}`):
  - extra navigatie: terug naar cursussenoverzicht,
  - snelle actie: "Start met les 1" zodra lessen beschikbaar zijn,
  - lescount badge toegevoegd in de header.

## Ondersteunende technische update

- `CatalogData::lessonsForCourse()` sorteert lessen alfabetisch op titel voor stabielere weergave.

## Testdekking

- `PublicCatalogDetailPagesTest` bijgewerkt:
  - publieke bezoekers zien nu lessen in cursusdetail + juiste CTA's.
- `ProtectedCourseDetailTest` uitgebreid:
  - account cursusdetail toont "Start met les 1" wanneer een les beschikbaar is.
