# T039 Demo Certificaat Pagina Notitie

- Datum: `2026-03-18`
- Scope: visuele voorbeeldpagina van certificaat met fictieve data, zodat dit snel toonbaar is zonder login

## Wat is opgeleverd

- Nieuwe publieke route:
  - `/demo/certificaat` (`certificates.demo`)
- Nieuwe view:
  - `monolith/resources/views/pages/certificates/demo.blade.php`
  - bevat een duidelijke, printbare voorbeeldweergave met:
    - naam: `Jan Peeters`,
    - cursus: `Cursus: Peppol`,
    - certificaatnummer: `OCA-2026-000123`,
    - verificatiecode: `Q7M4K9P2`.
  - bevat ook klassieke certificaatdecoratie met inline SVG:
    - hoekornamenten,
    - subtiele watermark-zegel,
    - decoratief kwaliteitszegel.
- SEO voor de demopagina:
  - `noindex, nofollow` zodat deze niet als productieve certificaatpagina geïndexeerd wordt.
- Dezelfde SVG-stijl is ook doorgetrokken naar de echte certificaatpagina
  (`monolith/resources/views/pages/account/certificates/show.blade.php`).
- Update op vraag van product:
  - Octopus-logo in zegel/watermark opnieuw verwijderd,
  - ster teruggezet in de zegel,
  - transparante watermark in het midden volledig verwijderd.

## Testdekking

- Nieuwe feature test `DemoCertificatePageTest` valideert:
  - route bereikbaar voor gasten,
  - voorbeeldinhoud aanwezig,
  - noindex metadata aanwezig.
