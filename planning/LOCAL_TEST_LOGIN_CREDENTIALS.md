# Lokale Test Login (Octopus Academy)

- Laatst bijgewerkt: `2026-03-27`
- Doel: snelle lokale testtoegang voor adminflow

## Admin login (lokaal)

- URL: `http://127.0.0.1:8000/login`
- E-mail: `admin@octopusacademy.test`
- Wachtwoord: `OctopusAdmin!2026`

## Test learner (legacy import demo)

- URL: `http://127.0.0.1:8000/login`
- E-mail: `michael.redant2@telenet.be`
- Wachtwoord: `TestyPass!2026`
- Naam in DB: `Testy Mctest`
- Rol: `learner`

Command dat hiervoor gebruikt is:

```bash
npm run monolith:artisan -- academy:import-users --file=src/exportOld.json --email=michael.redant2@telenet.be --name="Testy Mctest" --role=learner --default-password="TestyPass!2026"
```

## Belangrijk

- Deze credentials zijn enkel bedoeld voor lokale development/test.
- Niet gebruiken in staging of productie.
- Je kan deze waarden aanpassen in `monolith/.env`:
  - `ACADEMY_ADMIN_NAME`
  - `ACADEMY_ADMIN_EMAIL`
  - `ACADEMY_ADMIN_PASSWORD`

Voor staging/online wordt deze admin niet automatisch aangemaakt via `DatabaseSeeder`.
Gebruik daar expliciet:

```bash
php artisan academy:ensure-admin
```

Optioneel met expliciete waarden:

```bash
php artisan academy:ensure-admin --email=admin@jouwdomein.be --password='SterkWachtwoord' --name='Octopus Admin'
```

## Seeder

- Seeder: `LocalAdminUserSeeder`
- Manueel draaien:

```bash
npm run monolith:artisan -- db:seed --class=LocalAdminUserSeeder
```

## Rechten synchroniseren na backend-update

Wanneer rol/permissies zijn aangepast in code, run dit ook:

```bash
npm run monolith:artisan -- db:seed --class=RolesAndPermissionsSeeder --force
```

## Als admin backend leeg is (geen cursussen/lessen zichtbaar)

Frontend kan fallback-data tonen, maar de adminbackend leest uit `courses` en `lessons` in de database.
Als je daar nog niets ziet, draai dan deze sync:

```bash
npm run monolith:artisan -- db:seed --class=TaxonomySeeder
npm run monolith:artisan -- academy:import-content --reset-orders
npm run monolith:artisan -- optimize:clear
```

Controle (optioneel):

```bash
npm run monolith:artisan -- tinker --execute="print_r(DB::select('select count(*) as c from courses')); print_r(DB::select('select count(*) as c from lessons'));"
```

## Remote runner (zonder SSH)

Voor `academy-dev` kan je de veilige runner gebruiken:

- Endpoint: `https://academy-dev.octopus.be/__academy_runner.php`
- Actions: `help`, `sync`, `import`, `repair`, `admin`, `clear`, `optimize`

Via PowerShell wrapper:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/academy_dev_runner.ps1 -Action sync -Token "<TOKEN>"
```

Of direct via URL:

```text
https://academy-dev.octopus.be/__academy_runner.php?token=<TOKEN>&action=sync
```

## Online-only deploy checklist

Werk je enkel online (zonder lokale test), gebruik dan deze afvinkbare checklist:

- `planning/ONLINE_ONLY_DEPLOY_CHECKLIST_ACADEMY_DEV.md`

## Robuuste SFTP deploy (zonder bootstrap/cache fouten)

Gebruik voor file-pushes naar `academy-dev` deze scriptflow, zodat `bootstrap/cache/*.php` nooit per ongeluk van lokaal wordt overschreven:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/deploy_academy_dev_patch.ps1 `
  -Files @(
    'app/Http/Controllers/Admin/UserManagementController.php',
    'app/Http/Requests/Admin/UserCreateRequest.php',
    'resources/views/pages/admin/users/index.blade.php',
    'routes/web.php'
  ) `
  -Username '<SFTP_USER>' `
  -Password '<SFTP_PASS>'
```

Wat dit script bewaakt:

- blokkeert gevaarlijke uploads van `bootstrap/cache/*.php`
- uploadt enkel expliciet opgegeven bestanden
- sanity-checkt en corrigeert server-side `services.php` / `packages.php` voor ontbrekende dev-providers
