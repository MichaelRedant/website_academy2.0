# Hreflang Assessment

- Datum: `2026-03-17`
- Scope: sample op kernpagina's (`/nl/`, `/nl/cursussen/`, `/nl/how-tos/`, `/nl/my-account/`, `/nl/registratie/`)

## Bevindingen

- Geen `hreflang` link tags gevonden in de geanalyseerde pagina's.
- Wel standaard `rel="alternate"` links voor RSS/oEmbed (dit is niet hetzelfde als hreflang).
- Taalgedrag op URL-niveau:
  - `/nl/` geeft `200`
  - `/fr/` geeft `200`
  - `/en/` geeft `404`

## Conclusie

- Hreflang is momenteel niet actief op de geanalyseerde pagina's.
- Er is minstens meertalige structuur (`/nl`, `/fr`) aanwezig, dus hreflang is functioneel relevant voor SEO-consistentie.

## Aanbeveling voor migratie

- Voor elke publieke pagina een set `hreflang` tags voorzien (minstens `nl-BE`, `fr-BE`, en `x-default` waar relevant).
- Alleen talen publiceren waarvoor content effectief beschikbaar en onderhouden is.
