# T056 DNS Switch En Rollbackplan

- Datum: `2026-03-19`
- Doel: gecontroleerde DNS-overschakeling met snel en veilig rollbackpad.
- Context: Octopus Academy is nog niet publiek live; dit plan wordt geactiveerd in de launchfase.

## 1) Scope

- Publiek domein/subdomein:
  - `academy.octopus.be` (of definitieve productiehost)
- DNS-records in scope:
  - `A` of `CNAME` voor hoofdhost
  - eventuele `www` alias
- Niet in scope:
  - mailbox/DKIM/SPF records
  - andere niet-academy subdomeinen

## 2) Voorbereiding (T-48u tot T-2u)

1. TTL verlagen naar `300s` op te wijzigen records.
2. Huidige DNS-waarden en provider-screenshots bewaren.
3. Bevestigen dat nieuwe target-omgeving volledig klaar staat.
4. Finale content sync (`T055`) afronden.
5. Safe State inschakelen tijdens laatste checks (optioneel, aanbevolen).

## 3) Cutover volgorde (T-0)

1. Go/no-go call met Product + Tech + Support.
2. DNS-record aanpassen naar nieuwe productie-target.
3. CDN/cache purge uitvoeren (indien van toepassing).
4. Directe smoke checks:
   - home
   - login
   - account
   - cursusdetail
   - lesdetail
   - certificaatverificatie
5. Monitoring 30 minuten intensief opvolgen.

## 4) Validatie na switch

- `+5 min`: DNS-resolutie en HTTP reachability OK.
- `+15 min`: kernflows werken zonder P0 fouten.
- `+30 min`: geen piek in 5xx/critical errors.
- `+60 min`: support bevestigt geen blocker meldingen.

## 5) Rollback triggers

Rollback onmiddellijk starten bij minstens één van:

- P0 fout op login/account/cursusflow.
- Onverwachte 5xx spike > afgesproken drempel.
- Certificaatflow of verificatie volledig onbruikbaar.
- Onoplosbare routing/SSL fout binnen 15 minuten.

## 6) Rollback procedure

1. DNS-record terugzetten naar vorige waarde.
2. CDN/cache opnieuw purgen.
3. Safe State actief houden tot stabiliteit bevestigd is.
4. Opnieuw smoke checks uitvoeren op oude omgeving.
5. Incident registreren + oorzaakanalyse starten.

## 7) Rollen

- Tech lead:
  - voert DNS-wijziging uit
  - beslist rollback samen met product owner
- Product owner:
  - finale business GO/NO-GO
- Support lead:
  - valideert gebruikersimpact tijdens hypercare-window

## 8) Cutover log (invullen op launchdag)

- Starttijd:
- DNS wijziging door:
- Oude waarde:
- Nieuwe waarde:
- TTL:
- Eerste validatie resultaat:
- Eventuele issues:
- Beslissing:
  - `[ ] GO`
  - `[ ] ROLLBACK`
