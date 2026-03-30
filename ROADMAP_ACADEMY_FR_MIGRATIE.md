# Roadmap FR-uitbreiding Octopus Academy (af te vinken)

Dit document is de afvinkbare roadmap om Franstalige ondersteuning toe te voegen aan Octopus Academy, met eigen FR slugs, FR routes, taalswitcher en automatische taalkeuze.

## Gebruik van dit document

- [ ] Elke taak krijgt een eigenaar en streefdatum.
- [ ] Taken worden pas afgevinkt na functionele test.
- [ ] Waar mogelijk werken we eerst met veilige fallback naar NL.
- [ ] Dit document wordt bijgewerkt tijdens implementatie.

## Legende

- `[ ]` Nog te doen
- `[x]` Afgerond
- `BLOCKER` = moet opgelost zijn voor volgende fase

---

## Fase FR-0 - Scope & regels

### Doel
Duidelijke spelregels voor taalgedrag en fallback vastleggen.

### Taken

- [x] Scope bevestigen: `nl` + `fr` voor publieke site, cursusdetail, lesdetail en account navigatie.
- [x] URL-strategie bevestigen: locale-prefix (`/nl/...` en `/fr/...`).
- [ ] Fallbackregel bevestigen: ontbrekende FR vertaling valt terug op NL of FR-overzicht.
- [x] Browsertaalregel bevestigen: automatische FR-switch enkel op eerste bezoek (of zolang geen manuele keuze).
- [x] Cookie/sessionregel bevestigen: manuele taalkeuze overschrijft auto-detectie.

### Exitcriteria FR-0

- [ ] Taalregels formeel bevestigd.
- [ ] Geen open vragen over URL- en fallbackgedrag.

---

## Fase FR-1 - Datamodel voor vertalingen

### Doel
FR en NL los beheerbaar maken met eigen contentvelden en eigen slugs.

### Taken

- [x] Vertaalmodel toevoegen voor cursussen (titel, slug, samenvatting, beschrijving, SEO, video/meta waar relevant).
- [x] Vertaalmodel toevoegen voor lessen (titel, slug, inhoud, video_url, SEO, meta).
- [x] Unieke constraints op `locale + slug` per entity toevoegen.
- [x] Relaties en queryhelpers toevoegen (`translationFor(locale)` met fallback).
- [x] Seed/testdata uitbreiden met FR voorbeelden.

### Exitcriteria FR-1

- [x] Cursus en les kunnen technisch een FR vertaling dragen.
- [x] NL data blijft volledig backward compatible.

---

## Fase FR-2 - Locale routing & middleware

### Doel
Publieke routes locale-aware maken met correcte URLs.

### Taken

- [x] Locale-prefixed routes toevoegen voor publieke paginas (`/nl/...`, `/fr/...`).
- [x] Middleware toevoegen voor locale-resolutie (route > cookie > browsertaal > default NL).
- [x] Auto-redirect toevoegen voor root route op basis van browsertaal (`fr*` => FR).
- [ ] 301/302 gedrag vastleggen voor oude paden zonder locale.
- [ ] Route-model binding uitbreiden op vertaalde slug.

### Exitcriteria FR-2

- [x] FR paginas zijn bereikbaar via eigen FR URLs.
- [x] Browser met FR taal landt automatisch op FR bij eerste bezoek.

---

## Fase FR-3 - Sitewide taalswitcher

### Doel
Eenvoudig en consistent wisselen tussen NL en FR op alle paginas.

### Taken

- [x] Taalswitcher in sitewide header toevoegen (desktop + mobiel).
- [x] Switcher bewaart taalkeuze in cookie/session.
- [x] Switcher linkt naar equivalente pagina in andere taal waar beschikbaar.
- [x] Als equivalente vertaling ontbreekt: veilige fallback naar correcte overzichtspagina.
- [x] Accessibility toevoegen (toetsenbord, aria-labels, focus states).

