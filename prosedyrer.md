# Prosedyrer

Roller omtalt her:

* Tjenesteutvikler (Synnøve Nymark Aasen, Kjell-Åge Tingstad)
* Produkteier (John Petter Skjetne)
* Fagansvarlig (Monica Ramberg)
* Utviklingsteam (Kasper Røstvold, Roger Aunet, Torild Kulseth Klemetsaune)
* NHN kundesenter
* Superbruker 
* Brukere

## Ny database i eFORSK (prod)

Utføres av fagansvarlige.

### Forberedelser

* Det må først foreligge en avtale om bruk av eFORSK. Informasjon fra denne brukes for å sette opp databasen. 
* Superbruker for prosjektet må eksistere i FALK, hvis den ikke gjør det - send følgende e-post: `Fyll ut skjema på https://falk.eforsk.nhn.no/u/apply?app=eFORSK for å klargjøre din bruker i eFORSK. Lokasjon trengs ikke besvares, denne er ikke klar ennå.`
#### Hvis ePROM:
  * Opprett bestillersystem i ePROM:
    * Logg inn i ePROM PROD og ePROM QA
    * Gå til Bestillersystemer, velg Nytt bestillersystem
    * Bestillersystemet skal ha samme navn som prosjektet (max 100 tegn). NB: Fyll kun ut feltet 'Navn', ikke feltet 'Navn - Ikke sensitiv' 
    * Kryss av sjekkboksen eFORSK
    * API base URL skal være: https://app-eforsk.nhn.no/eforsk (både QA og PROD)
    * Ta vare på begge API-nøkler
    * Alle andre felter kan stå tomme
    * Lagre bestillersystem

### Når dette er gjort, gå videre med selve opprettelsen i eFORSK
  
* Aktiver database på https://eforsk.nhn.no/ administrasjon
  *  Fyll inn alle felter og kryss av for bestilte funksjoner. 
  *  Dersom ePROM skal brukes, legg inn API-nøkler for hhv PROD og QA/TEST. 
  *  Lagre database. Dersom ePROM er aktivert, velg 'Test ePROM'. Begge skal ha status 'Tilkoblet', da er det kontakt mellom eFORSK og ePROM.
* Hvis gjenstående ledige databaser har nådd 3 eller mindre, kontakt tjenesteutvikler og meld fra om dette slik at bestilles opp flere fra NHN
* Gi tilgang til superbruker i FALK, superbruker tar seg av videre tilganger for databasen. **Vær nøye på å gi riktige tilganger, KRITISK punkt.** 
  * Superbruker: Finn superbrukeren under Søknader, trykk på den, administrer tilgang og tildel rollen Superbruker på **riktig** database
  * Tilgangstildeler: Under Tilgangstildeler, søk opp superbruker, sett som tilgangstildeler på **riktig** database
* Informer superbruker om at databasen er klar

## Ny demodatabase i eFORSK (mrsweb)

Utføres av fagansvarlig? Evt utviklingsteam..

Når en person vil ha demodatabase;

* Finn ledig statisk fødselsnummer i test p-reg
* Logg på administrasjonen som administrator på https://mrsweb.hemit.org/eFORSK/
* Finn ledig database. 
  * Legg personens navn i databasenavnet.
  * Legg inn personens navn i "Navn på databaseansvarlig ".
  * Legg til fødselsnummer i fakturafeltet slik at vi har det lagret
  * Aktiver ePROM, gjenbruk API nøkler fra andre databaser
  * Aktiver alle funksjoner til utprøving
* Logg på falk med fødselsnummeret og søk tilgang til databasen
* Logg på falk som eFORSK administrator og finn søknaden, gi databaseansvarlig rollen til databasen, og tilgangstildeler rollen til databasen.

## Planlegging av ny versjon

Utføres av utviklingsteam, fagansvarlige, tjenesteutvikler og produkteier

## Produksjonssetting av ny versjon

Utføres av utviklingsteam (?)

* Hold endringslogg i brukermanual oppdatert på endringer og datoer fortløpende
* Logg på eFORSK prod i administrasjon og opprett nye varsler for ny versjon (se tidligere varsler for eksempel her)
* (Send ut e-post til alle aktive brukere siste måned med varsler om ny versjon?)
* Etter produksjonssetting, sjekk status på integrasjoner i eFORSK administrasjon
* Følg opp feil og advarsler i splunk
* Oppdater brukermanual

## Nytt ePROM skjema

* Digitalt skjema: superbruker melder fra til fagansvarlig når dem ønsker et digitalt skjema godkjent
* **Papirskjema**: en prosjektleder i Hemit systemutvikling må involveres med testere før papirskjema kan bestilles, dette er en prosess som tar uker - så det lønner seg å komme i gang tidlig.

## Henvendelser fra brukere

Skjer i følgende rekkefølge:

Brukere (og potensielle brukere) av eFORSK skal via sin forskningsavdeling få en superbruker som dem henvender seg til. For de fleste vil dette kunne være eforsk@stolav.no. 
Brukere skal ikke ha direkte kontakt med andre i normale tilfeller. Brukere og superbrukere støtter seg først og fremst på brukermanualen.

Hvis superbruker ikke kan hjelpe eller har svar, tar superbruker videre kontakt med fagansvarlig.

Hvis fagansvarlig ikke kan hjelpe eller har svar, tar fagansvarlig videre kontakt med utviklingsteam (evt enda et ledd med produkteier?).

Utviklingsteam oppdaterer brukermanual der det er hensiktsmessig.

## Feil i løsningen

Brukere tar kontakt med NHN kundeservice som anvist i footer på eFORSK.

NHN kundesenter tar i tur kontakt med utviklingsteam hvis dem ikke kan hjelpe.
