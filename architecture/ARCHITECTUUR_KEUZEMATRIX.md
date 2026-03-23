# Architectuur Keuzematrix (Fase 2)

- Datum: `2026-03-17`
- Basis: `audit/phase2_input.md`
- Doel: technologiekeuze voor MVP en schaalbare doorontwikkeling
- Beslissing: `Optie C` (bevestigd door product owner)

## Criteria

1. SEO en performance potentieel
2. Snelheid tot MVP
3. Complexiteit van LMS/rollen/auth
4. Beheerbaarheid content voor niet-developers
5. Migratierisico vanuit huidige WP/LearnDash setup
6. TCO (onderhoud, hosting, team skills)

## Optie A - Next.js + Headless CMS + Custom LMS API

- Frontend: Next.js (SSR/ISR)
- CMS: Strapi of Directus
- API/Backend: Node (NestJS of Next API/BFF)
- Database: PostgreSQL
- Auth: externe IdP of custom JWT/session layer
- LMS: custom domein (`Course/Lesson/Enrollment/Progress/Certificate`)

### Plus

- Sterk voor SEO, routing en performance-optimalisatie.
- Volledige controle over UX en leerflow.
- Duidelijk pad weg van plugin-lock-in.
- Goed schaalbaar voor toekomstige features.

### Min

- Hogere initiele implementatiekost dan WordPress-headless.
- Meer ownership op backend/auth/LMS logica.

## Optie B - WordPress Headless + LearnDash behouden

- Frontend: Next.js/Nuxt
- Backend/CMS/LMS: bestaande WordPress + LearnDash

### Plus

- Snelste migratiepad op korte termijn.
- Minder directe impact op bestaande LMS dataflow.

### Min

- Behoud van huidige lock-in en technische schuld.
- Beperkte winst op domeinvereenvoudiging.
- Complexere langetermijn evolutie.

## Optie C - Full custom monolith (Laravel of vergelijkbaar)

- Frontend + backend in een framework
- Eigen CMS-admin en LMS module

### Plus

- Zeer coherent platform en sterke backendcontrole.
- Goede enterprise governance mogelijk.

### Min

- Langere time-to-market voor MVP.
- Meer initiele bouwlast (admin + authoring + LMS).

## Gekozen richting

- **Gekozen: Optie C** als doelarchitectuur.
- **Implementatiestrategie: gefaseerd**:
  1. Publieke site + contentmodel eerst
  2. Auth/Account
  3. LMS-kern en progressie
  4. Certificaten en uitbreidingen

## Beslissing bevestigd

- Keuze tussen `A/B/C` is afgerond: `C`.
- Volgende stap: concrete monolith stack en delivery-aanpak vastleggen in
  `architecture/ARCHITECTUUR_BESLUIT_C.md`.
