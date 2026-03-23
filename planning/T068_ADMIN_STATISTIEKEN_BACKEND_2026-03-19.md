# T068 Admin Statistieken Backend

- Datum: `2026-03-19`
- Doel: admin een volledig statistiekenoverzicht geven van de Academy op een dedicated backendpagina.

## Opgeleverd

1. Nieuwe admin route:
   - `GET /admin/statistieken` (`admin.stats.index`)
2. Nieuwe controller:
   - `App\Http\Controllers\Admin\AdminStatisticsController`
3. Nieuwe view:
   - `resources/views/pages/admin/statistics.blade.php`
4. Navigatie-update:
   - item `Statistieken` toegevoegd in admin zijmenu.
5. Dashboard quick-link:
   - CTA `Bekijk alle statistieken` op admin dashboard.

## Inhoud van statistiekenpagina

1. KPI-cards:
   - gebruikers, nieuwe accounts, cursussen, lessen, certificaten, lesvoltooiingen, actieve learners.
2. Statusverdeling:
   - cursusstatus (`published`, `draft`, `archived`)
   - lesstatus (`published`, `draft`, `archived`)
3. Taxonomie-overzicht:
   - cursuscategorieen, lescategorieen, course tags
4. Activiteit:
   - lesvoltooiingen (7/30 dagen)
   - certificaataudit events (30 dagen)
5. Toplijsten:
   - top cursussen op aantal lessen
   - top cursussen op aantal certificaten
6. Certificaatacties:
   - gegroepeerd per actie (laatste 30 dagen)

## Fallback & robuustheid

1. Veilige query-resolvers met table checks en QueryException-fallback.
2. Bij ontbrekende tabellen:
   - duidelijke warning in UI,
   - waarden tonen `n.v.t.` i.p.v. 500-crash.

## Testdekking

1. Nieuwe feature tests:
   - `AdminStatisticsTest`:
     - admin toegang + kerncijfers zichtbaar
     - non-admin toegang geblokkeerd
     - fallback bij ontbrekende tabellen
2. Bestaande test geupdate:
   - `AdminSkeletonTest` controleert nu ook `Statistieken` navigatie en route.
