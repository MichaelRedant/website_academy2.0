# URL Policy V1 (Voorstel)

- Datum: `2026-03-17`
- Status: bevroren voor MVP (`V1 frozen`)

## Doelen

- Eenduidige, SEO-vriendelijke en migratiebestendige URL-structuur.
- Vermijden van duplicaten zoals `/nl/` en `/nl/home/`.
- Voorbereid op meertaligheid.

## Basisregels

1. Alleen lowercase URL's.
2. Geen technische of testslug in indexeerbare routes.
3. Trailing slash consistent (aanbevolen: **met** trailing slash).
4. Canonical altijd naar de primaire route.
5. Elke oude URL krijgt expliciete redirectregel.

## Voorgestelde structuur

- Home:
  - `/nl/`
  - `/fr/` (wanneer live)
- Overzicht:
  - `/nl/cursussen/`
  - `/nl/how-tos/`
- Cursusdetail:
  - `/nl/cursussen/<course-slug>/`
- Lesdetail:
  - `/nl/cursussen/<course-slug>/lessons/<lesson-slug>/`
- Account:
  - `/nl/account/`
  - `/nl/account/cursussen/`
- Certificaatverificatie:
  - `/nl/certificaat-verificatie/` (of EN variant naar keuze)

## Redirectprincipes

1. `/nl/home/` -> `/nl/` (301)
2. Uppercase paden (`/nl/Cursussen/...`) -> lowercase equivalent (301)
3. Test/technische pagina's:
   - ofwel verwijderen (410)
   - ofwel redirecten naar relevante pagina

## SEO bijkomend

- Hreflang set op meertalige equivalenten (`nl-BE`, `fr-BE`, `x-default`).
- XML sitemap enkel met indexeerbare productie-URL's.
- Root `robots.txt` met expliciete sitemap verwijzing.
