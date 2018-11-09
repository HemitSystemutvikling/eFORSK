# Forskningsobjekter

Et skjema må registreres på et forskningsobjekt. Forskningsobjektene er kategorisert i typer. Som standard tilbyr eFORSK typen "Folkeregisteret" som gir personer fra folkeregisteret. I tillegg kan registre legge til sine egne typer, for eksempel legemidler, avdelinger, anonyme personer osv. På disse egenlagde typene må hvert forskningsobjekt registreres med en unik ID og et navn.

Når man lager en skjematype må man velge hvilken forskningsobjekttype som skjemaet er koblet til. Dette kan ikke endres i ettertid. Alle underskjema av skjematypen er låst til samme forskningsobjekttypen som hovedskjemaet.

Merk at kun skjematyper med forskningsobjekttypen "Folkeregisteret" kan kobles mot ePROM.

## Samtykkehåndtering

Gjelder kun for forskningsobjekt: personer.

Samtykket tilhører personen i registeret. Informasjonen ligger globalt, og gjelder alle skjema registrert på personen uansett enhet. Samtykket er altså det samme på tvers av alle enheter, og alle enheter kan oppdatere samtykket. 

Konfigurasjon av registeret bestemmer hva som er personens standard samtykke-nivå ved opprettelse. 

### Samtykkenivåer

1. **Samtykke foreligger ikke** - man kan ikke registrere data på personen. data allerede registrert på person blir slettet når dette samtykkenivået settes?
2. **Forespurt** - avventer svar. kan løpe ut på tid
3. **Samtykket for registeret** (lokalt samtykke - bedre navn?) - data registrert blir kun synlig på den enheten det er registrert


### Samtykkekonfigurasjon

Hvert register kan konfigureres til å bruke en av følgende samtykkekonfigurasjoner:
1. samtykke håndteres utenfor registeret - man får da ikke spørsmål om samtykke ved registrering i registeret. Standard samtykkenivå for pasienten er da nivå **3**. Samtykke kan manuelt endres på pasienten.
2. samtykke håndteres med spørsmål til registrar i registeret - registrar må velge samtykkenivå ved opprettelse av første skjema på personen om dette allerede ikke er gjort. Det er mulighet for å gå inn på personen og gi/endre samtykke når som helst. Det er ikke mulig å opprette skjema på pasient før samtykkenivå er 3.
3. samtykke bestilles fra personen via PROMS, der et standard samtykkeskjema sendes ut fra registeret. Det vil finnes en knapp for å bestille dette på personens side i registeret, eller ved forsøk på å opprette skjema der samtykke ikke foreligger.
5. Kombinasjon av **2 og 3**. Registrar kan både gi samtykke manuelt eller ved å bestille fra PROMS.

I tilfelle 1 eller 2 må administrator oppgi grunn til at samtykke håndteres utenfor registeret.

### Samtykke bestilling ePROM

Bestill papir hvis ikke digitalt svar

### Innsyn

Todo
