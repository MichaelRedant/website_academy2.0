# Search and Filter Strategy V1

- Date: `2026-03-17`
- Status: `chosen` for MVP under Option C (custom monolith)
- Scope: public catalog + authenticated learning catalog

## Decision

For MVP, use a **database-first search approach** in PostgreSQL.

## Why this is best now

1. Lowest operational complexity for first release.
2. Fastest path to stable, testable search in one codebase.
3. No extra managed search infra needed in phase 1.

## MVP behavior

1. Search on:
   - course title
   - lesson title
   - summary/description
   - tags/categories labels
2. Filters:
   - category
   - tag
   - level
   - language
   - type (`course`, `how-to`)
3. Sort:
   - relevance (default when query is present)
   - latest updated
   - alphabetical

## Technical implementation (Laravel + PostgreSQL)

1. Use PostgreSQL full-text (`tsvector`) for relevance.
2. Add trigram index for typo tolerance on title fields.
3. Add composite indexes for filter facets.
4. Cache hot queries/results in Redis with short TTL.

## Data and API contract

1. One unified search endpoint for frontend:
   - returns items + facets + total count + pagination
2. Keep endpoint shape stable for later search-engine swap.

## Upgrade path (post-MVP)

Move to dedicated search engine (Meilisearch/Elasticsearch/OpenSearch) if:

1. Data volume or query latency exceeds targets.
2. Advanced ranking or synonym control is needed.
3. Multi-language relevance tuning becomes critical.
