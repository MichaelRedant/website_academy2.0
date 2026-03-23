# T042 Cursusvoltooiing en Progressie Notitie

- Datum: `2026-03-18`
- Scope: basis voortgangsregistratie + certificaatregel "alle gepubliceerde lessen voltooid"

## Productregel (MVP)

- Een cursus telt als `voltooid` wanneer de gebruiker alle **gepubliceerde** lessen van die cursus als voltooid markeerde.
- Zonder volledige voortgang kan geen certificaat gegenereerd worden.
- Er zijn in MVP geen optionele lessen met uitzonderingslogica.

## Technische oplevering

- Nieuw datamodel:
  - migratie `lesson_completions` met unieke sleutel op `user_id + lesson_id`
  - model `LessonCompletion` + relaties op `User`, `Course`, `Lesson`
- Nieuwe service:
  - `App\Services\Progress\CourseProgressService`
  - berekent progress snapshot (`x/y`, `%`, `is_completed`, eerste onvoltooide les)
  - markeert les als voltooid / niet-voltooid
- Nieuwe account routes:
  - `POST /account/cursussen/{course}/lessen/{lesson}/voltooi`
  - `POST /account/cursussen/{course}/lessen/{lesson}/heropen`
- Nieuwe controller:
  - `AccountLessonProgressController`

## UI-impact

- Lesdetail in account:
  - voortgangsblok met percentage,
  - knop `Markeer als voltooid` / `Markering ongedaan maken`.
- Cursusdetail in account:
  - voortgangsweergave (`x/y` + progress bar),
  - certificaatactie enkel wanneer cursus `voltooid` is,
  - duidelijke melding als voortgang nog niet volledig is.
- Mijn cursussen overzicht:
  - voortgang per cursus zichtbaar.

## Certificaatflow

- `AccountCertificateController@issue` valideert nu server-side:
  - role + gepubliceerde cursus
  - actieve certificaten blijven idempotent
  - nieuwe uitgifte alleen bij volledige voortgang

## Testdekking

- Nieuwe feature test:
  - `AccountLessonProgressFlowTest`
- Aangepaste feature test:
  - `AccountCertificateFlowTest` (nu met voltooiingsvoorwaarde + negatief scenario)
- Volledige regressie + build groen.
