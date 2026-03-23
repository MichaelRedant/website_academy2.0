# T038 SEO Metadata Per Pagina Notitie

- Datum: `2026-03-18`
- Scope: SEO metadata correct en consistent op publieke, auth-, account- en adminpagina's

## Wat is opgeleverd

- Centrale SEO partial toegevoegd:
  - `monolith/resources/views/partials/seo-meta.blade.php`
  - beheert `title`, `description`, `robots`, `canonical`, `og:*`, `twitter:*`.
- Integratie in layouts:
  - `monolith/resources/views/layouts/public.blade.php`
  - `monolith/resources/views/layouts/admin.blade.php`
- Automatische robots-aanpak:
  - publieke pagina's: `index, follow`
  - auth/account/admin: `noindex, nofollow` (default)
  - certificaatpagina: expliciet `noindex, nofollow, noarchive`
- Publieke contentpagina's kregen expliciete metadata:
  - home, cursussenoverzicht, cursusdetail,
  - lessenoverzicht, lesdetail,
  - faq, contact.
- Canonical links toegevoegd op basis van interne routes.
- Detailpagina's gebruiken dynamische titels/descriptions op basis van cursus- en lesdata.

## Testdekking

- Nieuwe feature test `SeoMetadataTest` valideert:
  - indexeerbare metadata op publieke pagina's,
  - dynamische metadata op cursus/les detail,
  - noindex defaults op login, account en admin.
