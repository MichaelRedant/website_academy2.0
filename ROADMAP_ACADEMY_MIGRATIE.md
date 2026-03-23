# Roadmap Migratie Octopus Academy (WordPress -> Custom Code)

Dit document is de centrale, afvinkbare roadmap voor de migratie van `academy.octopus.be` naar een custom coded platform.

## Gebruik van dit document

- [ ] Elke taak krijgt een eigenaar en streefdatum.
- [ ] Taken worden pas afgevinkt na verificatie.
- [ ] Wij starten geen development tot de beslisfases zijn afgerond.
- [ ] Wij houden dit document wekelijks up-to-date.

## Legende

- `[ ]` Nog te doen
- `[x]` Afgerond
- `BLOCKER` = moet opgelost zijn voor volgende fase

---

## Fase 0 - Kick-off & Governance (Week 1)

### Doel
Projectkaders vastleggen zodat we zonder herwerk kunnen starten.

### Taken

- [ ] Projectdoelen bevestigen (business, learning, support, lead generation).
- [x] Businessregel bevestigd: zowel lessen als cursussen zijn gratis (bevestigd op `2026-03-18`).
- [x] Waardepropositie bevestigd: met account volg je een volledige cursus en kan je een certificaat behalen (bevestigd op `2026-03-18`).
- [ ] Scope bevestigen: wat zit in MVP en wat niet.
- [ ] Stakeholders en beslissers per domein vastleggen.
- [ ] RACI opmaken (Product, Marketing, IT, Legal, Support).
- [ ] Definition of Done op projectniveau bevestigen.
- [ ] Beslissen: gefaseerde migratie (aanbevolen) of big bang.
- [ ] Beslissen: cut-over strategie (soft launch + parallel run).
- [ ] Communicatieplan opmaken (intern + extern).
- [ ] Risicoregister opstarten.
- [ ] `BLOCKER`: expliciet akkoord "nog niet programmeren" opheffen wanneer klaar om te bouwen.

### Exitcriteria Fase 0

- [ ] MVP scope goedgekeurd.
- [ ] Governance en besluitvorming helder.
- [ ] Migratiestrategie formeel goedgekeurd.

---

## Fase 1 - Audit & Inventarisatie (Week 1-2)

### Doel
Volledige as-is kaart van inhoud, functionaliteiten, SEO en afhankelijkheden.

### Artefacten

- [x] `audit/urls_inventory.csv` aangemaakt.
- [x] `audit/summary.md` aangemaakt.
- [x] `audit/redirect_seed.csv` aangemaakt.
- [x] `audit/functional_inventory.md` aangemaakt.
- [x] `audit/technical_inventory.md` aangemaakt.
- [x] `audit/performance_baseline.md` aangemaakt.
- [x] `audit/issues_prioritized.md` aangemaakt.
- [x] `audit/legal_validation.md` aangemaakt.
- [x] `audit/media_inventory.md` aangemaakt.
- [x] `audit/permissions_roles.md` aangemaakt.
- [x] `audit/hreflang_assessment.md` aangemaakt.
- [x] `audit/cwv_baseline.md` aangemaakt.
- [x] `audit/phase2_input.md` aangemaakt.

### Inhoudsinventaris

- [x] Alle huidige URL's exporteren en centraliseren.
- [x] Pagina's inventariseren (ongeveer 20).
- [x] Cursussen inventariseren (ongeveer 10).
- [x] Lessen inventariseren (ongeveer 94).
- [x] Categorieen inventariseren (ongeveer 8).
- [x] Tags inventariseren (ongeveer 4).
- [x] Juridische pagina's valideren (`privacy`, `cookie`, `voorwaarden`, `disclaimer`).
- [x] Mediatypes in kaart brengen (beeld, video, downloads, embeds).

### Functionele inventaris

