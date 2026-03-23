# T055 Finale Content Sync Plan

- Datum: `2026-03-19`
- Doel: gecontroleerde laatste inhoudssynchronisatie richting livegang.
- Context: Octopus Academy staat nog niet live; dit document is een uitvoerplan voor launchfase.

## 1) Scope van de sync

- Pagina's: home, cursussen, lessen, FAQ, contact.
- Catalogusdata: cursussen, lessen, statussen.
- Taxonomie: categorieen/tags.
- Certificaatgerelateerde metadata: enkel bestaande records die relevant zijn.
- SEO-data: titels, descriptions, canonicals.
- Interne links/embeds: geen links naar legacy domein.

## 2) Sync-vensters

1. `T-7 dagen`: proefsync op staging + validatie.
2. `T-2 dagen`: pre-productie dry-run met finale checklist.
3. `T-0` (launchdag): finale delta sync in freeze/safe-state context.

## 3) Werkwijze per sync-run

1. Voorbereiding:
   - backup van doeldatabase nemen.
   - Safe State activeren (optioneel, aanbevolen tijdens finale run).
2. Sync:
   - inhoud bijwerken volgens finale mapping en goedgekeurde broncontent.
   - links/embeds controleren op intern doel en correcte werking.
3. Validatie:
   - steekproef op 10 cursussen + 20 lessen.
   - controle op slugs, navigatie, toegangsregels, certificaatflow.
4. Afronding:
   - validatierapport opslaan.
   - bij finale run: Safe State uitschakelen na GO.

## 4) Verplichte checks na finale delta

- `[ ]` Cursus- en lessenoverzichten tonen verwachte aantallen.
- `[ ]` Detailpagina's werken zonder 404.
- `[ ]` Geen zichtbare links naar `academy.octopus.be`.
- `[ ]` Learner login + lesvoltooiing + certificaatflow werkt.
- `[ ]` Admin kan cursus/les/taxonomie records openen en aanpassen.
- `[ ]` Publieke certificaatverificatie werkt (geldig + ingetrokken scenario).

## 5) Rollback bij sync-probleem

1. Publicatie stopzetten.
2. Laatste databackup terugzetten.
3. Safe State actief houden tot herbevestiging.
4. Oorzaak registreren als `P0` of `P1`.
5. Nieuwe sync-run pas na fix + gerichte hertest.

## 6) Rollen tijdens finale sync

- Product owner:
  - inhoudelijk akkoord op finale contentset.
- Tech lead:
  - uitvoering sync + technische validatie.
- Support lead:
  - functionele steekproef op learner- en accountflows.

## 7) Exitcriteria van dit plan

- Finale delta is uitgevoerd.
- Validatiechecklist volledig groen.
- Geen open sync-gerelateerde `P0`/`P1`.
- Resultaat opgenomen in go-live beslissing.
