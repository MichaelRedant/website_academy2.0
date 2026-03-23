# Media Inventaris

- Datum: `2026-03-17`
- Bronnen: kern-HTML dumps + sitemapaudit

## Samenvatting

- Afbeeldingen zijn het dominante mediatype op kernpagina's.
- In de gesamplede pagina's zijn geen inline `iframe` of `video` tags gevonden.
- In lesinhoud komen links voor naar PDF-bestanden.
- Video-content is wél aanwezig in de sitemap (`video-sitemap.xml` met 85 entries).

## Snelle telling (sample)

| Bestand | `img` | `iframe` | `video` | PDF-links |
| --- | ---: | ---: | ---: | ---: |
| `tmp_nl_home.html` | 40 | 0 | 0 | 0 |
| `tmp_nl_cursussen.html` | 37 | 0 | 0 | 0 |
| `tmp_nl_howtos.html` | 68 | 0 | 0 | 0 |
| `tmp_nl_account.html` | 3 | 0 | 0 | 0 |
| `tmp_nl_registratie.html` | 3 | 0 | 0 | 0 |
| `tmp_lesson_peppol.html` | 4 | 0 | 0 | 2 |
| `tmp_all_courses.html` | 23 | 0 | 0 | 0 |

## Media-gerelateerde aandachtspunten voor migratie

- Video's en certificaatgerelateerde lescontent niet enkel via zichtbare HTML inventariseren, maar ook via LMS-datalaag.
- Downloadlinks (zoals PDF's) expliciet mappen in contentmigratie.
- CDN/assetstrategie vroeg bepalen om payload en laadtijden te verbeteren.