- [x] Login flow documenteren.
- [x] Registratie flow documenteren.
- [x] Mijn account flow documenteren.
- [x] Mijn cursussen flow documenteren.
- [x] Cursusdetail en lesnavigatie documenteren.
- [x] Certificaat-verificatie flow documenteren.
- [x] Zoek/filter functionaliteit documenteren.
- [x] Formulieren en validatieregels documenteren.
- [x] Anti-spam/recaptcha gedrag documenteren.

### Technische inventaris

- [x] Alle actieve WordPress plugins documenteren.
- [x] Thema- en custom code componenten documenteren.
- [x] Externe integraties documenteren (`login.octopus.be`, `portal.octopus.be`, analytics, social).
- [x] Huidige permissiemodel en rollen documenteren.
- [x] In kaart brengen welke data publiek is en welke beschermd.

### SEO & Contentkwaliteit inventaris

- [x] Canonicals per key pagina controleren.
- [x] Indexeerbare test/technische pagina's oplijsten.
- [x] Dubbele of conflicterende URL's oplijsten (bv. `/nl/` en `/nl/home/`).
- [x] Sitemapkwaliteit controleren.
- [x] Robots-configuratie controleren (inclusief root `robots.txt`).
- [x] Hreflang-behoefte bevestigen.

### Performance baseline

- [x] Baseline TTFB meten op home, cursussen, lessenoverzicht, account.
- [x] Baseline payload en request count meten.
- [x] Core Web Vitals baseline meten.
- [x] Top bottlenecks identificeren.

### Exitcriteria Fase 1

- [x] Complete as-is audit gedeeld.
- [x] Kritieke issues geprioriteerd (P0/P1/P2).
- [x] Input voor architectuurfase volledig.

---

## Fase 2 - Architectuur & Beslissingen (Week 2-3)

### Doel
To-be architectuur en technologiekeuzes vastleggen voor MVP en schaalbaarheid.

### Voorbereidende artefacten

- [x] `architecture/ARCHITECTUUR_KEUZEMATRIX.md` opgesteld.
- [x] `architecture/ARCHITECTUUR_BESLUIT_C.md` opgesteld.
- [x] `architecture/DOMAIN_MODEL_V1.md` opgesteld.
- [x] `architecture/URL_POLICY_V1.md` opgesteld.
- [x] `architecture/SEARCH_FILTER_STRATEGY_V1.md` opgesteld.
- [x] `architecture/VIDEO_HOSTING_STRATEGY_V1.md` opgesteld.
- [x] `architecture/PUBLICATIEWORKFLOW_V1.md` opgesteld.
- [x] `architecture/ARCHITECTUUR_DOCUMENT_V1.md` opgesteld.
- [x] `architecture/PERFORMANCE_TARGETS_V1.md` opgesteld.
- [x] `architecture/SECURITY_BASELINE_V1.md` opgesteld.
- [x] `architecture/LOGGING_MONITORING_BASELINE_V1.md` opgesteld.

### Platformkeuzes

- [x] Frontend framework kiezen.
- [x] Backend/API aanpak kiezen.
- [x] CMS/headless contentbeheer kiezen.
- [x] LMS-strategie kiezen (custom, integratie of hybride).
- [x] Auth-strategie kiezen (SSO, eigen auth, hybride).
- [x] Zoek- en filterstrategie kiezen.
- [x] Video-hosting strategie kiezen.

### Data model & domein

- [x] Datamodel uitwerken: `Course`, `Lesson`, `Category`, `Tag`, `User`, `Enrollment`, `Certificate`.
- [x] URL-structuur voor nieuwe site vastleggen.
- [x] Taxonomie en metadata model definiÃ«ren.
- [x] Public/private contentregels vastleggen.
- [x] Toegangsmodel bevestigd: lessen publiek, volledige cursusnavigatie en certificaattraject via account.
- [x] Publicatieworkflow definiÃ«ren.

### Niet-functionele vereisten

- [x] Performance target vastleggen (TTFB, CWV, payload).
- [x] Security baseline vastleggen (OWASP, secrets, rate limiting).
- [x] Logging/monitoring eisen vastleggen.
- [ ] Privacy/GDPR eisen valideren.
- [ ] Accessibility target bepalen (minstens WCAG 2.1 AA).

