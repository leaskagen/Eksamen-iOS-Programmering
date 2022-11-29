# Eksamen-PG5601

* Versjon av Xcode: Version 14.0 beta 6
* Versjon av iOS: iOS 16
* Vesjon av Swift: Swift 5

## Oppgave 1

* Frukt blir hentet fra fruityvice gjennom api/fruit/all endepunktet og blir lagret som et Fruit objekt
* Alle Fruit objekter blir sortert i arrayet i stigende rekkefølge etter id
* Fetchen blir gjort i en closure slik at når api kallet er ferdig og all frukten er hentet kan jeg reloade table viewet og vise fram alle Fruit objektene jeg nettopp hentet

### Family farger

Første gangen alle fruktene blir hentet sorterer jeg ut alle de forskjellige familiene, tildeler alle familiene en tilfeldig farge, og lagrer det på en måte som de andre klassene kan bruke.
Alt er dynamisk slik at hvis det skulle bli lagt til nye frukter med nye familier så vil det fortsatt fungere.

* Alle Fruit Families blir tildelt en farge slik at alle frukter i samme family vil ha samme farge
* Family Color er en struct som har både family navnet og en farge
* Family Color blir lagret i et globalt array slik at alle de forskjellige klassene har tilgang på de
* Det globale arrayet er av typen Any fordi det kan ikke være av egendefinert type, derfor har jeg i alle sjekkene mine måtte castet de objektene som Family Color

## Oppgave 2

* Når man trykker på en frukt så vil man komme til en detaljside for den spesifikke frukten hvor alt av informasjon vises, som navn, family, order, genus og alle næringsinnhold
* Toppen har familiefargen som en kul detalj for å gjøre siden mer fargerik og livlig
* Jeg sjekker om sukker er mer enn 10, og hvis den har det vil bakgrunnen for det feltet blinke rødt i tillegg til at det kommer en skriftlig advarsel
* For animasjonen bruker jeg repeterende keyframes som fader mellom systemBackgroundcolor og rød
* Animasjonen blir trigget av en DispatchQueue.main slik at animasjonen starter umiddelbart når viewet blir lastet

## Oppgave 3

* Jeg itererer gjennom hver eneste frukt og sorterer ut alle de forskjellige family, genus og order i hvert sitt array
* CollectionView er delt opp i tre seksjoner, hver gruppe får sin egen seksjon
* Celler for family seksjonen henter navn fra family arrayet, genus sine navn fra genus arrayet osv..
* Hver seksjon har tittel og sin egen cellefarge for et tydelig skille fra hverandre
* For bredden på cellene bruker jeg en UICollectionViewDelegateFlowLayout hvor jeg skriver at bredden skal ta halvparten av plassen, slik at det alltid er to celler på hver rad og de tilpasser seg skjermstørrelsen

* Når man trykker på en celle så kommer man til en liste som ligner på den i oppgave en, bare at den bare viser frukt som er i den gruppen du trykket på
* Når jeg sender APIet sjekker jeg om det er family, genus eller order som er trykket på, og hvilken gruppe under der som er trykket
* I de grupperte listene kan man trykke på en frukt og komme til den samme detaljsiden som fra oppgave 2

## Oppgave 4

### Spis frukt

* Detaljsiden har en knapp som du kan trykke for å spise denne frukten
* Knappen tar deg til en siden hvor det er en datepicker, default verdien i datepicker er dagens dato, men for å endre dato trykker du på den og får en kalender hvor du kan velge dato
* Nederst er det to knapper som er avbryt og lagre
* Trykker man avbryt kommer man tilbake til detaljsiden
* Trykker man lagre blir frukten med valgt dato lagret i core data og man blir tatt tilbake til forsiden som er listen med frukt

### Core Data

* I datamodellen lagrer fruktnavnet som string, dato som date, og alt av næringsinnhold som doubles

### Logg siden

* Logg siden henter ut alle frukter du har spist i et table view
* Fordi fruktene er lagret i core data så er de lagret på telefonen helt til man sletter appen eller tilbakestiller telefonen
* Hver dag får sin egen seksjon med datoen som header, frukt som ble spist den dagen, og alle næringsinnhold oppsummert
* Dagene er sortert i stigende rekkefølge (tidligste datoen først)
* Datoer blir konvertert fra date til string i formattet "Mandag 31. Nov 2022"

## Oppgave 5

* Når man går inn på detaljsiden sjekker jeg i core data om det er frukt objekter med samme navn der
* Hvis den fant frukt av samme navn så fjerner jeg alle frukter som er eldre enn 30 dager fra i dag
* Hvis det er spist frukt av denne typen i løpet av de siste 30 dagene lager jeg frukt confetti

### Fruit Confetti

* For hver frukt blir det laget en label med emoji
* Jeg gjør en sjekk mot alle fruktene som jeg fant en emoji for, de fruktene som ikke har en emoji får en default emoji
* Frukten blir plassert på et tilfeldig sted i X aksen
* Animasjonen blir gjort med keyframes, likt som i oppgave 2
* Den første keyframen scaler jeg frukter til 2x slik at den er på sitt største når den faller fra toppen, og blir mindre etterhvert som den faller
* Den andre keyframen bruker jeg translate til å flytte frukten ned og ut av skjermen, og rotate slik at frukten faller så vidt til høyre eller venstre
* Delay, rotation og varighet på animasjonen er tilfeldig for hver frukt slik at ingen faller likt
* Animasjonen kan spilles av på nytt så mange ganger som brukeren ønsker med en knapp nederst
