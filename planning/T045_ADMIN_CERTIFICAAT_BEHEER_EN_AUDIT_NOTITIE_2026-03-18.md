# T045 Admin Certificaat Beheer en Audit Notitie

- Datum: `2026-03-18`
- Scope: backoffice acties voor certificaten + audittrail

## Wat is opgeleverd

- Nieuwe admin module:
  - `/admin/certificaten`
  - overzicht met zoek/filter (`alles`, `geldig`, `ingetrokken`)
  - acties per certificaat:
    - `Heruitgeven`
    - `Intrekken` (enkel als nog geldig)
- Nieuwe admin routes:
  - `GET /admin/certificaten`
  - `POST /admin/certificaten/{certificate}/heruitgeven`
  - `POST /admin/certificaten/{certificate}/intrekken`
- Admin navigatie uitgebreid met item `Certificaten`.

## Audittrail

- Nieuwe tabel:
  - `certificate_audit_logs`
  - velden: `certificate_id`, `actor_user_id`, `action`, `details`
- Audit logging op beheeracties:
  - `admin_revoke`
  - `admin_reissue_revoke_old`
  - `admin_reissue_issue_new`

## Implementatie

- Nieuwe service:
  - `App\Services\Certificates\CertificateAdminService`
  - voert revoke/reissue transacties uit en schrijft auditlogs.
- Nieuwe controller:
  - `App\Http\Controllers\Admin\CertificateManagementController`

## Testdekking

- Nieuwe feature test:
  - `AdminCertificateManagementTest`
  - dekt:
    - routebescherming (learner forbidden)
    - overzicht voor content manager
    - intrekken + auditlog
    - heruitgeven + oude actieve certificaat intrekken + auditlogs
- `AdminSkeletonTest` uitgebreid met certificatenmodule.

## Verificatie

- Gerichte admin-tests geslaagd.
- Volledige testset + build geslaagd.
