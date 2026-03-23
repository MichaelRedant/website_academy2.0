# T035 Sitewide Mini-animaties Notitie

- Datum: `2026-03-18`
- Scope: subtiele, performante mini-animaties op publiek, account, auth en admin

## Wat is opgeleverd

- Centrale motion-styles in `monolith/resources/css/app.css`:
  - zachte page fade-in,
  - subtiele hover-animaties voor knoppen en navigatielinks,
  - card-lift effect voor kaarten/panels,
  - zachte reveal-animaties bij paginalaad.
- Nieuwe initializer `monolith/resources/js/academy-mini-motion.js`:
  - activeert mini-motion sitewide,
  - voegt automatisch motion-klassen toe op kaarten en secties,
  - respecteert `prefers-reduced-motion`.
- `monolith/resources/js/app.js` laadt deze initializer.
- Dynamische zoekresultaten gebruiken nu ook card-motion via `academy-card`.
- Certificaatpagina kreeg eigen mini-motion (fade/hover/rise) + reduced-motion fallback.

## Toegankelijkheid

- Reduced-motion gebruikers krijgen animaties en transities automatisch uitgeschakeld.

## Verwacht resultaat

- Snellere visuele feedback bij hover en klik.
- Meer vloeiende navigatiebeleving zonder agressieve effecten.
