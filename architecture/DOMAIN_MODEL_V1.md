# Domeinmodel V1 (Voorstel)

- Datum: `2026-03-17`
- Status: bevroren voor MVP (`V1 frozen`)

## Kernentiteiten

## `User`

- `id`
- `email`
- `first_name`
- `last_name`
- `status` (active/inactive)
- `created_at`

## `Role`

- `id`
- `code` (`anonymous`, `learner`, `group_leader`, `admin`)
- `description`

## `UserRole`

- `user_id`
- `role_id`

## `Course`

- `id`
- `translation_group_id`
- `slug`
- `title`
- `summary`
- `description`
- `language_code` (`nl-BE`, `fr-BE`, ...)
- `level` (`starter`, `gevorderd`, ...)
- `is_published`
- `seo_title`
- `seo_description`
- `created_at`
- `updated_at`

## `Lesson`

- `id`
- `translation_group_id`
- `course_id`
- `slug`
- `title`
- `content_richtext`
- `order_index`
- `is_preview`
- `is_published`
- `estimated_duration_min`
- `created_at`
- `updated_at`

## `Category`

- `id`
- `slug`
- `name`

## `LessonCategory`

- `id`
- `slug`
- `name`
- `domain` (`klantenportaal`, `boekhoudprogramma`, `nieuw`)

## `Tag`

- `id`
- `slug`
- `name`

## Relatietabellen

## `CourseCategory`

- `course_id`
- `category_id`

## `CourseTag`

- `course_id`
- `tag_id`

## `LessonLessonCategory`

- `lesson_id`
- `lesson_category_id`

## Leerprogressie

## `Enrollment`

- `id`
- `user_id`
- `course_id`
- `status` (`active`, `completed`, `cancelled`)
- `started_at`
- `completed_at`

## `LessonProgress`

- `id`
- `user_id`
- `lesson_id`
- `status` (`not_started`, `in_progress`, `completed`)
- `last_position_sec` (optioneel voor video)
- `completed_at`

## Certificaten

## `Certificate`

- `id`
- `user_id`
- `course_id`
- `verification_code` (uniek)
- `issued_at`
- `expires_at` (optioneel)
- `pdf_url` (optioneel)

## `CertificateVerificationLog` (optioneel)

- `id`
- `certificate_id`
- `checked_at`
- `client_ip_hash`

## Content & media

## `MediaAsset`

- `id`
- `type` (`image`, `video`, `pdf`, `file`)
- `url`
- `mime_type`
- `size_bytes`
- `title`
- `alt_text`

## Relaties (hoog niveau)

1. `Course` 1-N `Lesson`
2. `User` N-N `Course` via `Enrollment`
3. `User` N-N `Lesson` via `LessonProgress`
4. `Course` N-N `Category`
5. `Course` N-N `Tag`
6. `Lesson` N-N `LessonCategory`
7. `Certificate` koppelt `User` + `Course`

## Open beslissingen

1. Multi-language model: gekozen voor aparte records per taal met `translation_group_id`.
2. Certificaatgenerator: intern in monolith met PDF output.
3. Progressiegranulariteit: status-based met optionele `last_position_sec` voor video.
