# T063 Categorie/tag relaties implementatie

- Datum: `2026-03-19`
- Doel: categorie- en tagrelaties effectief koppelen aan cursussen en lessen.

## 1) Data- en modeluitbreiding

- Nieuwe pivot tabellen:
  - `course_taxonomy_term`
  - `lesson_taxonomy_term`
- Modelrelaties toegevoegd:
  - `Course <-> TaxonomyTerm` (categorieen + tags)
  - `Lesson <-> TaxonomyTerm` (lescategorieen)

## 2) Admin backend

- Cursusformulier ondersteunt nu selectie van:
  - cursuscategorieen
  - cursustags
- Lesformulier ondersteunt nu selectie van:
  - lescategorieen
- Bij `store/update` worden relaties gesynchroniseerd met pivotdata.
- Overzichten tonen taxonomie-indicatie:
  - cursuslijst: aantal categorieen + tags
  - lessenlijst: aantal categorieen

## 3) Accountweergave

- Cursusdetail toont nu gekoppelde categorieen en tags.
- Lesdetail toont nu gekoppelde lescategorieen.

## 4) Validatie

- Form request rules uitgebreid met relationele taxonomievelden.
- CRUD-tests uitgebreid met asserts op pivot-tabellen voor:
  - cursus create/update
  - les create/update
- Volledige suite en build geslaagd.

## 5) Resultaat

- Taxonomiebeheer is niet langer losstaand: relaties zijn operationeel in admin én zichtbaar in leeromgeving.
