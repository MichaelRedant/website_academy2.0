# Octopus Academy Workspace

Lokale sandbox om de migratie van WordPress naar custom code stap voor stap te testen.

## Belangrijke uitzondering binnen deze repo

Deze map volgt niet dezelfde workflow als de meeste WordPress- en Elementor-assets elders in deze repository.

Academy 2.0 is een volledig geprogrammeerd project en moet behandeld worden als gewone broncode, niet als copy-paste website-assets.

Dat betekent:

- fouten en warnings niet standaard negeren
- structurele problemen wel oplossen wanneer nodig
- tests, build en code-quality checks serieus nemen
- de algemene copy-paste uitzondering uit andere website-mappen hier niet toepassen


## Snel starten

```bash
npm install
npm run dev
```

Open daarna de URL die Vite toont (standaard `http://localhost:5173`).

## Belangrijke scripts

- `npm run dev` - lokale dev server
- `npm run test` - unit tests
- `npm run test:watch` - tests in watch mode
- `npm run build` - productiebuild
- `npm run preview` - preview van build
- `npm run audit:refresh` - sitemap audit opnieuw genereren
- `npm run cwv:probe` - browser-based CWV lab baseline genereren
- `npm run qa:cross-browser` - Playwright smoke op Chromium/Firefox/WebKit
- `npm run qa:mobile` - Playwright smoke op mobiele profielen
- `npm run qa:performance` - lokale performance smoke met drempelchecks
- `npm run qa:security` - security smoke via gerichte auth/protectie tests
- `npm run qa:accessibility` - a11y smoke (skip-link, main-target, basis checks)
- `npm run qa:nonfunctional` - volledige niet-functionele QA-keten
- `npm run qa:uat:tech-dryrun` - technische pre-UAT op de 6 kernjourneys

Voor eerste Playwright-run:

```bash
npx playwright install chromium firefox webkit
```

## Monolith (Laravel) lokale workflow

Vanaf de repository root:

```bash
npm run monolith:setup
```

Dit doet automatisch:

- write-permissies herstellen op `bootstrap/cache` en `storage/*` (OneDrive-proof),
- `composer install` + `npm install`,
- `database/database.sqlite` aanmaken indien nodig,
- migrations uitvoeren,
- minimale dataset seeden:
  - rollen/permissies (`roles`, `permissions`, pivots),
  - taxonomy (`taxonomy_terms`),
  - lokale admin testgebruiker (enkel bij `APP_ENV=local`).

Daarna kan je testen met:

- `npm run monolith:serve` - Laravel app server op `http://127.0.0.1:8000`
- `npm run monolith:dev` - Vite dev server voor assets
- `npm run monolith:test` - Laravel tests
- `npm run monolith:build` - productie asset build
- `npm run monolith:artisan -- academy:sync-search-index` - search index opbouwen/verversen
- `npm run monolith:artisan -- academy:benchmark-search` - search benchmark rapport genereren
- `npm run monolith:artisan -- academy:import-taxonomy --write` - SPK-03 taxonomy import valideren en normalized seed input genereren
- `npm run monolith:artisan -- academy:import-content` - legacy cursussen + lessen importeren naar lokale DB (idempotent)
- `npm run monolith:artisan -- academy:import-content-fr` - best-effort FR vertalingen importeren vanaf legacy `/fr` URLs + missing-data rapport maken
- `npm run monolith:artisan -- academy:import-users` - legacy users uit JSON importeren zonder e-mails te versturen (idempotent)
- `npm run monolith:artisan -- academy:ensure-admin` - admin account aanmaken/updaten (ook bruikbaar op staging/prod)
- `npm run monolith:artisan -- db:seed --class=RolesAndPermissionsSeeder` - rollen/permissies opnieuw seeden
- `npm run monolith:artisan -- db:seed --class=TaxonomySeeder` - taxonomy seed apart opnieuw draaien

Tip: als `Admin > Cursussen` of `Admin > Lessen` leeg is, vul de contenttabellen met:

```bash
npm run monolith:artisan -- academy:import-content
```

Optionele flags:

- `--reset-orders` herzet cursus- en lessenvolgorde volgens brondata.
- `--prune` verwijdert lokale cursussen/lessen die niet in de brondata staan.
- FR import flags:
  - `--report-only` schrijft geen vertalingen weg, enkel scan + rapport
  - `--limit=<n>` beperkt scan/import voor snelle dry-runs
  - `--timeout=<sec>` timeout per legacy FR request

