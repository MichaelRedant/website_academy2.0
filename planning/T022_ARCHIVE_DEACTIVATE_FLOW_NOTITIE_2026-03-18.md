# T-022 Implementatienotitie (Archive/Deactivate flow)

- Datum: `2026-03-18`
- Taak: `T-022`
- Story: `US-053`

## Wat is geimplementeerd

1. Course archive/reactivate acties toegevoegd:
   - `POST /admin/cursussen/{course}/archiveren`
   - `POST /admin/cursussen/{course}/activeren`
   - Controller: `CourseCrudController::archive()` en `::activate()`
2. Lesson archive/reactivate acties toegevoegd:
   - `POST /admin/lessen/{lesson}/archiveren`
   - `POST /admin/lessen/{lesson}/activeren`
   - Controller: `LessonCrudController::archive()` en `::activate()`
3. Cascadegedrag op course archive:
   - Bij archiveren van een cursus worden gekoppelde lessen automatisch ook `archived`.
4. Reactivatiegedrag:
   - Reactiveren zet status terug naar `draft` (veilig, niet direct live/published).
5. Admin UI uitgebreid:
   - Archiveren/activeren knoppen op course en lesson overzicht.
   - Archiveren/activeren knoppen op course en lesson edit-forms.
   - Visuele statusaccenten voor `archived`.

## Tests

Aangepast:

1. `tests/Feature/AdminCourseCrudTest.php`
   - learner mag archive actie niet uitvoeren
   - content_manager kan cursus archiveren
   - bij cursus archive worden gekoppelde lessen gearchiveerd
   - content_manager kan cursus opnieuw activeren (naar `draft`)
2. `tests/Feature/AdminLessonCrudTest.php`
   - learner mag lesson archive actie niet uitvoeren
   - content_manager kan les archiveren
   - content_manager kan les opnieuw activeren (naar `draft`)

## Validatie

1. `npm run monolith:test` OK
2. `npm run monolith:build` OK

## Resultaat

De veilige deactivation-flow is operationeel zonder hard delete. Content kan nu gecontroleerd uit publicatie gehaald en later opnieuw geactiveerd worden.
