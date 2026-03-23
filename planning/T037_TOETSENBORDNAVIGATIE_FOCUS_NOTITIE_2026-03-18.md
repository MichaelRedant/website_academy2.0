# T037 Toetsenbordnavigatie + Focus Notitie

- Datum: `2026-03-18`
- Scope: keyboard accessibility verbeteren op publieke, auth-, account- en adminschermen

## Wat is opgeleverd

- Globale `:focus-visible` styles toegevoegd in `monolith/resources/css/app.css`:
  - duidelijke focusrand en focusring voor links, knoppen en form controls.
- Gedeelde skip-link component via `.skip-link` toegevoegd in CSS.
- Skip-link actief in:
  - `monolith/resources/views/layouts/public.blade.php`
  - `monolith/resources/views/layouts/admin.blade.php`
- `main-content` focusdoel aanwezig in beide layouts.
- Certificaatpagina kreeg ook skip-link + focus-visible voor knoppen.

## Testdekking

- Nieuwe feature test `AccessibilityKeyboardNavigationTest` valideert:
  - skip-link + `#main-content` target in publieke layout,
  - skip-link + `#main-content` target in admin layout.