### Delivery & omgeving

- [ ] Omgevingen bepalen (`dev`, `staging`, `prod`).
- [ ] CI/CD strategie bepalen.
- [ ] Back-up en rollback strategie bepalen.
- [ ] Feature flags/canary aanpak bepalen.

### Exitcriteria Fase 2

- [x] Architectuurdocument goedgekeurd.
- [x] Technologiekeuzes formeel vastgelegd.
- [x] Data- en URL-model bevroren voor MVP.

---

## Fase 3 - Backlog, Planning & Setup (Week 3)

### Doel
Roadmap vertalen naar uitvoerbare sprints met duidelijke MVP-afbakening.

### Artefacten

- [x] `planning/SPRINT_1_BACKLOG_V1.md` opgesteld.
- [x] `planning/SPRINT_1_TAKENBORD_V1.md` opgesteld.
- [x] `planning/TESTSTRATEGIE_V1.md` opgesteld.
- [x] `planning/ACCEPTATIECRITERIA_EPICS_V1.md` opgesteld.
- [x] `planning/CAPACITEIT_EN_TIMING_VOORSTEL_V1.md` opgesteld.
- [x] `planning/FASE3_SIGNOFF_V1.md` opgesteld.
- [x] `planning/SPRINT_1_BLOCKERS.md` opgesteld.
- [x] `planning/SPRINT_2_BACKLOG_V1.md` opgesteld.
- [x] `planning/SPRINT_2_TAKENBORD_V1.md` opgesteld.
- [x] `planning/SPRINT_3_CERTIFICAAT_UITVOERPLAN_V1.md` opgesteld.
- [x] `planning/T016_ROLES_IMPLEMENTATIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T017_POLICY_ROUTE_PROTECTIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T019_ADMIN_SKELETON_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T020_COURSE_CRUD_IMPLEMENTATIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T021_LESSON_CRUD_IMPLEMENTATIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T022_ARCHIVE_DEACTIVATE_FLOW_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T023_TAXONOMY_BEHEER_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T024_PROTECTED_COURSEDETAIL_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T025_PROTECTED_LESSONDETAIL_NAV_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T026_REGISTRATIE_FLOW_IMPLEMENTATIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T027_WACHTWOORD_RESET_FLOW_IMPLEMENTATIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T028_ACCOUNT_CURSUSSEN_OVERZICHT_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T029_ACCOUNT_DASHBOARD_ROUTE_FIX_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T030_PROFIEL_BEWERKEN_FLOW_IMPLEMENTATIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T031_AUTH_ANTI_SPAM_IMPLEMENTATIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T032_CURSUSDETAILPAGINA_IMPLEMENTATIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T033_LESDETAILPAGINA_IMPLEMENTATIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T034_SITEWIDE_NAVIGATIE_KLIKBARHEID_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T035_SITEWIDE_MINI_ANIMATIES_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T036_FOOTER_CONTACT_FAQ_IMPLEMENTATIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T037_TOETSENBORDNAVIGATIE_FOCUS_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T038_SEO_METADATA_PER_PAGINA_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T039_DEMO_CERTIFICAAT_PAGINA_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T040_STRUCTURED_DATA_BASIS_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T041_PUBLIEKE_CERTIFICAAT_VERIFICATIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T042_CURSUSVOLTOOIING_EN_PROGRESSIE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T043_AUTOMATISCHE_CERTIFICAATUITGIFTE_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T044_CERTIFICAAT_PDF_DOWNLOAD_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T045_ADMIN_CERTIFICAAT_BEHEER_EN_AUDIT_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T046_CERTIFICAAT_E2E_QA_NOTITIE_2026-03-18.md` opgesteld.
- [x] `planning/T047_UAT_SCRIPTS_KERNJOURNEYS_2026-03-18.md` opgesteld.
- [x] `planning/T048_UAT_UITVOERING_EN_SIGNOFF_TEMPLATE_2026-03-18.md` opgesteld.
- [x] `planning/T049_QA_BASELINE_AUTOMATISCH_2026-03-18.md` opgesteld.
- [x] `planning/T050_QA_NON_FUNCTIONELE_SMOKERUN_2026-03-18.md` opgesteld.
- [x] `planning/T051_UAT_TECHNISCHE_DRYRUN_2026-03-18.md` opgesteld.
- [x] `planning/T052_UAT_BUSINESS_SUPPORT_DOSSIER_2026-03-19.md` opgesteld.
- [x] `planning/T053_FREEZE_WINDOW_PLAN_2026-03-19.md` opgesteld.
- [x] `planning/T054_SAFE_STATE_MODE_IMPLEMENTATIE_2026-03-19.md` opgesteld.
- [x] `planning/T055_FINALE_CONTENT_SYNC_PLAN_2026-03-19.md` opgesteld.
- [x] `planning/T056_DNS_SWITCH_EN_ROLLBACKPLAN_2026-03-19.md` opgesteld.
- [x] `planning/T057_INCIDENT_RUNBOOK_2026-03-19.md` opgesteld.
- [x] `planning/T058_FASE4_UIUX_DESIGN_BASELINE_2026-03-19.md` opgesteld.
- [x] `planning/T059_FASE4_UIUX_HIGH_FIDELITY_IMPLEMENTATIE_2026-03-19.md` opgesteld.
- [x] `planning/T060_ADMIN_GEBRUIKERSBEHEER_BACKEND_2026-03-19.md` opgesteld.
- [x] `planning/T061_ADMIN_ONLY_BACKEND_EN_ACCOUNT_ROUTING_2026-03-19.md` opgesteld.
- [x] `planning/T062_ADMIN_SETUP_FALLBACKS_2026-03-19.md` opgesteld.
- [x] `planning/T063_CATEGORIE_TAG_RELATIES_IMPLEMENTATIE_2026-03-19.md` opgesteld.
- [x] `planning/T064_FASE5_OVER_EN_JURIDISCHE_PAGINAS_2026-03-19.md` opgesteld.
- [x] `planning/T065_LEGACY_CARD_STIJL_EN_ADMIN_BUNDELING_2026-03-19.md` opgesteld.
- [x] `planning/T066_LESSENSET_VOLLEDIGHEID_2026-03-19.md` opgesteld.
- [x] `planning/T067_LES_CATEGORIEEN_LEGACY_SYNC_2026-03-19.md` opgesteld.
- [x] `planning/T068_ADMIN_STATISTIEKEN_BACKEND_2026-03-19.md` opgesteld.
- [x] `planning/T069_ADMIN_DRAG_DROP_VOLGORDE_2026-03-19.md` opgesteld.
- [x] `planning/T070_LEGACY_CONTENT_IMPORT_COMMAND_2026-03-19.md` opgesteld.
- [x] `planning/LOCAL_TEST_LOGIN_CREDENTIALS.md` opgesteld.
- [x] `planning/MAPPING_TEMPLATE_V1.csv` opgesteld.
- [x] `planning/REDIRECTS_READY_V1.csv` opgesteld.
- [x] `planning/QA_SMOKE_SPRINT1_2026-03-18.md` opgesteld.
- [x] `planning/SPRINT_1_RELEASE_NOTES_2026-03-18.md` opgesteld.
- [x] `planning/SPRINT_1_DEMO_PREP_2026-03-18.md` opgesteld.

