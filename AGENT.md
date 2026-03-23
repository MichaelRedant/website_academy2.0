# Octopus Academy - Agent Guide

## Project context

- Project name in UI/content: `Octopus Academy` (niet `Academy 2.0`).
- Primary palette:
  - `#000000` (zwart)
  - `#ffffff` (wit)
  - `#306b91` (Octopus primary)
  - `#e9f6fc` (Octopus soft)
- Current stack: Laravel monolith + Blade + Tailwind + Vite.

## Source of truth

- Product roadmap: `ROADMAP_ACADEMY_MIGRATIE.md`
- Sprint board: `planning/SPRINT_1_TAKENBORD_V1.md`
- Search architecture: `architecture/SEARCH_FILTER_STRATEGY_V1.md`
- Benchmark decisions: `architecture/SEARCH_BENCHMARK_SPK01_2026-03-18.md`

## Local workflow

From repository root:

1. `npm run monolith:setup`
2. `npm run monolith:serve`
3. `npm run monolith:dev` (optional for live assets)

Validation:

1. `npm run monolith:test`
2. `npm run monolith:build`

Search utilities:

1. `npm run monolith:artisan -- academy:sync-search-index`
2. `npm run monolith:artisan -- academy:benchmark-search`

## Current implementation notes

- Public pages implemented:
  - `/`
  - `/cursussen`
  - `/how-tos`
- Search API implemented:
  - `GET /api/search`
  - supports `q`, `page`, `per_page`, `type`, `category`, `level`, `language`
- Search strategy:
  - SQLite local: FTS5 first
  - PostgreSQL target: FTS + `pg_trgm` (when available)

## Delivery expectations

- Keep changes pragmatic and testable.
- Prefer extending existing architecture over one-off code.
- Update roadmap/sprint status when a task is effectively done.
- Do not introduce branding drift or naming drift.
