# SPK-01 Search Benchmark

- Date: `2026-03-17`
- Driver: `sqlite`
- Dataset rows: `5000`
- Iterations per query: `40`

## Query Terms

`facturatie`, `peppol`, `klantenportaal`, `boekhoudprogramma`, `coda`, `dms`, `webinar`, `fakturatie`

## Results

### LIKE

| Query | Avg (ms) | P95 (ms) | Hits |
| --- | ---: | ---: | ---: |
| `facturatie` | 0.602 | 0.853 | 500 |
| `peppol` | 0.575 | 0.831 | 750 |
| `klantenportaal` | 0.624 | 0.974 | 1250 |
| `boekhoudprogramma` | 0.847 | 1.483 | 1250 |
| `coda` | 0.878 | 1.375 | 750 |
| `dms` | 0.84 | 1.808 | 1000 |
| `webinar` | 0.77 | 1.408 | 250 |
| `fakturatie` | 1.038 | 1.658 | 0 |
| **Overall** | **0.772** | **1.438** | - |

### FTS

| Query | Avg (ms) | P95 (ms) | Hits |
| --- | ---: | ---: | ---: |
| `facturatie` | 0.042 | 0.045 | 500 |
| `peppol` | 0.047 | 0.051 | 750 |
| `klantenportaal` | 0.064 | 0.071 | 1250 |
| `boekhoudprogramma` | 0.065 | 0.077 | 1250 |
| `coda` | 0.046 | 0.055 | 750 |
| `dms` | 0.052 | 0.057 | 1000 |
| `webinar` | 0.029 | 0.029 | 250 |
| `fakturatie` | 0.021 | 0.022 | 0 |
| **Overall** | **0.046** | **0.068** | - |

## Notes

- Benchmark uitgevoerd op SQLite met FTS5 MATCH en LIKE.
- Trigram tolerance is niet native in SQLite en is dus niet gemeten.
- Resultaten zijn geschikt voor relatieve vergelijking, niet als absolute productie-SLA.

## Recommendation

Kies FTS als primaire strategie voor de MVP search endpoint. Voor productie op PostgreSQL: combineer FTS met pg_trgm voor typo tolerantie.

## Decision

Use database-first search as baseline for MVP.
Implement endpoint on top of full text strategy and keep API stable.
