# SPK-01 Search Benchmark

- Date: `2026-03-18`
- Driver: `sqlite`
- Dataset rows: `5000`
- Iterations per query: `40`

## Query Terms

`facturatie`, `peppol`, `klantenportaal`, `boekhoudprogramma`, `coda`, `dms`, `webinar`, `fakturatie`

## Results

### LIKE

| Query | Avg (ms) | P95 (ms) | Hits |
| --- | ---: | ---: | ---: |
| `facturatie` | 0.618 | 1.282 | 500 |
| `peppol` | 0.514 | 0.547 | 750 |
| `klantenportaal` | 0.502 | 0.629 | 1250 |
| `boekhoudprogramma` | 0.682 | 1.516 | 1250 |
| `coda` | 0.537 | 0.622 | 750 |
| `dms` | 0.532 | 0.576 | 1000 |
| `webinar` | 0.618 | 1.016 | 250 |
| `fakturatie` | 0.543 | 0.57 | 0 |
| **Overall** | **0.568** | **0.757** | - |

### FTS

| Query | Avg (ms) | P95 (ms) | Hits |
| --- | ---: | ---: | ---: |
| `facturatie` | 0.038 | 0.043 | 500 |
| `peppol` | 0.046 | 0.046 | 750 |
| `klantenportaal` | 0.061 | 0.063 | 1250 |
| `boekhoudprogramma` | 0.063 | 0.07 | 1250 |
| `coda` | 0.045 | 0.047 | 750 |
| `dms` | 0.052 | 0.053 | 1000 |
| `webinar` | 0.029 | 0.03 | 250 |
| `fakturatie` | 0.021 | 0.022 | 0 |
| **Overall** | **0.044** | **0.064** | - |

## Notes

- Benchmark uitgevoerd op SQLite met FTS5 MATCH en LIKE.
- Trigram tolerance is niet native in SQLite en is dus niet gemeten.
- Resultaten zijn geschikt voor relatieve vergelijking, niet als absolute productie-SLA.

## Recommendation

Kies FTS als primaire strategie voor de MVP search endpoint. Voor productie op PostgreSQL: combineer FTS met pg_trgm voor typo tolerantie.

## Decision

Gebruik database-first search als baseline voor MVP.
Bouw het endpoint op full text strategie en hou het API contract stabiel.
