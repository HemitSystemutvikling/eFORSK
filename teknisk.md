---
layout: teknisk
title: Teknisk løsning
title_en: Technical solution
description: Arkitektur, sikkerhet, logging og integrasjoner i eFORSK
description_en: Architecture, security, logging and integrations in eFORSK
---

<div class="lang-no" markdown="1">

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

</div>

<!-- ═══════════════════════════════════════════════════════════
     ENGLISH VERSION — edit below this line for English content
     ═══════════════════════════════════════════════════════════ -->

<div class="lang-en" markdown="1">

<nav class="toc" aria-label="Page contents">
  <div class="toc-label">Contents</div>
  <ol class="toc-list">
    <li><a href="#arkitektur">Overall architecture</a></li>
    <li><a href="#sikkerhet">Security</a>
      <ol class="toc-sub">
        <li><a href="#autentisering">Authentication, user access and role management</a></li>
        <li><a href="#tilgangstre">Access tree</a></li>
        <li><a href="#lagdeling">Layering and encryption</a></li>
        <li><a href="#pseudonymisering">Pseudonymization</a></li>
      </ol>
    </li>
    <li><a href="#logging">Logging</a></li>
    <li><a href="#innsyn">Right of access</a></li>
    <li><a href="#integrasjoner">Integrations</a>
      <ol class="toc-sub">
        <li><a href="#eprom">ePROM</a></li>
        <li><a href="#persontjenesten">The Person Registry</a></li>
      </ol>
    </li>
    <li><a href="#data">Data in the application</a></li>
  </ol>
</nav>

## Overall architecture

eFORSK has an overall architecture based on the Medical Registry System (MRS), as a three-tier application with a similar security model. The application consists of several databases; a shared Common database, as well as dedicated databases for each individual research project (registry). eFORSK is written in .NET, uses an MS SQL database and is operated on virtual environments at Norsk Helsenett (NHN).

<hr class="section-divider">

## Security

eFORSK has been risk-assessed and all data in the software is processed in accordance with applicable rules for privacy and data security. The software uses secure digital communication through platforms such as Helsenorge and Digipost, and communicates with FALK and ePROM, which — like eFORSK — are built on national infrastructure.

eFORSK is offered as an installation in NHN infrastructure and is available to health trusts and universities with internet as the carrier. The security level is adapted to such exposure — all data and communication is encrypted and strong authentication is performed using HelseID. eFORSK is designed in accordance with the requirements set out in the Norwegian standard for information security in the health and care sector (Normen) and adapted to GDPR requirements.

Backups of the virtual servers are taken before major changes, and database backups are taken every night.

Privacy is maintained at every level and eFORSK has a robust security model suited for handling sensitive personal data. The security model is broadly divided into four parts:

### Authentication, user access and role management

eFORSK uses claims-based authentication where login and assignment of role and rights information is external. This information is used to control which data the user is allowed to see and which operations they are allowed to perform. Attempts to access eFORSK without being authenticated and authorized will be rejected and the user redirected to FALK for login. All user accounts in the system are personal.

eFORSK uses OIDC for authentication against FALK and retrieves identity and access information from there, where the user selects unit and role before being granted access to eFORSK. Information about the user's claims is then passed to eFORSK. All information about user rights will accompany all operations the user performs.

### Access tree

A registry in eFORSK can define its own hierarchical access tree that controls which data a logged-in user has access to. This is a useful feature for multi-centre studies.

### Layering

eFORSK has horizontal and vertical layering. The horizontal layers separate the web layer (what the user sees), the service layer (business logic) and the database layer. Only the web layer is accessible to users. The vertical layers separate the different registries in the solution. All data for a registry is stored in the registry's own database and is not shared with other registries.

**Encryption:** Sensitive data that can be used to identify a person is stored encrypted in the database. Each database (registry) has its own encryption key. The encryption algorithm used is AES128 with ECB mode.

### Pseudonymization

In eFORSK, data can be collected on persons from the national population register via the Person Registry. A person's identity is never directly available in eFORSK's database. The first time a person's data is accessed, a pseudonym is created for that person in the database. The person's national identity number is stored encrypted in a database separated from the other information. Separate encryption keys are used for each registry. All other personal information is downloaded from the Person Registry as needed — it is not stored. The exception is when a registry collects information about the patient (gender, demographics) in its forms. The form data itself is stored encrypted using the above encryption key.

<hr class="section-divider">

## Logging

Logging ensures complete traceability of what has happened in the application and must not contain sensitive data. Two types of logging are distinguished:

- **Server logs** are mainly used to log the execution of background jobs and errors in the application. Logs to the Windows event log are picked up by SPLUNK.
- **Data logs** are used to log user activities against data in the application and are stored in the database.

There is automatic logging of login attempts and changes to study data in the system, in addition to the Audit Trail of study data stored in the database tables. For each such event, the timestamp, operation name and whether the operation was unsuccessful or successful is recorded.

<hr class="section-divider">

## Right of access

A person must be able to query the application about whether it holds data on them, what data, who has processed/viewed the data, and be able to request deletion.

<hr class="section-divider">

## Integrations

### ePROM

Patient-reported outcomes (ePROM) include questionnaires that assess health and quality of life from the patient's perspective. eFORSK sends patient forms to patients via ePROM. The ePROM solution distributes the forms via Helsenorge, secure digital mailbox or physical letter. The patient's completed forms are returned to eFORSK for data analysis.

### Persontjenesten

Persontjenesten is an API for searching for persons in the national population register. It supports searches by national identity number and combinations of name and municipality.

eFORSK uses the population register as the source of personal information, to avoid storing more information about the patient than necessary. eFORSK only stores an encrypted copy of the patient's national identity number — all other personal information is downloaded from the register as needed.

<hr class="section-divider">

## Data in the application

Research data entered into the system is recorded with username and timestamp. All data changes made by users are traceable. Personal information about study participants must be limited to the minimum necessary to distinguish participants from each other. A minimum requirement for identification information is a unique key. Study participant data for identification is locked immediately to prevent patient mix-ups.

Randomization results cannot be manipulated by users of the system regardless of study, but can be circumvented by creating the form again (this is logged).

Each individual project has its own database but is accessible through a shared application. This ensures adequate separation of data between projects. Each database has its own encryption key. The project uses a GUID (Global Unique Identifier) as a reference to the research subject instead of a national identity number.

Hemit holds no ownership rights to the data managed by the system.

</div>
