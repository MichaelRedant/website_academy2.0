# Video Hosting Strategy V1

- Date: `2026-03-17`
- Status: `chosen` for MVP under Option C (custom monolith)

## Decision

Use an **external managed video platform** as primary delivery strategy for MVP.

## Why this is best now

1. Avoids building and operating our own streaming stack.
2. Gives adaptive streaming and player reliability from day 1.
3. Reduces launch risk for course playback quality.

## Functional requirements

1. HLS adaptive streaming support.
2. Signed/private playback where needed.
3. Embed/player API for progress tracking hooks.
4. Subtitle/caption support.
5. Stable playback URLs for migration mapping.

## Data model impact

In `MediaAsset` (and lesson relation) store at least:

1. `provider` (e.g. managed platform identifier)
2. `provider_asset_id`
3. `playback_id` or equivalent
4. `is_protected`
5. `duration_sec`

## Security and access

1. Lesson access check stays in monolith auth/authorization layer.
2. Signed playback tokens generated server-side for protected content.
3. Token TTL short and audience-scoped.

## Migration approach

1. Build a video inventory from current LMS content.
2. Upload/relink in batches.
3. Validate playback + entitlement + progress per batch.

## Fallback and future

1. Keep provider abstraction in code to avoid vendor lock-in.
2. Optional archive in object storage for portability.
