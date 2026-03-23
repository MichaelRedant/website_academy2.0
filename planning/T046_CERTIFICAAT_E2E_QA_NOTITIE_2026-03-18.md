# T046 Certificaat E2E QA Notitie

- Datum: `2026-03-18`
- Scope: end-to-end testpad voor certificaatjourney en QA-checks

## Wat is opgeleverd

- Nieuwe feature test:
  - `monolith/tests/Feature/CertificateJourneyE2eTest.php`
- Gedekte flow:
  1. learner logt in
  2. learner voltooit lessen
  3. automatische certificaatuitgifte na laatste les
  4. PDF-download in account
  5. publieke verificatie `geldig`
  6. admin trekt certificaat in
  7. publieke verificatie `ingetrokken`
  8. admin heruitgifte
  9. publieke verificatie opnieuw `geldig`

## Impact op checklist

- QA/acceptatie in sprint 3 heeft nu concreet feature + end-to-end testpad.
- Publieke verificatie is functioneel gevalideerd in combinatie met uitgifte en intrekking.

## Verificatie

- Gerichte test `CertificateJourneyE2eTest`: geslaagd.
- Volledige regressieset + build daarna opnieuw geslaagd.
