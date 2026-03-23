# QA Performance Smoke

- Generated at: `2026-03-19T12:23:06.224Z`
- Base URL: `http://127.0.0.1:8000`
- Warm-up pass: enabled (all paths loaded once before measured pass).

## Thresholds

- FCP <= 2000ms
- LCP <= 2500ms
- CLS <= 0.1
- TTFB <= 800ms
- DCL <= 2500ms
- Load <= 5000ms

| Path | FCP | LCP | CLS | TTFB | DCL | Load | Status |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| `/` | 300 | 300 | 0 | 254.3 | 274.5 | 276.2 | PASS |
| `/cursussen` | 316 | 316 | 0 | 285.5 | 311.2 | 316.5 | PASS |
| `/lessen` | 300 | 300 | 0 | 249.6 | 278.6 | 291.2 | PASS |
| `/certificaat-verificatie` | 280 | 280 | 0 | 234.1 | 255.8 | 257.7 | PASS |
