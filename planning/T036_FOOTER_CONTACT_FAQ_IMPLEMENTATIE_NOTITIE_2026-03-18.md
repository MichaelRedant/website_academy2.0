# T036 Footer + Contact/FAQ Implementatie Notitie

- Datum: `2026-03-18`
- Scope: sitewide footer en nieuwe supportpagina's voor vlottere navigatie

## Wat is opgeleverd

- Nieuwe gedeelde footerpartial:
  - `monolith/resources/views/partials/public-footer.blade.php`
  - links naar `Home`, `Cursussen`, `Lessen`, `FAQ`, `Contact` en dynamisch `Mijn account`/`Aanmelden`.
- Footer gekoppeld in publieke layout:
  - `monolith/resources/views/layouts/public.blade.php`
  - hierdoor automatisch actief op publieke, auth- en accountpagina's.
- Nieuwe routes:
  - `/faq` (`faq`)
  - `/contact` (`contact`)
- Nieuwe pagina's:
  - `monolith/resources/views/pages/faq.blade.php`
  - `monolith/resources/views/pages/contact.blade.php`

## Testdekking

- Nieuwe feature test `PublicFooterAndSupportPagesTest` controleert:
  - footerlinks voor gasten op home,
  - bereikbaarheid van FAQ en Contact,
  - accountlink in footer voor ingelogde learner.
