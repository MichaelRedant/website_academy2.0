# Online Deploy Checklist (academy-dev)

- Laatst bijgewerkt: `2026-03-26`
- Doel: alleen online werken, zonder lokale testomgeving

## 1) Voorbereiding (eenmalig)

- [ ] Bevestig dat je deze 3 zaken hebt:
  - SFTP toegang tot `academy-dev.octopus.be:22`
  - Runner token voor `__academy_runner.php`
  - Browsertoegang met HTTP Basic Auth op `https://academy-dev.octopus.be`
- [ ] Controleer dat `Posh-SSH` module beschikbaar is in PowerShell.

## 2) Standaard deploy flow (elke update)

- [ ] Bouw production assets:

```powershell
npm run monolith:build
```

- [ ] Upload codewijzigingen naar `academy_app` met veilige patch deploy:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/deploy_academy_dev_patch.ps1 `
  -Files @(
    'routes/web.php',
    'app/Http/Controllers/Admin/UserManagementController.php',
    'resources/views/pages/admin/users/index.blade.php'
  ) `
  -Username '<SFTP_USER>' `
  -Password '<SFTP_PASS>'
```

- [ ] Sync ook webroot assets (`/www/build`, `sw.js`, `manifest`, `pwa`) zodat frontend direct klopt:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/sync_academy_dev_webroot_assets.ps1 `
  -Username '<SFTP_USER>' `
  -Password '<SFTP_PASS>'
```

- [ ] Voer online sync uit (migrate/seed/import/cache):
  - Open in browser (met Basic Auth):  
    `https://academy-dev.octopus.be/__academy_runner.php?token=<TOKEN>&action=sync`
  - Of via PowerShell wrapper:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/academy_dev_runner.ps1 `
  -Action sync `
  -Token '<TOKEN>'
```

## 3) Snelle smoke check (na deploy)

- [ ] `https://academy-dev.octopus.be/nl` opent zonder `500`
- [ ] `https://academy-dev.octopus.be/fr` opent zonder `500`
- [ ] `https://academy-dev.octopus.be/nl/cursussen` laadt correct
- [ ] `https://academy-dev.octopus.be/nl/lessen` laadt correct
- [ ] `https://academy-dev.octopus.be/login` werkt
- [ ] `https://academy-dev.octopus.be/admin` werkt als admin
- [ ] Hard refresh (`Ctrl+F5`) toont nieuwe styles/scripts

## 4) Als er toch een 500 is

- [ ] Run eerst:
  - `...__academy_runner.php?token=<TOKEN>&action=clear`
  - daarna `...__academy_runner.php?token=<TOKEN>&action=optimize`
- [ ] Check recente serverlog:
  - `/academy-dev.octopus.be/www/academy_app/storage/logs/laravel-YYYY-MM-DD.log`
- [ ] Herhaal daarna `action=sync`.
