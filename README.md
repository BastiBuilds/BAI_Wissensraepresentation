# Projektarbeit: Wissensrepräsentation und -verarbeitung

## Überblick

In diesem Projekt geht es darum, die Prinzipien der Wissensrepräsentation und -verarbeitung praktisch anzuwenden. Dazu wird ein Online-Shop analysiert, um dessen Struktur und Geschäftslogik zu verstehen. Ziel ist es, Produkte, Produktkonfigurationen und Geschäftsregeln aus dem Shop zu extrahieren und darzustellen.


## Vorbereitung

### Auswahl des Online-Shops

Für das Projekt wurde der **LEGO Online-Shop** gewählt.

Dieser bietet:

- Eine breite Produktpalette (z. B. Technic, Creator, City, Star Wars etc.)
- Möglichkeiten zur Kategorisierung nach Interessen, Alter, Thema, Preis usw.

---

## Aufgabenstellung

### Aufgabe 1: Entscheidungsmodell

Es soll ein Entscheidungsmodell entwickelt werden, das passende LEGO-Sets für bestimmte Situationen oder Zielgruppen empfiehlt.

Beispiele für Entscheidungssituationen:

- Welches LEGO-Set ist für ein Kind im Alter von 8 Jahren geeignet?
- Welches Set passt zu einem Technik-begeisterten Erwachsenen?
- Welche LEGO-Produktlinie eignet sich als Geschenk für eine kreative Person?

Das Entscheidungsmodell soll mindestens eine **Unterentscheidung** enthalten. Beispiel: Die Alterskategorie wird zuerst bestimmt und dient dann als Eingabe für die Produktempfehlung.

### Aufgabe 2: Kaufberatung in Prolog

Ziel ist die Entwicklung einer Kaufberatung in **Prolog**, basierend auf dem LEGO-Angebot.

Schritte:

- Identifikation typischer Kundenfragen (z. B. "Ich suche ein Set für mein 10-jähriges Kind, das Star Wars mag.")
- Sammlung relevanter Informationen über LEGO-Produkte (Thema, Altersempfehlung, Schwierigkeitsgrad, Preis)
- Definition geeigneter Prädikate und Regeln zur Abbildung von Produktwissen
- Umsetzung einer Prolog-Wissensbasis mit Beispielanfragen

### Aufgabe 3: Wissensgraph

Die Lösung aus Aufgabe 2 wird in einen **Wissensgraphen** überführt.

- Definition eines Schemas für LEGO-Produkte, Zielgruppen, Themenwelten und Eigenschaften (z. B. Alter, Teileanzahl, Schwierigkeitsgrad)
- Implementierung von Regeln in **SWRL**
- Abfragen mit **SQWRL** oder **SPARQL**, z. B. zur Empfehlung passender Sets auf Basis von Interessen und Altersangabe
