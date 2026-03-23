# T058 Fase 4 UI/UX Design Baseline

- Datum: `2026-03-19`
- Scope: UX/UI basis voor Octopus Academy (publiek + account + admin).
- Doel: Fase 4 concreet maken met direct bruikbare designafspraken.

## 1) Informatiearchitectuur (IA)

### Publiek

- Home: `/`
- Cursussen overzicht: `/cursussen`
- Cursusdetail: `/cursussen/{courseSlug}`
- Lesdetail (publiek): `/cursussen/{courseSlug}/lessen/{lessonSlug}`
- Lessen overzicht: `/lessen`
- Certificaatverificatie: `/certificaat-verificatie`
- FAQ: `/faq`
- Contact: `/contact`

### Auth/account

- Login: `/login`
- Registratie: `/register`
- Wachtwoord reset: `/forgot-password`, `/reset-password/{token}`
- Account dashboard: `/account`
- Account profiel: `/account/profiel`
- Mijn cursussen: `/account/cursussen`
- Account cursusdetail + lesflow + certificaat: `/account/...`

### Admin

- Dashboard: `/admin`
- Cursusbeheer: `/admin/cursussen`
- Lessenbeheer: `/admin/lessen`
- Certificaatbeheer: `/admin/certificaten`
- Taxonomiebeheer: `/admin/taxonomie`
- Safe State toggle via admin dashboard

## 2) Navigatiestructuur

- Primaire publieke navigatie:
  - Home
  - Cursussen
  - Lessen
  - Mijn account / Aanmelden
- Footer navigatie:
  - Home, Cursussen, Lessen, FAQ, Contact, Mijn account/Aanmelden
- Admin navigatie:
  - Dashboard, Cursussen, Lessen, Certificaten, Categorieen/tags, Gebruikersrollen

## 3) Wireframe-blauwdruk (low-fi)

### Home

- Hero met waardepropositie + CTA's
- Highlightblokken (cursussen/lessen)
- Snelle navigatie naar kernflows

### Cursussen/Lessen overzichten

- Boven: titel + korte uitleg
- Midden: zoek/filter (waar van toepassing)
- Onder: card-grid met duidelijke interne links

### Detailpagina's

- Header met titel, context, status
- Hoofdinhoud met video/inhoud
- Duidelijke next/previous of terug-naar-overzicht acties

### Auth/account

- Form-first layout, minimale afleiding
- Duidelijke validatie, foutmeldingen en success feedback

## 4) Design tokens (v1)

- Kleuren:
  - zwart: `#000000`
  - wit: `#ffffff`
  - primary: `#306b91`
  - soft: `#e9f6fc`
- Typografie:
  - primaire font: `Space Grotesk`
- Basisstijl:
  - afgeronde kaarten/knoppen
  - subtiele schaduw en border-contrast
  - consistente uppercase micro-labels voor context

## 5) Componentbibliotheek (v1)

- Knoppen:
  - primary action
  - secondary/ghost action
- Cards:
  - cursuscard
  - lescard
  - statcard (dashboard)
- Form componenten:
  - text input
  - select
  - textarea
  - checkbox
  - error/success helper text
- Navigatie:
  - topnav
  - footer nav
  - admin sidenav
- Feedback:
  - statusbanner (incl. Safe State banner)
  - inline statusmelding

## 6) Interacties cursus/lesnavigatie

- Publiek:
  - lesson detail toegankelijk
  - beperkte/gerichte CTA naar account voor trajectflow
- Account:
  - les als voltooid/ongedaan
  - automatische progressie en certificaatlogica
  - duidelijke terug- en vervolgacties

## 7) Form UX (login/registratie/account)

- Minimale velden en duidelijke labels
- Anti-spam invisibel voor gebruiker
- Eenduidige foutmeldingen per veld
- Success status via bevestigingsmelding
- Profielupdate + wachtwoordwijziging in accountflow

## 8) Accessibility design review (v1)

- Skip-link aanwezig
- Focus states zichtbaar
- Keyboardnavigatie op kernflows
- `prefers-reduced-motion` gerespecteerd
- Geen decoratieve lagen die click/tap blokkeren

## 9) Content guidelines (v1)

- Tone of voice:
  - vriendelijk, Vlaams, niet pusherig
- Terminologie:
  - gebruik `Lessen` (niet `losse lessen` of `how-to`)
  - gebruik `Octopus Academy` (niet `Academy 2.0`)
- Conversieboodschap:
  - zowel lessen als cursussen gratis
  - certificaat na afronden volledige cursus met account
