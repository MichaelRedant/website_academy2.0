# Prioritized Issues (P0/P1/P2)

- Datum: `2026-03-17`
- Bron: sitemap-audit, functionele inventaris, technische inventaris, performance baseline

## P0 (geen directe P0 gevonden)

- Geen directe blocker gevonden die onmiddellijke site-onbeschikbaarheid aantoont op publieke endpoints.

## P1 (hoog)

1. Indexeerbare test/technische pagina's staan in sitemap.
   - Voorbeelden: `/nl/elementor-6522/`, `/nl/test-event_hub/`
   - Impact: SEO-vervuiling en kwaliteitsverlies in index.
2. URL-consolidatieprobleem (`/nl/` versus `/nl/home/`).
   - Impact: duplicate content risico en diluted ranking signals.
3. Root `robots.txt` ontbreekt (`404` op `/robots.txt`).
   - Impact: crawler-richtlijnen niet centraal beschikbaar.
4. Zware frontend stack op kernpagina's (veel scripts/styles).
   - Impact: performancerisico en hogere onderhoudscomplexiteit.
5. LMS/auth sterke plugin-lock-in.
   - Impact: verhoogde migratierisico's op login, registratie, cursusrechten.

## P2 (middel)

1. Grote hoeveelheid uppercase paden in cursus-URL's (`/nl/Cursussen/...`).
   - Impact: inconsistent URL-beleid en mogelijke redirect-complexiteit.
2. Publieke API geeft pages vrij, maar courses/lessons zijn afgeschermd.
   - Impact: migratie vereist admin-export of alternatieve datatoegang.
3. Functionele flows zijn gedocumenteerd op basis van publieke observatie.
   - Impact: nog verdiepende test nodig met echte gebruikersrollen.

## Aanbevolen eerstvolgende acties

1. Beslissen op definitief URL-beleid (lowercase, trailing slash, canonical policy).
2. Voorbereiden redirect-matrix v1 op basis van `audit/redirect_seed.csv`.
3. Formeel beslissen op auth/LMS migratiestrategie voor risicoverlaging.
4. Starten met Core Web Vitals meting voor objectieve performance targets.
