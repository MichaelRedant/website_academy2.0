# Acceptatiecriteria Epics V1

- Datum: `2026-03-17`
- Scope: Epics voor Sprint 1

## Epic E1 - Platform Foundation

1. Laravel applicatie start lokaal met documented setup.
2. Configuratie voor dev/staging/prod bestaat als template.
3. Rollenmodel aanwezig en afdwingbaar via policies.

## Epic E2 - Public Catalog

1. `home`, `cursussen`, `how-tos` routes geven `200`.
2. Pagina's renderen dynamische content vanuit database.
3. Basale SEO velden (title/meta) zijn aanwezig op pagina niveau.

## Epic E3 - Search/Filter Foundation

1. Search endpoint ondersteunt query op titel/omschrijving.
2. Filters werken op categorie/tag/level.
3. Resultaat bevat paginering + totaal + actieve filters.

## Epic E4 - Data and Migration Foundation

1. Seeders leveren consistente testdataset.
2. Mapping-template bevat minimaal pages/courses/lessons/categories/tags.
3. Voorbeeldimport kan zonder fout doorlopen in lokale omgeving.
