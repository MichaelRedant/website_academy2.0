# Technische Inventaris (Fase 1)

- Datum: `2026-03-17`
- Doel: as-is stack en afhankelijkheden documenteren voor migratiebeslissingen

## 1) Platformstack (gedetecteerd)

- CMS/LMS:
  - WordPress
  - LearnDash (`sfwd-lms`)
- Thema's:
  - `astra`
  - `octopus-university` (custom theme)
- Gedetecteerde plugins (subset op basis van publieke pagina-assets):
  - `elementor`
  - `elementor-pro`
  - `essential-addons-for-elementor-lite`
  - `sfwd-lms`
  - `ld-visual-customizer`
  - `design-upgrade-learndash`
  - `learndash-course-grid`
  - `learndash-favorite-content`
  - `learndash-certificate-verify-and-share`
  - `user-registration-pro`
  - `user-registration-advanced-fields`
  - `user-registration-conditional-logic`
  - `user-registration-customize-my-account`
  - `uncanny-learndash-toolkit`
  - `facturenplugin`
  - `event_hub`
  - `smart-slider-3`

## 2) API en toegangsobservaties

- WordPress REST root bereikbaar: `/nl/wp-json/`
- Publiek:
  - `/wp/v2/pages` geeft totaal (`X-WP-Total: 21`)
- Afgeschermd (401 zonder auth):
  - `/wp/v2/sfwd-courses`
  - `/wp/v2/sfwd-lessons`
  - `/wp/v2/sfwd-topic`

## 3) Externe afhankelijkheden (gedetecteerd in assets/links)

- `login.octopus.be`
- `portal.octopus.be`
- `www.octopus.be`
- `www.googletagmanager.com`
- `octopus-accountancy-software.containers.piwik.pro`
- `www.facebook.com`
- `www.linkedin.com`

## 4) URL- en SEO-gerelateerde technische aandachtspunten

- Sitemap index aanwezig op `/nl/sitemap_index.xml`
- `robots.txt` op root (`/robots.txt`) geeft momenteel `404`
- In sitemap staan indexeerbare test/technische pagina's:
  - `/nl/elementor-6522/`
  - `/nl/test-event_hub/`
- Mogelijke URL-consolidatie:
  - `/nl/` en `/nl/home/` bestaan naast elkaar
- Grote hoeveelheid uppercase paden in cursusroutes (`/nl/Cursussen/...`)

## 5) Migratierisico's (technisch)

- Sterke plugin-lock-in op Elementor + LearnDash + User Registration ecosysteem
- Auth en accountflows verweven met pluginlogica/nonces
- LMS-content beschermd buiten publieke API, dus migratie vereist admin-export of DB-level extract
- Veel frontend assets op belangrijke pagina's, wat performance en onderhoud beïnvloedt
