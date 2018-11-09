# Informasjonsarkitektur & funksjonalitet

## Hovedgrensesnittet består av følgende deler:

* Header
  * App tittel/logo: eFORSK + registerets tittel
  * Brukerinformasjon (Logget inn som  Test Testersen, Registeransvarlig ved St.Olavs Hospitstal)
  * Logg ut
  * Meny
  * Varlser (både fastlåste, type "du er nå i testmodus..", men også lukkbare meldinger, type "datadump er klar for nedlastning..")
  * Switch for prod/test-modus (bør være tydelig i hvilken modus man jobber. i testmodus kan headerlinja f.eks. få en mørk farge, og  det vises et fastlåst varsel om at man nå jobber i testmodus)
* Innhold
* Footer
  * App versjonsnummer

## Innholdet er delt opp i følgende deler:

* **Startside/Dashboard** 
	* Oppgaveliste
		* registerets ikke ferdigstilte skjema
		* registerets returnerte skjema
		* mine ikke ferdigstilte skjema
		* mine returnerte skjema
	* Enkel statistikk?
	* Snarvei til handlinger man har tilgang til: fylle ut skjema, bestille skjemautfyllelse, finn person i folkereg..
* **Skjemaer** - for å søke opp eller se skjema
	* Fyll ut skjema
	* Bestill skjemautfyllelse (fra person)
	* Mine skjema
	* Skjemasøk
* **Forskningsobjekter**
	* Dasboard
		* Finn person i folkeregisteret (søk fnr el navn/adr)
		* Opprett forskningsobjekt
		* *Opprett person med hjelpenummer*
	* Forskningsobjekter i registeret 
	* Mine forskningsobjekter
	* Forskningsobjektets side
		* informasjon fra folkeregister
		* visning av skjema registrert på person
		* ePROM bestillinger
* **Rapporter**
	* Eksporter data (*Datadump*)
	* Kodebok
	* (..)
* **Registeradministrasjon** 
	* Registeroppsett (Instillinger/valg, registerinformasjon)
	* Tilgangseneheter
	* Skjematyper - utlisting
		* Skjematype - redigering av versjoner. visning av felter og regler
			* Skjemaversjon - redigering av felter og regler
	* ePROM bestillinger
* **Administrasjon** - for å legge til og endre registre
	* Registerliste
		* liste over eksisterende registre
		* mulighet for å opprette nye
 	* Registerredigering
		* tittel
		* ePROM kobling
	* ePROM skjemaer som trenger kvalitetssikring/godkjennelse


## Hjelpefunksjoner

Ved redigering av eksisterende objekter vil applikasjonen sørge for å låse objektet slik at ingen andre brukere kan gjøre dette samtidig.