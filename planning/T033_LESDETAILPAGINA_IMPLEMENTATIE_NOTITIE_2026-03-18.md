# T033 Lesdetailpagina Implementatie Notitie

- Datum: `2026-03-18`
- Scope: Lesdetailpagina afronden op publiek en account niveau

## Wat is opgeleverd

- Publieke lesdetail (`/cursussen/{courseSlug}/lessen/{lessonSlug}`):
  - toont nu lespositie (`les x van y`) binnen de cursus.
- Account lesdetail (`/account/cursussen/{course:slug}/lessen/{lesson:slug}`):
  - toont nu positie badge (`positie x van y`) in de header,
  - toont een duidelijke fallbackboodschap wanneer video-embed niet ondersteund is,
  - blijft altijd een externe videolink aanbieden als `video_url` aanwezig is.

## Technische updates

- `LessonDetailController` geeft `lessonPosition` door aan de view.
- `AccountLessonDetailController` geeft `lessonPosition` door en houdt bestaande navigatie intact.

## Testdekking

- `PublicCatalogDetailPagesTest` uitgebreid met checks op lespositie.
- `ProtectedLessonDetailTest` uitgebreid met:
  - positiecontrole op account lesdetail,
  - fallbackscenario voor niet-embeddable video URL.
