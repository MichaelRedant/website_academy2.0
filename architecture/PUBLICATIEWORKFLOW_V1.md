# Publicatieworkflow V1

- Datum: `2026-03-17`
- Status: bevroren voor MVP (`V1 frozen`)

## Doel

Een eenvoudige, robuuste workflow voor contentpublicatie met duidelijke rollen.

## Statusmodel

1. `draft`
2. `in_review`
3. `published`
4. `archived`

## Rollen en rechten (MVP)

1. `content_editor`
   - aanmaken en wijzigen van draft content
   - submit naar review
2. `content_reviewer`
   - reviewen en terugsturen naar draft
   - publiceren
3. `admin`
   - alle rechten inclusief archiveren en force publish

## Toegangsregels

1. Alleen `published` content is publiek zichtbaar.
2. `draft` en `in_review` enkel zichtbaar in admin.
3. `archived` niet publiek, wel historisch traceerbaar in admin.

## Audit trail

Per statusovergang loggen:

1. `entity_type` (`course`, `lesson`, `page`)
2. `entity_id`
3. `from_status`
4. `to_status`
5. `changed_by_user_id`
6. `changed_at`
7. `note` (optioneel)

## Migratiegedrag

1. Geimporteerde legacy content start als `draft` of `published` op basis van validatiebatch.
2. First-pass bulk migratie zonder review moet expliciet admin-goedkeuring krijgen.
