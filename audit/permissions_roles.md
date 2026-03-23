# Rollen & Permissiemodel (As-Is observatie)

- Datum: `2026-03-17`
- Type: technische observatie op publieke endpoints (geen admin-toegang gebruikt)

## Geobserveerd toegangsmodel

1. Publieke content API:
   - `GET /nl/wp-json/wp/v2/pages?per_page=1` geeft `200` met `X-WP-Total`.
2. LMS content API:
   - `GET /nl/wp-json/wp/v2/sfwd-courses?per_page=1` geeft `401` met code `learndash_rest_forbidden_context`.
   - `GET /nl/wp-json/wp/v2/sfwd-lessons?per_page=1` geeft `401` met code `learndash_rest_forbidden_context`.
   - `GET /nl/wp-json/wp/v2/sfwd-topic?per_page=1` geeft `401` met code `learndash_rest_forbidden_context`.

## Rollen-indicaties in frontend/LMS assets

- LearnDash styles bevatten verwijzingen naar:
  - `role-group_leader`
  - `role-administrator`
- Accountflows en endpoints zichtbaar:
  - `/nl/my-account/`
  - `/nl/my-account/edit-profile/`
  - `/nl/my-account/edit-password/`
  - `/nl/my-account/mijn-cursussen/`
  - `/nl/my-account/user-logout/`

## Voorlopige rolmatrix (te bevestigen met backend owner)

| Rol | Verwachte toegang |
| --- | --- |
| Anonymous | Publieke pagina's en overzichten |
| Ingelogde learner | Mijn account, mijn cursussen, les/cursus met rechten |
| Group leader / beheerder | Uitgebreider LMS-beheer en rapportering |
| Administrator | Volledige WP/LMS beheertoegang |

## Migratie-implicatie

- Er is duidelijke scheiding tussen publieke content en beschermde LMS data.
- Definitieve rolmapping moet bevestigd worden met huidige WordPress/LearnDash adminconfiguratie vóór datamigratie.
