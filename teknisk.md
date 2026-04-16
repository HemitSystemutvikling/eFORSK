---
layout: teknisk
title: Teknisk løsning
description: Arkitektur, sikkerhet, logging og integrasjoner i eFORSK
---

<nav class="toc" aria-label="Innhold på siden">
  <div class="toc-label">Innhold</div>
  <ol class="toc-list">
    <li><a href="#arkitektur">Overordnet arkitektur</a></li>
    <li><a href="#sikkerhet">Sikkerhet</a>
      <ol class="toc-sub">
        <li><a href="#autentisering">Autentisering, brukertilgang og rollestyring</a></li>
        <li><a href="#tilgangstre">Tilgangstre</a></li>
        <li><a href="#lagdeling">Lagdeling og kryptering</a></li>
        <li><a href="#pseudonymisering">Pseudonymisering</a></li>
      </ol>
    </li>
    <li><a href="#logging">Logging</a></li>
    <li><a href="#innsyn">Innsyn</a></li>
    <li><a href="#integrasjoner">Integrasjoner</a>
      <ol class="toc-sub">
        <li><a href="#eprom">ePROM</a></li>
        <li><a href="#persontjenesten">Persontjenesten</a></li>
      </ol>
    </li>
    <li><a href="#data">Data i applikasjonen</a></li>
  </ol>
</nav>

## Overordnet arkitektur {#arkitektur}

eFORSK har en overordnet arkitektur basert på medisinsk registreringssystem (MRS), som en trelagsapplikasjon med lignende sikkerhetsmodell. Applikasjonen består av flere databaser; en felles Common-database, samt egne databaser tilegnet hvert enkelt forskningsprosjekt (register). eFORSK er skrevet i .NET, benytter MS SQL-database og driftes på virtuelle miljø hos Norsk Helsenett (NHN).

<hr class="section-divider">

## Sikkerhet {#sikkerhet}

eFORSK er risikovurdert og all data i programvaren behandles i henhold til gjeldende regler for personvern og datasikkerhet. Programvaren bruker sikker digital kommunikasjon gjennom plattformer som Helsenorge og Digipost, og kommuniserer med FALK og ePROM, som i likhet med eFORSK er bygget på nasjonal infrastruktur.

eFORSK tilbys som en installasjon i NHN infrastruktur og tilbys helseforetak og universiteter med internett som bærer. Sikkerhetsnivået er tilpasset slik eksponering — all data og kommunikasjon er kryptert og sterk autentisering skjer ved bruk av HelseID. eFORSK er utformet i tråd med kravene som stilles i Norm for informasjonssikkerhet i helse- og omsorgstjenesten (Normen) samt tilpasset kravene i GDPR.

Det tas backup av de virtuelle serverne i forkant av større endringer, samt backup av databasene hver natt.

Personvern ivaretas i alle ledd og eFORSK har en robust sikkerhetsmodell egnet for å håndtere sensitive personopplysninger. Sikkerhetsmodellen deles grovt i fire deler:

### Autentisering, brukertilgang og rollestyring {#autentisering}

eFORSK baserer seg på claims-basert autentisering der pålogging og tildeling av informasjon om roller og rettigheter er eksternt. Denne informasjonen benyttes til å styre hvilke data brukeren har lov til å se og hvilke operasjoner de ulike har lov til å utføre. Forsøk på å få tilgang til eFORSK uten å være autentisert og autorisert vil avvises og brukeren videresendes til FALK for pålogging. Alle brukertilganger i systemet er personlige.

eFORSK benytter OIDC for autentisering mot FALK og henter identitet og tilgangsinformasjon derifra, hvor brukeren selv velger enhet og rolle før det gis tilgang til eFORSK. Informasjon om brukerens claims videreformidles så til eFORSK. All informasjonen om brukerrettigheter vil følge alle operasjoner brukeren gjennomfører.

### Tilgangstre {#tilgangstre}

Et register i eFORSK kan definere sitt eget hierarkiske tilgangstre som styrer hvilke data en pålogget bruker har tilgang til. Dette er en nyttig funksjon for multisenterstudier.

### Lagdeling {#lagdeling}

