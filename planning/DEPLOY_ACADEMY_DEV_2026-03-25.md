# Deploy log - academy-dev.octopus.be (2026-03-25)

## Uitgevoerd door Codex

- Production build gemaakt (`public/build`).
- Production dependencies opgebouwd in een deploy copy (zonder `require-dev`).
- App geupload via SFTP naar:
  - `/academy-dev.octopus.be/www/academy_app`
- Publieke entry files geupload naar:
  - `/academy-dev.octopus.be/www`
- Webroot `index.php` aangepast zodat die bootstrapt vanuit `academy_app/`.
- Symlink gezet:
  - `/academy-dev.octopus.be/www/storage` -> `/academy-dev.octopus.be/www/academy_app/storage/app/public`
- Writable rechten gezet op:
  - `/academy-dev.octopus.be/www/academy_app/storage`
  - `/academy-dev.octopus.be/www/academy_app/bootstrap/cache`
- Extra hardening:
  - `.htaccess` toegevoegd in `/academy-dev.octopus.be/www/academy_app` met `Require all denied`.

## Status (afgerond)

- Setup runner is uitgevoerd (migrate + seed + import + optimize).
- Tijdelijke setup endpoint is opnieuw dichtgezet:
  - route verwijderd uit `routes/web.php`
  - `APP_DEPLOY_SETUP_TOKEN` verwijderd uit `.env`
  - server route/config cache gewist
- Reusable SSH-less runner toegevoegd in webroot:
  - `__academy_runner.php` met token + action-whitelist (`sync`, `import`, `admin`, `clear`, `optimize`).
- Tijdelijke one-time setup file opnieuw verwijderd:
  - `__academy_setup_once.php` (niet meer aanwezig op server).

## Historiek (was tijdelijk nodig)

Er staat een tijdelijke setup runner klaar (veilig met token):

- URL:
  - (oude php-runner verwijderd, vervangen door Laravel route-runner)
  - `https://academy-dev.octopus.be/_deploy/setup?token=<DEPLOY_SETUP_TOKEN>`

Deze voert uit:

- `optimize:clear`
- `migrate --force --no-interaction`
- `db:seed --class=RolesAndPermissionsSeeder --force --no-interaction`
- `db:seed --class=TaxonomySeeder --force --no-interaction`
- `academy:import-content --no-interaction`
- `optimize`

Na succesvolle run werd een done-flag gezet in `storage/app/deploy_setup_done.flag`.

## Waarom dit nog manueel is

- SSH shell is niet beschikbaar op deze host (enkel SFTP).
- Vanuit deze omgeving is de site HTTP-protected (`401`), dus de setup URL kon hier niet automatisch gestart worden.

## Controle na setup

1. Open: `https://academy-dev.octopus.be`
2. Test NL lessenpagina: `/nl/lessen`
3. Test cursussen: `/nl/cursussen`
4. Loginflow testen op `/login`
5. Admin testen op `/admin`