### Taken

- [x] MVP user stories uitschrijven per flow.
- [x] Prioriteiten bepalen (MoSCoW: Must/Should/Could/Won't).
- [x] Sprintplanning opstellen.
- [x] Technische spikes plannen voor resterende onzekerheden.
- [x] Teststrategie opstellen (unit, integratie, e2e, UAT).
- [x] Acceptatiecriteria per epic vastleggen.
- [x] Teamcapaciteit en timing bevestigen.
- [x] Lokale runtime prerequisites bevestigd (`php`, `composer`).
- [x] Volgende roadmapstap uitgewerkt: certificaattraject opgesplitst in concrete uitvoeringstaken.

### Exitcriteria Fase 3

- [x] Geprioriteerde backlog klaar.
- [x] Sprint 1 klaar om te starten.
- [x] Product + techniek akkoord op MVP.

---

## Fase 4 - UX/UI & Design System (Week 3-5)

### Doel
Nieuwe, consistente interface uitwerken voor publiek en leeromgeving.

### Taken

- [x] Informatiearchitectuur finaliseren.
- [x] Navigatiestructuur finaliseren.
- [x] Wireframes maken voor kernpagina's.
- [x] High-fidelity designs maken voor desktop + mobiel.
- [x] Design tokens opstellen (kleur, typografie, spacing, component states).
- [x] Componentbibliotheek definiëren (buttons, cards, forms, tabs, accordions, alerts).
- [x] Subtiele mini-animaties sitewide geactiveerd (hover, kaart-lift, zachte reveal, reduced-motion veilig).
- [x] Interacties voor cursus/lesnavigatie uitwerken.
- [x] Form UX voor login/registratie/account uitwerken.
- [x] Accessibility review op designs uitvoeren.
- [x] Content guidelines opstellen (titels, CTA's, helptekst).

### Exitcriteria Fase 4

- [ ] UX flows goedgekeurd door stakeholders.
- [x] UI kit + component specs klaar voor bouw.
- [x] Copy en contentrichtlijnen beschikbaar.

---

## Fase 5 - MVP Build Publieke Site (Week 5-8)

### Doel
Publieke experience opzetten met snelle prestaties en duidelijke structuur.

### Must-have pagina's

- [x] Home
- [x] Cursussen overzicht
- [x] Lessenoverzicht
- [x] Over Octopus Academy
- [x] Juridische pagina's
- [x] Contact/FAQ links

### Functionaliteiten

- [x] Header/navigation
- [x] Footer met relevante links
- [x] Zoekfunctie (minimale versie)
- [x] Filteren op categorie/tag/level
- [x] Cursuskaart componenten
- [x] Lesoverzicht componenten
- [x] CTA's naar demo/portal waar nodig
- [x] Publieke messaging afgestemd: cursussen + lessen gratis, aanmelden voor volledige opvolging + certificaat.

### Kwaliteit

- [x] Responsive gedrag op alle kernbreakpoints.
- [x] Toetsenbordnavigatie en focus states.
- [x] SEO metadata per pagina.
- [x] Structured data basis waar relevant.
- [x] Performance budget gehaald.

### Exitcriteria Fase 5

- [ ] Publieke MVP pagina's werken in staging.
- [ ] Content kan beheerd worden via gekozen CMS-oplossing.
- [ ] SEO basis volledig aanwezig.

---

## Fase 6 - MVP Build LMS, Auth & Account (Week 6-10)

### Doel
Kern van de leerervaring migreren zonder regressies in account- en toegangsflows.

### Auth & account

- [x] Login flow implementeren.
- [x] Registratie flow implementeren.
- [x] Wachtwoord reset flow implementeren.
- [x] Profiel bewerken flow implementeren.
- [x] Mijn cursussen overzicht implementeren.
- [x] Logout flow implementeren.
- [x] Captcha/anti-spam voorzien.

### LMS kern

- [x] Cursusdetailpagina implementeren.
- [x] Lesdetailpagina implementeren.
- [x] Lesnavigatie (vorige/volgende/progressie) implementeren.
- [x] Toegangscontrole per gebruiker implementeren.
- [x] Categorie/tag relateringen implementeren.
- [x] Voortgangsregistratie basis implementeren.

### Contentbeheer backend (CMS admin)

- [x] Admin-overzicht voor cursussen en lessen voorzien.
- [x] Admin statistiekenpagina voorzien (gebruikers, content, voortgang, certificaten, activiteit).
- [x] Admin drag-and-drop volgorde voor cursussen en lessen voorzien (publieke volgorde).
- [x] Nieuwe cursus kunnen aanmaken.
- [x] Bestaande cursus kunnen aanpassen.
- [x] Cursus kunnen deactiveren/verwijderen (met veilige fallback).
- [x] Nieuwe les kunnen aanmaken binnen een cursus.
- [x] Bestaande les kunnen aanpassen.
- [x] Les kunnen deactiveren/verwijderen (met veilige fallback).
- [x] Categorieen en tags beheren via admin.
- [x] Publicatiestatus beheren (`draft`, `published`, `archived`).
- [x] Wijzigingen valideren met rol/permissies (admin-only backend).

### Certificaten

- [x] Certificaatgegevens modeleren (`certificate_number`, `issued_at`, `course_id`, `user_id`, `verification_token`).
- [x] Regels voor "cursus voltooid" vastleggen (welke lessen verplicht zijn en welke progressie nodig is).
- [x] Automatische certificaatuitgifte voorzien bij afgeronde cursus.
- [x] Certificaatdownload voorzien in "Mijn cursussen" (PDF).
- [x] Certificaatverificatieflow migreren of herdenken.
- [x] Publieke verificatiepagina voorzien.
- [x] Backoffice actie voorzien: certificaat heruitgeven of intrekken.
- [ ] E-mailflow bepalen (certificaatlink bij uitgifte, optioneel voor MVP).

### Exitcriteria Fase 6

- [ ] End-to-end user journey werkt in staging.
- [ ] End-to-end certificaatflow getest (`aanmelden -> cursus volgen -> certificaat -> verificatie`).
- [ ] Kritieke regressies opgelost.
- [ ] Supportteam kan flows demonstreren.

---

## Fase 7 - Content Migratie (Week 8-11)

### Doel
Alle relevante content correct en gecontroleerd overzetten.

### Voorbereiding

- [ ] Mappingbestand opstellen van oud naar nieuw datamodel.
- [ ] URL mappingbestand opstellen per pagina/course/lesson.
- [ ] Velden voor metadata en SEO mappen.
- [ ] Media migration plan opstellen.

### Uitvoering

- [ ] Pagina's migreren.
- [ ] Cursussen migreren.
- [ ] Lessen migreren.
- [ ] Categorieen en tags migreren.
- [ ] Interne links corrigeren.
- [ ] Downloads/embeds valideren.

### Validatie

- [ ] Steekproef op contentopmaak.
- [ ] Steekproef op linkintegriteit.
- [ ] Steekproef op metadata.
- [ ] Steekproef op toegangsregels.

### Exitcriteria Fase 7

- [ ] 100% van MVP-content gemigreerd.
- [ ] Geen kritieke contentfouten open.
- [ ] Content-eigenaars geven akkoord.

---

## Fase 8 - SEO, Redirects & Analytics (Week 9-11)

### Doel
Zoekverkeer en meetbaarheid behouden of verbeteren bij livegang.

### SEO

- [ ] Definitieve lijst oude URL's bevestigen.
- [ ] 301 redirect mapping volledig maken.
- [ ] Redirect testset opstellen en uitvoeren.
- [ ] Canonical strategie valideren.
- [ ] XML sitemap nieuw platform opzetten.
- [ ] Robots.txt correct op root publiceren.
- [ ] Test/technische pagina's `noindex` of verwijderen.
- [ ] Dubbele pagina's oplossen (bv. `/nl/` versus `/nl/home/`).

### Analytics & tracking

- [ ] Trackingplan opstellen (events + conversies).
- [ ] Consent/cookie implementatie valideren.
- [ ] KPI dashboards opzetten.
- [ ] UTM en campagneattributie valideren.

### Exitcriteria Fase 8

- [ ] Redirect coverage 100% voor gekende URL's.
- [ ] SEO checks groen op staging.
- [ ] Tracking meet correct op testscenario's.

---

## Fase 9 - QA, UAT & Go-Live Voorbereiding (Week 10-12)

### Doel
Risico minimaliseren voor productie.

### QA

- [x] Unit tests op kritieke modules.
- [x] Integratietests op data- en auth flows.
- [x] E2E tests op kernjourneys.
- [x] Cross-browser testen.
- [x] Mobile device testen.
- [x] Performance regressietesten.
- [x] Security smoke tests.
- [x] Accessibility audit uitvoeren.

### UAT

- [x] UAT-scripts opstellen.
- [x] Technische pre-UAT dry-run uitvoeren.
- [x] UAT dossier voor business/support voorbereiden.
- [ ] UAT uitvoeren met business/support.
- [ ] Bevindingen prioriteren en oplossen.
- [ ] Finale UAT sign-off verkrijgen.

### Go-live voorbereiding

- [x] Freeze window plannen.
- [x] Finale content sync plannen.
- [x] DNS/switch en rollbackplan finaliseren.
- [x] Incident runbook klaarzetten.
- [x] On-call planning voor launchweek opstellen (`uitgesteld`: pas vastleggen zodra launchdatum bevestigd is).

### Exitcriteria Fase 9

- [ ] Geen openstaande P0/P1 issues.
- [ ] UAT sign-off ontvangen.
- [ ] Go-live checklist volledig groen.

---

## Fase 10 - Go-Live & Hypercare (Week 12+)

### Doel
Stabiele livegang met snelle opvolging van issues.

### Go-live dag

- [ ] Finale backup genomen.
- [ ] Laatste content delta gemigreerd.
- [ ] Redirects geactiveerd.
- [ ] DNS/switch uitgevoerd.
- [ ] Smoke tests in productie uitgevoerd.
- [ ] Monitoring actief gecontroleerd.

### Hypercare (eerste 2-4 weken)

- [ ] Dagelijkse check op errors en performance.
- [ ] Dagelijkse check op SEO indexatie.
- [ ] Dagelijkse check op registratie/login conversies.
- [ ] Support feedback verwerken.
- [ ] P0/P1 issues binnen SLA oplossen.

### Exitcriteria Fase 10

- [ ] Platform stabiel binnen afgesproken KPI's.
- [ ] Hypercare afgesloten.
- [ ] Overdracht naar reguliere werking afgerond.

---

## Post-MVP Backlog (na livegang)

- [ ] Geavanceerde personalisatie.
- [ ] Aanbevelingsengine voor cursussen.
- [ ] Verdere optimalisatie zoek/filter.
- [ ] Extra rapportering voor learning analytics.
- [ ] A/B testing framework.
- [ ] Internationale uitbreidingen indien nodig.

---

## Beslissingslog (in te vullen)

- [x] Beslissing 01: Migratiestrategie bevestigd.
- [x] Beslissing 02: Technologiekeuze bevestigd.
- [x] Beslissing 03: Auth/LMS aanpak bevestigd.
- [x] Beslissing 04: Rollenmodel uitgesteld naar Sprint 2 (bevestigd op `2026-03-17`).
- [x] Beslissing 05: Gratis toegang bevestigd (cursussen + lessen), account voor certificaattraject (bevestigd op `2026-03-18`).
- [ ] Beslissing 06: Launchwindow bevestigd.

---

## Risicolog (in te vullen)

- [ ] Risico: SEO verlies bij migratie.
- [ ] Risico: regressie in login/registratie.
- [ ] Risico: lesson access rechten fout geconfigureerd.
- [ ] Risico: certificaat te vroeg of onterecht uitgereikt door fout in voltooiingsregels.
- [ ] Risico: onderschatting content cleaning.
- [ ] Risico: afhankelijkheid externe platformen.

---

## Go/No-Go Checklist (verplicht voor live)

- [ ] Geen openstaande P0 issues.
- [ ] Geen openstaande P1 issues zonder workaround.
- [ ] Redirectbestand volledig en getest.
- [ ] Auth + account + cursusflow succesvol end-to-end getest.
- [ ] Certificaatuitgifte + publieke verificatie succesvol end-to-end getest.
- [ ] Juridische pagina's en privacy checks goedgekeurd.
- [ ] Monitoring en alerts actief.
- [ ] Rollbackplan getest.
- [ ] Stakeholder sign-off ontvangen.

