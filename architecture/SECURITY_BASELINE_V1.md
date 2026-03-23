# Security Baseline V1

- Datum: `2026-03-19`
- Status: `vastgelegd` voor MVP onder Architectuurkeuze C
- Scope: Laravel monolith (`web`, `admin`, `account`, publieke catalogus en certificaatflows)

## 1) Doel

Een minimum security-baseline vastleggen zodat:

1. kritieke risico's vroeg afgedekt zijn;
2. implementaties consistent beoordeeld kunnen worden;
3. release-go/no-go een objectieve security-check bevat.

## 2) OWASP-baseline (MVP)

### A01 - Broken Access Control

1. Admin backend blijft `admin-only` via `auth` + `can:access-admin` + `role:admin`.
2. Account routes blijven beschermd via `can:view-learning-area` en detail-gates (`view-course-detail`, `view-lesson-detail`).
3. Privilege-escalatie vermijden: geen trust op UI-only checks, altijd server-side gate/policy.

### A02 - Cryptographic Failures

1. Productie enkel via HTTPS.
2. `APP_KEY` verplicht en uniek per omgeving.
3. Wachtwoorden blijven gehashed via Laravel `hashed` cast op `User::password`.
4. Geen gevoelige data in querystring of plaintext logs.

### A03 - Injection

1. Inputvalidatie verplicht op auth-, account- en adminmutaties.
2. ORM/query builder als standaardpad; raw SQL enkel met parameterbinding.
3. Blade output blijft escaped by default; enkel expliciet unescaped waar functioneel nodig.

### A04 - Insecure Design

1. Public/private contentregels blijven leidend: lessen publiek, cursusnavigatie en certificaattraject via account.
2. Safe-state blijft beschikbaar om admin writes tijdelijk te blokkeren zonder downtime.

### A05 - Security Misconfiguration

1. Productie: `APP_DEBUG=false`, geen stack traces naar eindgebruiker.
2. Session-cookies in productie: `SESSION_SECURE_COOKIE=true`, `SESSION_HTTP_ONLY=true`, `SESSION_SAME_SITE=lax` (of strikter waar mogelijk).
3. Onnodige test/debug routes blijven uit productie.

### A06 - Vulnerable and Outdated Components

1. Dependency-updates minimaal 1x per sprint evalueren.
2. Security advisories op PHP/npm packages mee opnemen in releasechecklist.

### A07 - Identification and Authentication Failures

1. Reeds actieve rate-limiters:
   - `academy-login`
   - `academy-register`
   - `academy-password-email`
   - `academy-password-reset`
   - `academy-certificate-verify`
2. Anti-spam middleware (`academy.anti_spam`) blijft actief op auth formulieren.
3. Sterke minimumregels voor wachtwoorden blijven verplicht (`letters + numbers`, minimumlengte).

### A08 - Software and Data Integrity Failures

1. Wijzigingen lopen via version-controlled code + migrations.
2. Geen manuele, niet-gedocumenteerde productiepatches buiten incidentprocedure.

### A09 - Security Logging and Monitoring Failures

1. Auth-fouten, admin-mutaties en certificaat-acties blijven auditbaar.
2. Loggingniveau productie minimaal `warning/error` + escalatie op kritieke fouten.

### A10 - Server-Side Request Forgery (SSRF)

1. Externe URL-invoer wordt niet blind server-side opgevraagd.
2. Nieuwe integraties met outbound requests vereisen allowlist-validatie.

## 3) Secretsbeleid

1. Secrets alleen via omgeving (`.env` / secret store), nooit hardcoded.
2. `.env` nooit committen; enkel `.env.example` als template.
3. Minimaal te beheren secrets per omgeving:
   - `APP_KEY`
   - `DB_*`
   - `REDIS_*`
   - `MAIL_*`
   - providerkeys (`AWS_*`, webhook/API keys waar relevant)
4. Rotatiebeleid:
   - direct bij vermoeden van lek;
   - gepland minimaal per kwartaal voor kritieke sleutels.

## 4) Rate-limiting baseline

1. Bestaande auth/certificaat limiters zijn verplicht in alle omgevingen.
2. Nieuwe publieke POST- of zoekendpoints krijgen standaard een expliciete limiter.
3. Bij abuse-signalen: tijdelijk strakker limiterprofiel activeren via config/redeploy.

## 5) Security gate voor release

Voor een release naar productie moet dit minimaal groen zijn:

1. Geen open P0/P1 security issues.
2. `APP_DEBUG=false` bevestigd op targetomgeving.
3. Rate-limiters actief op auth/certificaat en nieuwe publieke mutatie-endpoints.
4. Admin-only backend effectief afgeschermd voor niet-admins.
5. Basis security smoke uitgevoerd (`auth`, `authorization`, `csrf/session`, `safe-state` mutatieblokkering).

## 6) Cadans

1. Security baseline review: minimaal 1x per sprint.
2. Volledige herziening: bij launchvoorbereiding en bij grote architectuurwijziging.
