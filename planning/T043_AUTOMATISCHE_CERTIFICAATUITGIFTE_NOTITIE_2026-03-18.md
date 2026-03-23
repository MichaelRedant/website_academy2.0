# T043 Automatische Certificaatuitgifte Notitie

- Datum: `2026-03-18`
- Scope: automatische uitgifte wanneer cursus voltooid is

## Wat is opgeleverd

- Bij het voltooien van de laatste gepubliceerde les:
  - wordt automatisch een certificaat uitgereikt (idempotent),
  - gebruiker wordt meteen doorgestuurd naar de certificaatpagina.
- Fallback op cursusdetail:
  - als een cursus al volledig voltooid is maar nog geen certificaat heeft, wordt dit automatisch rechtgezet bij openen van de cursusdetailpagina.
- Manual issue route blijft bestaan als veilige fallback, maar normale flow is nu automatisch.

## Aangepaste componenten

- `AccountLessonProgressController`
  - automatische certificaatuitgifte na finale lesvoltooiing
- `AccountCourseDetailController`
  - lazy auto-issue fallback voor bestaande voltooide trajecten zonder certificaat
- `pages/account/courses/show.blade.php`
  - certificaatblok aangepast naar automatische flow messaging

## Testdekking

- `AccountLessonProgressFlowTest`
  - finale les completion -> automatische redirect naar certificaat
  - fallback auto-issue op cursusdetail
- `AccountCertificateFlowTest`
  - bestaande certificaatregels blijven correct, inclusief completion-gating

## Verificatie

- `npm run monolith:test`: geslaagd
- `npm run monolith:build`: geslaagd