FR import rapportbestanden worden geschreven naar `planning/`:

- `T_FR5_LEGACY_FR_IMPORT_REPORT_<timestamp>.md`
- `T_FR5_LEGACY_FR_IMPORT_REPORT_<timestamp>.json`

Extra:

- `npm run monolith:composer -- <composer-args>` (bv. `npm run monolith:composer -- update`)
- `npm run monolith:artisan -- <artisan-args>` (bv. `npm run monolith:artisan -- migrate`)
- De wrappers herstellen automatisch write-permissies op `bootstrap/cache` en `storage/*` (handig in OneDrive folders).

Search endpoint (US-020 basis):

- `GET /api/search?q=peppol&page=1&per_page=10`
- Ondersteunde filters: `type`, `category`, `level`, `language`
- UI koppeling (US-021): zoek/filter blok op `/cursussen` gebruikt dit endpoint live
- Zoekresultaat-URL's wijzen nu naar interne detailpagina's (geen links meer naar `academy.octopus.be`)

Publieke catalogusroutes:

- `/` (home)
- `/over` (overzicht van Octopus Academy)
- `/cursussen` (overzicht)
- `/cursussen/{courseSlug}` (cursusdetail met publieke lessenlijst + extra account-CTA voor volledig traject)
- `/cursussen/{courseSlug}/lessen/{lessonSlug}` (interne lesdetail)
- `/lessen` (lessenoverzicht, linkt naar interne lesdetail)
- `/faq` (veelgestelde vragen)
- `/contact` (contact- en supportdoorverwijzing)
- `/privacy` (privacybeleid)
- `/cookies` (cookiebeleid)
- `/voorwaarden` (gebruiksvoorwaarden)
- `/disclaimer` (juridische disclaimer)
- `/demo/certificaat` (visuele voorbeeldpagina van certificaat met fictieve data + klassieke SVG-certificaatornamenten en sterzegel)
- `/certificaat-verificatie` (publieke controle op certificaatnummer of verificatiecode, met status `geldig`, `ingetrokken` of `niet gevonden`)
- `/how-tos` blijft als legacy redirect naar `/lessen`.
- Lesdetail toont video('s) op basis van de oude Academy `video-sitemap.xml` (`audit/raw_sitemaps/video-sitemap.xml`, fallback `tmp_video_sitemap.xml`).
- Lesdetail toont nu ook een duidelijke lespositie (`les x van y`) binnen de cursus.
- Cursus- en leskaarten tonen nu een kleine coverafbeelding (legacy-stijl), met fallback wanneer geen beeld beschikbaar is.
- Legacy lessenset is nu aangevuld naar `94` items (op basis van `sfwd-lessons-sitemap.xml` + cursuspagina-links), inclusief fallbacktoewijzing voor ontbrekende koppelingen.
- Lescategorieen worden nu mee gesynchroniseerd vanuit legacy `lesson-category` archiefpagina's (met parent-categorieen en fallback).
- In account staat nu basis voortgang actief:
  - les markeren als voltooid/ongedaan,
  - progressie per cursus (`x/y`, `%`),
  - certificaatuitgifte automatisch zodra de laatste gepubliceerde les voltooid is.
- Safe State (admin):
  - via admin dashboard kan je veilige modus aan/uit zetten,
  - bij actieve modus worden admin mutaties tijdelijk geblokkeerd zonder downtime voor learners,
  - publieke en admin layouts tonen een statusbanner.
- Sitewide navigatie is nu consistent op publiek en account:
  - desktop topnavigatie (`Home`, `Over`, `Cursussen`, `Lessen`, `Mijn account`/`Aanmelden`),
  - mobiele snelle navigatiechips op dezelfde plekken.
  - voor admin-gebruikers stuurt `Mijn account` rechtstreeks naar het admin dashboard (`/admin`).
- Sitewide footer staat nu op publieke, auth- en accountpagina's met snelle links naar `Home`, `Cursussen`, `Lessen`, `FAQ`, `Contact` en `Mijn account`/`Aanmelden`.
- Login/registratie/resetpagina's gebruiken dezelfde sitewide navigatie.
- Sitewide mini-animaties staan actief (subtiele hover, card-lift en zachte reveal), met `prefers-reduced-motion` ondersteuning.
- Toetsenbordnavigatie verbeterd met skip-link (`Naar hoofdinhoud`) en duidelijke `:focus-visible` states op interactieve elementen.
- SEO metadata is nu centraal en consistent:
  - per pagina: `title`, `description`, `canonical`,
  - social: `og:*` + `twitter:*`,
  - robots defaults: publiek `index, follow`; auth/account/admin `noindex, nofollow`.
- Structured data is nu voorzien waar relevant:
  - globale `Organization` + `WebSite` schema op publieke, indexeerbare pagina's,
  - pagina-specifiek schema op home (`WebPage`), cursussen/lessen-overzichten (`ItemList`), details (`Course`/`LearningResource`), FAQ (`FAQPage`) en certificaatverificatie (`WebPage` + `SearchAction`).
- Lespagina's blijven publiek, maar volledige cursusnavigatie op lesniveau is enkel zichtbaar na inloggen.
- Zowel cursussen als lessen zijn gratis (geen betaalmuur).
- Met een account kan een gebruiker een cursus volledig volgen en na afronding een certificaat behalen.

Routebescherming (Sprint 2 basis):

- `/account/cursussen` vereist `view-learning-area` gate (learner/instructor/content_manager/admin).
- `/account` is het hoofd-dashboard van "Mijn account".
- `/account/profiel` laat gebruikers hun naam/e-mail aanpassen en optioneel wachtwoord wijzigen (met controle van huidig wachtwoord).
- `/account/cursussen` toont nu het accountoverzicht met cursussen en certificaatstatus.
- `/account/cursussen/{course:slug}` vereist `view-learning-area` + `view-course-detail`:
  - learner/instructor: enkel `published`
  - content_manager/admin: alle statussen
- `/account/cursussen/{course:slug}/certificaat` (POST) vereist `view-learning-area` + `view-course-detail`:
  - maakt idempotent een certificaat aan voor de ingelogde gebruiker binnen die cursus
  - vereist dat alle gepubliceerde lessen van die cursus voltooid zijn
  - normale gebruikersflow triggert dit automatisch bij de laatste lesvoltooiing
  - certificaatnummer gebruikt formaat `OCA-YYYY-XXXXXX`
- `/account/cursussen/{course:slug}/lessen/{lesson:slug}` vereist `view-learning-area` + `view-lesson-detail`:
  - learner/instructor: enkel `published` les in `published` cursus
  - content_manager/admin: alle statussen
  - Indien `video_url` gezet is, toont de lesdetailpagina een embed + link naar de originele video.
  - Als embed niet ondersteund is, blijft een duidelijke fallback met externe videolink zichtbaar.
- `/account/cursussen/{course:slug}/lessen/{lesson:slug}/voltooi` (POST):
  - markeert een gepubliceerde les als voltooid voor learner/instructor
- `/account/cursussen/{course:slug}/lessen/{lesson:slug}/heropen` (POST):
  - zet een eerder voltooide les terug naar niet-voltooid
- `/account/certificaten/{certificate:verification_token}`:
  - visuele, printklare certificaatpagina voor eigenaar (of content_manager/admin)
  - bevat knop `Download PDF` (echte PDF via Dompdf) en aparte `Print` actie.
- `/account/certificaten/{certificate:verification_token}/download`:
  - beveiligde PDF-download voor eigenaar (of content_manager/admin).
- `/admin/*` vereist `auth` guard + `access-admin` gate + `role:admin` middleware (admin-only backend).
- Bij onvolledige lokale database-setup:
  - dashboard toont fallback-waarschuwing i.p.v. crash,
  - admin modules met ontbrekende tabellen redirecten naar dashboard met duidelijke melding.
- `/login` is een werkende loginpagina met e-mail/wachtwoord.
- `/register` is een werkende registratiepagina; nieuwe accounts krijgen standaard rol `learner`.
- `/forgot-password` en `/reset-password/{token}` vormen de wachtwoord resetflow.
- `POST /login`, `POST /register`, `POST /forgot-password`, `POST /reset-password` hebben anti-spam bescherming:
  - honeypot veld + minimale invultijdcontrole,
  - route rate limiting per IP/e-mail combinatie.
- `/logout` (POST) logt uit en brengt je terug naar de home.
- Admin routes actief:
  - `/admin`
  - `/admin/statistieken` (uitgebreid statistiekenoverzicht met gebruikers-, content-, voortgangs- en certificaatcijfers)
  - `/admin/cursussen` (list)
    - bevat ook inline drag-and-drop sectie voor cursusvolgorde
  - `/admin/cursussen/nieuw` (create)
  - `/admin/cursussen/{course}/bewerken` (edit)
  - `/admin/cursussen/{course}/archiveren` (archive)
  - `/admin/cursussen/{course}/activeren` (activate -> draft)
  - `/admin/lessen` (list)
    - bevat ook inline drag-and-drop sectie voor lessenvolgorde per gekozen cursus
  - `/admin/lessen/nieuw` (create)
  - `/admin/lessen/{lesson}/bewerken` (edit)
  - `/admin/lessen/{lesson}/archiveren` (archive)
  - `/admin/lessen/{lesson}/activeren` (activate -> draft)
- `/admin/certificaten` (list + zoek/filter)
- `/admin/certificaten/{certificate}/heruitgeven` (reissue)
- `/admin/certificaten/{certificate}/intrekken` (revoke)
- `/admin/safe-state/activeren` (activeer veilige modus)
- `/admin/safe-state/deactiveren` (deactiveer veilige modus)
- `/admin/taxonomie` (list + type filters)
  - `/admin/taxonomie/nieuw` (create)
  - `/admin/taxonomie/{taxonomyTerm}/bewerken` (edit)
  - `/admin/taxonomie/{taxonomyTerm}/deactiveren` (deactivate)
  - `/admin/taxonomie/{taxonomyTerm}/activeren` (activate)
- `/admin/gebruikers-rollen` (gebruikersoverzicht met zoek/filter en rolbeheer)
  - `/admin/gebruikers-rollen` (`POST`) nieuwe gebruiker aanmaken met rol
  - `/admin/gebruikers-rollen/rollen/{role}` (`PUT`) permissies per rol beheren
  - `/admin/gebruikers-rollen/{user}` (rol wijzigen via `PUT`, enkel voor gebruikers met `user.manage_roles`)
- In `admin/cursussen/{course}/bewerken` kan je nu ook:
  - lessen bundelen door bestaande lessen uit andere cursussen te verplaatsen,
  - de volgorde van gekoppelde lessen in bulk aanpassen,
  - coverafbeelding per cursus instellen.
- In `admin/lessen/{lesson}/bewerken` kan je nu coverafbeelding per les instellen.
- Admin certificaatbeheer schrijft nu auditlogs weg in `certificate_audit_logs`.

Seed/import spike (SPK-03):

- Bron template: `monolith/import/templates/legacy_taxonomy_template.csv`
- Runner valideert CSV, schrijft rapporten in `audit/` en `architecture/`
- Met `--write` wordt ook `monolith/data/import/legacy_taxonomy.normalized.php` aangemaakt
- `DatabaseSeeder` seedt taxonomy idempotent naar `taxonomy_terms` via `TaxonomySeeder`

Omgevingstemplates:

- `monolith/.env.example` (local/dev)
- `monolith/.env.staging.example`
- `monolith/.env.production.example`
- `monolith/config/academy.php` (branding + cursus/les taxonomie)
- anti-spam configuratie via `ACADEMY_ANTISPAM_*` env vars (zie `.env.example`)

Lokale admin-login (dev/test):

- URL: `http://127.0.0.1:8000/login`
- E-mail: `admin@octopusacademy.test`
- Wachtwoord: `OctopusAdmin!2026`
- Wijzigen kan via `monolith/.env` met:
  - `ACADEMY_ADMIN_NAME`
  - `ACADEMY_ADMIN_EMAIL`
  - `ACADEMY_ADMIN_PASSWORD`
- Voor staging/prod maak of reset je admin expliciet met:
  - `php artisan academy:ensure-admin`

## Prerequisite check (Sprint 1 uitvoering)

```powershell
powershell -ExecutionPolicy Bypass -File scripts/check_prereqs.ps1
```

Voor Laravel Sprint 1 zijn minimaal `php`, `composer` en de vereiste PHP-extensies nodig.