### Exitcriteria FR-3

- [x] Gebruiker kan overal taal wisselen zonder kapotte links.
- [x] Manuele taalkeuze blijft behouden over sessies heen.

---

## Fase FR-4 - Admin UX voor vertalingen

### Doel
Admin moet FR/NL content en slugs makkelijk kunnen beheren.

### Taken

- [x] Cursusformulier uitbreiden met taal-tabbladen (NL/FR).
- [x] Lesformulier uitbreiden met taal-tabbladen (NL/FR).
- [x] FR slug apart bewerkbaar maken.
- [x] FR video_url apart bewerkbaar maken.
- [x] Validatie toevoegen op verplichte velden per taal en slug-uniqueness.
- [x] Preview-/detaillinks in admin tonen voor beide talen.

### Exitcriteria FR-4

- [x] Admin kan FR inhoud en FR slug afzonderlijk beheren.
- [x] Opslaan en ophalen van vertalingen werkt stabiel.

---

## Fase FR-5 - Legacy FR import (`academy.../fr`)

### Doel
Bestaande FR content maximaal overnemen met veilige fallback.

### Taken

- [x] FR inventaris van legacy URLs opbouwen.
- [x] Importscript uitbreiden voor FR titels, slugs en teksten.
- [x] FR video-links importeren waar beschikbaar (best effort).
- [x] Mappingrapport maken van ontbrekende FR velden.
- [x] Handmatige aanvulling voorzien in admin voor ontbrekende videos/content.

### Exitcriteria FR-5

- [ ] FR basiscontent is gemigreerd.
- [ ] Ontbrekende items staan in een duidelijke backloglijst.

---

## Fase FR-6 - SEO, hreflang en canonical

### Doel
Meertaligheid SEO-technisch correct maken.

### Taken

- [x] `hreflang` tags toevoegen (`nl-BE`, `fr-BE`).
- [x] Canonical regels per locale implementeren.
- [ ] Sitemaps uitbreiden met locale URLs.
- [ ] Meta title/description locale-aware maken.
- [ ] Redirectregels voor oude FR paden documenteren.

### Exitcriteria FR-6

- [ ] SEO-audit op staging groen voor NL/FR.
- [ ] Geen dubbele indexatie door locale-conflicten.

---

## Fase FR-7 - QA & release

### Doel
FR release veilig opleveren zonder regressies op NL.

### Taken

- [ ] Featuretests voor locale routing en slug-resolutie toevoegen.
- [ ] Tests voor auto language detectie (Accept-Language) toevoegen.
- [ ] Tests voor taalswitcher en cookie override toevoegen.
- [ ] Tests voor admin vertaalflow toevoegen.
- [ ] UAT checklist uitvoeren op NL + FR hoofdflows.

### Exitcriteria FR-7

- [ ] Geen P0/P1 issues op FR/NL meertaligheid.
- [ ] FR kan veilig live gezet worden.

---

## Beslissingen (FR)

- [x] Beslissing FR-01: locale-prefix routing bevestigd.
- [x] Beslissing FR-02: auto-switch gedrag bevestigd.
- [ ] Beslissing FR-03: fallbackstrategie bevestigd.
- [ ] Beslissing FR-04: legacy FR import "best effort video" bevestigd.

---

## Notities

- Startdatum roadmap: `2026-03-23`.
- Doel: FR toevoegen zonder bestaande NL functionaliteit te breken.
- Status update `2026-03-23`: FR-5 tooling staat klaar (`academy:import-content-fr`) met best-effort FR import + missing-data rapport in `planning/`. Volgende stap is volledige run uitvoeren en resterende FR gaten manueel aanvullen.
- Status update `2026-03-23`: FR-6 deels afgerond met sitewide `hreflang` (`nl-BE`, `fr-BE`, `x-default`) + locale-canonical in SEO partial. Relevante SEO en locale tests zijn groen.
