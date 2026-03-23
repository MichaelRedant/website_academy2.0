# Performance Baseline (Fase 1)

- Datum: `2026-03-17`
- Meetwijze: `curl` op HTML response (cold-ish spot checks, geen volledige browserprofiler)

## 1) TTFB en totale HTML-responstijd

| URL | HTTP | HTML grootte (bytes) | TTFB (s) | Total (s) |
| --- | --- | ---: | ---: | ---: |
| `https://academy.octopus.be/nl/` | 200 | 240806 | 1.742 | 1.771 |
| `https://academy.octopus.be/nl/cursussen/` | 200 | 254032 | 1.588 | 1.625 |
| `https://academy.octopus.be/nl/how-tos/` | 200 | 424215 | 3.527 | 3.574 |
| `https://academy.octopus.be/nl/my-account/` | 200 | 195493 | 1.599 | 1.667 |

## 2) Frontend assetdruk op kernpagina's

| Pagina | Script tags | Stylesheets |
| --- | ---: | ---: |
| `home` | 53 | 49 |
| `cursussen` | 52 | 48 |
| `how-tos` | 55 | 54 |
| `my-account` | 78 | 58 |

## 3) Eerste bottleneck-indicaties

- Hoge assetdruk op alle kernpagina's (veel JS/CSS afhankelijkheden).
- `how-tos` is merkbaar zwaarder in HTML payload en responstijd.
- Accountpagina heeft uitzonderlijk veel scripts/styles door gecombineerde auth + LMS + builder stack.

## 4) Vervolgmeting (nog te doen)

- Core Web Vitals via browser-based tooling (LCP, CLS, INP).
- Waterfall- en blocking-chain analyse (JS execution + render delay).
- Herhaalde metingen per moment van de dag voor stabiliteit.
