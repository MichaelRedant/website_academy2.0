# T041 Publieke Certificaat Verificatie Notitie

- Datum: `2026-03-18`
- Scope: publieke verificatieflow voor certificaten (token of certificaatnummer)

## Wat is opgeleverd

- Nieuwe publieke route:
  - `/certificaat-verificatie` (`certificates.verify`)
  - controller: `App\Http\Controllers\CertificateVerificationController`
- Nieuwe publieke pagina:
  - `monolith/resources/views/pages/certificates/verify.blade.php`
  - invoerveld voor certificaatnummer of verificatiecode
  - resultaatstatussen:
    - `Geldig certificaat`
    - `Ingetrokken certificaat`
    - `Niet gevonden`
    - `Setup incomplete` (lokale fallback wanneer DB-tabellen ontbreken)
- Footer uitgebreid met directe link:
  - `Certificaat verifiëren`

## Anti-abuse

- Nieuwe rate limiter:
  - key: `academy-certificate-verify`
  - limieten:
    - `8` requests/minuut per IP + code
    - `20` requests/minuut per IP
- Route gebruikt middleware:
  - `throttle:academy-certificate-verify`

## Structured data

- Verificatiepagina bevat JSON-LD:
  - `WebPage`
  - `SearchAction` (zoekactie met queryparameter `code`)

## Testdekking

- Nieuwe feature test:
  - `monolith/tests/Feature/PublicCertificateVerificationTest.php`
  - dekt paginaweergave, geldige/ingetrokken/niet-gevonden status en throttling
- Bestaande tests uitgebreid:
  - `StructuredDataSchemaTest` (schema op verificatiepagina)
  - `SeoMetadataTest` (indexeerbare metadata)
  - `PublicFooterAndSupportPagesTest` (footerlink)
