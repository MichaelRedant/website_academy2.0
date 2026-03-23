# T040 Structured Data Basis Notitie

- Datum: `2026-03-18`
- Scope: gestructureerde data op publieke pagina's als SEO-basis voor Octopus Academy

## Wat is opgeleverd

- Centrale structured-data integratie in publieke layout:
  - `monolith/resources/views/layouts/public.blade.php`
  - globale include + page-level `@yield('structured_data')`
- Nieuwe partial:
  - `monolith/resources/views/partials/public-structured-data.blade.php`
  - output van `Organization` + `WebSite` schema op publieke, indexeerbare routes
  - geen output op account/admin/auth/noindex pagina's
- Pagina-specifieke schema's toegevoegd:
  - home: `WebPage`
  - cursussen-overzicht: `ItemList`
  - cursusdetail: `Course`
  - lessen-overzicht: `ItemList`
  - lesdetail: `LearningResource`
  - FAQ: `FAQPage`
  - contact: `ContactPage`

## Testdekking

- Nieuwe feature test:
  - `monolith/tests/Feature/StructuredDataSchemaTest.php`
  - valideert aanwezigheid op publieke pagina's
  - valideert afwezigheid op `noindex` pagina's (o.a. login en demo-certificaat)

## Verificatie

- `npm run monolith:test -- --filter="StructuredDataSchemaTest"`: geslaagd
- `npm run monolith:test`: geslaagd
- `npm run monolith:build`: geslaagd
