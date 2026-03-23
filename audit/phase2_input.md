# Input Voor Architectuurfase (Fase 2)

- Datum: `2026-03-17`
- Status: samengesteld uit afgeronde Fase 1 auditartefacten

## 1) Scope en volume (bevestigd)

- URL inventory: `221` URLs (`218` uniek)
- Contenttypes:
  - Pages: `20`
  - Courses: `10`
  - Lessons: `94`
  - Course categories: `8`
  - Course tags: `4`
  - Video sitemap entries: `85`

## 2) Kritieke functionele domeinen

- Auth: login, registratie, wachtwoord, profiel
- Leerervaring: cursusdetail, lesdetail, mijn cursussen
- Certificaten: verificatieflow aanwezig
- Zoek/filter en taxonomieoverzichten

## 3) Technische constraints

- Huidige stack: WordPress + LearnDash + Elementor + User Registration ecosysteem
- LMS REST data is afgeschermd zonder juiste context/auth (`401`)
- Duidelijke plugin-lock-in en LMS-specifieke rollen/logica

## 4) SEO en URL aandachtspunten

- Test/technische pagina's indexeerbaar in sitemap
- URL-conflict: `/nl/` en `/nl/home/`
- Root `robots.txt` ontbreekt
- Veel uppercase paden in cursusroutes
- Hreflang momenteel niet actief op geanalyseerde pagina's

## 5) Performance baseline (lab + netwerk)

- Hoge JS/CSS assetdruk op kernpagina's
- TTFB gemeten in curl en browserrun is aan de hoge kant
- Lab CWV baseline beschikbaar in `audit/cwv_baseline.md`

## 6) Beslissingen die in Fase 2 prioriteit krijgen

1. Frontend/backend/CMS/LMS architectuurkeuze.
2. Auth- en rollenstrategie (incl. migratie van rechten).
3. Definitieve URL policy + redirectstrategie.
4. Performance targets en meetframework (CWV/TTFB budgets).
5. Meertaligheid en hreflang beleid.
