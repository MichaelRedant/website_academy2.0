# FR Import - Manuele Aanvulhandleiding

Deze handleiding gebruik je na `academy:import-content-fr` om ontbrekende FR inhoud snel aan te vullen in de admin.

## 1. Import draaien

Vanuit `monolith`:

```bash
php artisan academy:import-content-fr
```

Optioneel eerst enkel scannen:

```bash
php artisan academy:import-content-fr --report-only
```

## 2. Rapport openen

Na elke run worden 2 rapportbestanden aangemaakt in `planning/`:

- `T_FR5_LEGACY_FR_IMPORT_REPORT_<timestamp>.md`
- `T_FR5_LEGACY_FR_IMPORT_REPORT_<timestamp>.json`

Gebruik het markdownrapport als werklijst.

## 3. In admin aanvullen

Voor elk ontbrekend item:

1. Open `Admin > Cursussen` of `Admin > Lessen`.
2. Open het item.
3. Kies tab `Frans`.
4. Vul minimaal in:
   - `Titel`
   - `Slug`
5. Vul indien beschikbaar ook:
   - Inhoud / samenvatting
   - Video URL
   - SEO titel / SEO beschrijving
6. Opslaan.
7. Controleer via `Publiek FR` preview-link.

## 4. Praktische prioriteit

Werk best in deze volgorde:

1. Cursussen met ontbrekende FR titel/slug.
2. Lessen met ontbrekende FR titel/slug.
3. Lessen zonder FR video.
4. SEO-velden als laatste.
