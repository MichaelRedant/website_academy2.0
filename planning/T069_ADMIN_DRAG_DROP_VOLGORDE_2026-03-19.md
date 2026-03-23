# T069 Admin Drag-and-Drop Volgorde

- Datum: `2026-03-19`
- Doel: admin laat cursussen en lessen visueel herordenen met drag-and-drop, met directe impact op publieke volgorde.

## Opgeleverd

1. Datamodel:
   - nieuwe kolom `courses.display_order` via migration.
2. Admin routes (opslaan):
   - `PUT /admin/cursussen/volgorde`
   - `PUT /admin/lessen/volgorde`
3. Admin UI:
   - inline drag-and-drop lijst onder `Admin > Cursussen`
   - inline drag-and-drop lijst onder `Admin > Lessen` (met cursusselectie)
4. Navigatie:
   - geen aparte `Volgorde` sectie in admin zijmenu
   - quick-links binnen cursus- en lessenbeheer

## Publieke impact

1. Cursusvolgorde op publieke lijsten volgt `courses.display_order`.
2. Lesvolgorde binnen cursusdetail volgt `lessons.order_index`.
3. Lessenoverzicht volgt eerst cursusvolgorde, daarna lesvolgorde.

## Fallback

1. Als `display_order` nog niet gemigreerd is:
   - cursus reorder toont duidelijke melding,
   - applicatie valt terug op stabiele fallback sortering.

## Testdekking

1. Nieuwe feature test `AdminContentOrderTest`:
   - reorder cursussen
   - reorder lessen
   - publieke volgorde volgt admin-configuratie
2. `AdminSkeletonTest` geupdate met nieuwe pagina's.
3. `RouteProtectionTest` geupdate met protectie op reorder routes.