eFORSK har en horisontal og vertikal lagdeling. De horisontale lagene skiller mellom web-laget (det brukeren ser), service-laget (forretningslogikken) og database-laget. Bare web-laget er tilgjengelig for brukerne. De vertikale lagene skiller mellom de ulike registrene i løsningen. All data for et register lagres i registerets egen database og deles ikke med andre registre.

**Kryptering:** Sensitive data som kan brukes for å identifisere en person lagres kryptert i databasen. Hver database (register) har sin egen krypteringsnøkkel. Krypteringsalgoritme som benyttes er AES128 med modus ECB.

### Pseudonymisering {#pseudonymisering}

I eFORSK kan data samles inn på personer fra folkeregisteret via Persontjenesten. Personers identitet er aldri direkte tilgjengelig i eFORSKs database. Ved første gangs oppslag i en persons data opprettes et pseudonym for denne i databasen. Personens fødselsnummer lagres kryptert i en database separert fra de andre opplysningene. Det brukes egne krypteringsnøkler for hvert register. Alle andre personopplysninger lastes ned fra Persontjenesten ved behov — disse lagres ikke. Unntaket er når et register samler inn informasjon om pasienten (kjønn, demografi) på sine skjema. Selve skjemadataene lagres kryptert med overnevnte krypteringsnøkkel.

<hr class="section-divider">

## Logging {#logging}

Logging skal sørge for komplett sporbarhet over hva som har skjedd i applikasjonen og skal ikke inneholde sensitiv data. Det skilles mellom to typer logging:

- **Serverlogger** benyttes for det meste til å logge kjøring av bakgrunnsjobber og feil i applikasjonen. Logger til windows event-log plukkes opp av SPLUNK.
- **Datalogger** benyttes for å logge brukeraktiviteter mot data i applikasjonen og lagrer til databasen.

Det er automatisk loggføring av innloggingsforsøk og endring i studiedata i systemet i tillegg til Audit Trail av studiedata som lagres i databasens tabeller. For hver slik hendelse registreres tidspunkt, operasjonsnavn og om operasjon var mislykket eller vellykket.

<hr class="section-divider">

## Innsyn {#innsyn}

En person skal kunne spørre applikasjonen om den har data om personen, hvilke data, hvem som har behandlet/sett dataene og kunne be om å få seg slettet.

<hr class="section-divider">

## Integrasjoner {#integrasjoner}

### ePROM {#eprom}

Pasientrapporterte resultater (ePROM) inkluderer spørreskjemaer som vurderer helse og livskvalitet fra pasientens perspektiv. eFORSK sender ut pasientskjema til pasientene via ePROM. ePROM-løsningen distribuerer skjemaene via Helsenorge, digital postkasse eller fysisk brev i posten. Pasientens utfylte skjema returneres til eFORSK for dataanalyse.

### Persontjenesten {#persontjenesten}

Persontjenesten er et API for søk etter personer i folkeregisteret. Persontjenesten støtter søk etter personnummer og kombinasjoner av navn og hjemkommune.

eFORSK bruker folkeregisteret som kilde til personinformasjon, for å unngå å lagre mer informasjon om pasienten enn nødvendig. eFORSK lagrer kun en kryptert kopi av pasientens personnummer — all annen personinformasjon lastes ned fra personregisteret ved behov.

<hr class="section-divider">

## Data i applikasjonen {#data}

Forskningsdata som legges inn i systemet registreres med brukernavn og tidspunkt. Alle dataendringer foretatt av brukere er sporbare. Personlige opplysninger om studiedeltagere skal være begrenset til det minimum som er nødvendig for å skille deltagere fra hverandre. Et minimumskrav til identifiseringsinformasjon er unik nøkkel. Studiedeltagerdata for identifikasjon låses med en gang for å unngå ombytting av pasienter.

Randomiseringsresultater er ikke manipulerbare for brukere av systemet uansett studie, men kan omgås ved å opprette skjemaet på nytt (dette logges).

Hvert enkelt prosjekt har sin egen database, men er tilgjengelig gjennom en felles applikasjon. Dette sikrer tilstrekkelig adskillelse av data prosjektene imellom. Hver database har sin egen krypteringsnøkkel. Prosjektet benytter en GUID (Global Unique Identifier) som referanse til forskningsobjektet i stedet for fødselsnummer/ID-nummer.

Hemit har ingen eierrettigheter til data som systemet forvalter.