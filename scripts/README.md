# Scripts

## Sitemap audit opnieuw draaien

```bash
python scripts/audit_sitemaps.py
```

Outputs:

- `audit/urls_inventory.csv`
- `audit/summary.md`
- `audit/redirect_seed.csv`
- `audit/raw_sitemaps/*.xml`

Optioneel:

```bash
python scripts/audit_sitemaps.py --sitemap-index https://academy.octopus.be/nl/sitemap_index.xml
python scripts/audit_sitemaps.py --verify-ssl
```

## Core Web Vitals lab probe

```bash
npm run cwv:probe
```

Outputs:

- `audit/cwv_lab.json`
- `audit/cwv_baseline.md`

## Laravel wrappers

Run from repository root:

```bash
npm run monolith:composer -- install --no-interaction
npm run monolith:artisan -- list
```

Available wrappers:

- `scripts/composer.ps1` - resolves local composer/php and runs composer in `monolith/`
- `scripts/artisan.ps1` - resolves local php and runs artisan in `monolith/`
- `scripts/ensure_laravel_writable_dirs.ps1` - ensures Laravel write directories stay writable (`bootstrap/cache`, `storage/*`)
- `scripts/setup_monolith.ps1` - full local setup (`composer install`, `npm install`, sqlite file, migrations)
- `scripts/check_prereqs.ps1` - validates required tools + PHP extensions
