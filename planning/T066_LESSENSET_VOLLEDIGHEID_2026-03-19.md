# T066 Lessenset volledigheid en URL-validatie

- Datum: `2026-03-19`
- Doel: controleren en aanvullen van ontbrekende lessen t.o.v. de legacy bron.

## 1) Controle

- `monolith/data/howtos.php` voor aanpassing: `32` lessen.
- Legacy bron `audit/raw_sitemaps/sfwd-lessons-sitemap.xml`: `94` les-URL's.
- Verschil bevestigd: `62` lessen ontbraken in lokale dataset.

## 2) Aanpak

- Nieuwe synchronisatiescript toegevoegd:
  - `tools/sync_howtos_full.php`
- Scriptlogica:
  - verzamelt lesslinks uit alle legacy cursuspagina's,
  - bewaart bestaande rijke records (titel/excerpt/categorieen) waar beschikbaar,
  - vult ontbrekende records aan met default categorieen per cursus,
  - valideert tegen `sfwd-lessons-sitemap.xml`,
  - voegt resterende orphan slugs toe via gecontroleerde fallbacktoewijzing.

## 3) Resultaat

- Nieuwe `howtos.php` dataset: `94` lessen.
- Interne lessenroutes blijven op cursus + les slug.
- Card-thumbnails werken voor alle lessen via:
  - video thumbnail indien beschikbaar,
  - anders cursuscover fallback.

## 4) Opmerking

- Voor `9` slugs zonder expliciete cursuslink op cursuspagina's werd fallbacktoewijzing gebruikt:
  - `aanpassen-factuuropmaak-2`
  - `aanpassen-factuuropmaak`
  - `dms-via-de-unieke-e-mailadressen`
  - `balansen`
  - `boeken-van-een-aankoopfactuur-met-beroepsgedeelte`
  - `uploaden-doc-via-div`
  - `les-4`
  - `werken-met-het-klantenportaal-voor-accountants`
  - `les-3`

## 5) Validatie

- Tests geslaagd: `npm run monolith:test`
- Build geslaagd: `npm run monolith:build`
