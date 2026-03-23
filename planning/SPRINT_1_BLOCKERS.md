# Sprint 1 Blockers

- Datum: `2026-03-17`
- Status: opgelost

## B-001 Lokale Laravel runtime ontbreekt (Resolved)

### Observatie

Initieel ontbraken de volgende tools op de machine:

1. `php`
2. `composer`
3. Vereiste PHP-extensies voor Laravel test/run (`fileinfo`, `mbstring`, `zip`, `pdo_sqlite`, `sqlite3`)

### Impact

- Taak `T-001` was tijdelijk geblokkeerd.

### Oplossing uitgevoerd

1. `PHP 8.3` lokaal geinstalleerd (winget user-scope).
2. `Composer` lokaal geinstalleerd (`ComposerLite`).
3. `php.ini` geconfigureerd met vereiste extensies.
4. OneDrive reparsepoint-issue op `monolith/bootstrap/cache` opgelost door een normale directory te maken.
5. `composer install`, `npm install`, `artisan key:generate` en `artisan test` succesvol uitgevoerd.
6. Root wrappers toegevoegd:
   - `npm run monolith:composer -- <args>`
   - `npm run monolith:artisan -- <args>`
   - `npm run monolith:setup`
   - `npm run monolith:serve`
   - `npm run monolith:dev`
   - `npm run monolith:test`

### Validatiecommando

```powershell
powershell -ExecutionPolicy Bypass -File scripts/check_prereqs.ps1
```

## Restblokkers

- Geen actieve technische block op Sprint 1 start.
