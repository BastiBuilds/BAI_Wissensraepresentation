% LEGO Empfehlungssystem in Prolog

% ---Datentypen---

% t_Alter: 1.5 bis 100 Jahre
alter(Alter) :- Alter >= 1.5, Alter =< 100.

% t_Preisbereich: 20 bis 1000
preis(Preis) :- Preis >= 20, Preis =< 1000.

% Soll kompatibel sein mit weiteren Sets: true/false
kompatibel(true).
kompatibel(false).

% t_Bautechnik
bautechnik("Anleitung").
bautechnik("Eigenkreation").
bautechnik("Modular").
   
% t_AnzahlgebauteLegosets: 0 bis 1000
anzahl_gebaute_legosets(Anzahl) :- Anzahl >= 0, Anzahl =< 1000.

% t_Bauteilmenge: 0 bis 12000
bauteilmenge(Menge) :- Menge >= 0, Menge =< 12000.

% Bauzeit in h: 1 bis 20
bauzeit(Zeit) :- Zeit >= 1, Zeit =< 20.

% Komplexe Bausteine: true/false
komplexe_bausteine(true).
komplexe_bausteine(false).

% Soll Lizenz haben: true/false
soll_lizenz_haben(true).
soll_lizenz_haben(false).

% Zielgruppe
zielgruppe("Kleinkinder").
zielgruppe("Kinder - Einsteiger").
zielgruppe("Kinder - Fortgeschritten").
zielgruppe("Jugendliche - Einsteiger"). 
zielgruppe("Jugendliche - Fortgeschritten").
zielgruppe("Erwachsene - Einsteiger").
zielgruppe("Erwachsene - Fortgeschritten").
zielgruppe("Erwachsene - Expert").

% Erfahrung
erfahrung("Anfänger").
erfahrung("Fortgeschritten").
erfahrung("Expert").

% Schwierigkeitsgrad
schwierigkeitsgrad("Einfach").
schwierigkeitsgrad("Mittel").
schwierigkeitsgrad("Schwer").

% Themenwelt
themenwelt("Disney").
themenwelt("Marvel"). 
themenwelt("Harry Potter"). 
themenwelt("Ninjago").
themenwelt("Star Wars").
themenwelt("Minecraft").
themenwelt("City"). 
themenwelt("Technik").
themenwelt("Architektur").
themenwelt("Friends"). 
themenwelt("Creator").
themenwelt("Classic").

% Interessen
interessen("Fahrzeuge").
interessen("Disney").
interessen("Superheroes").
interessen("Architektur").
interessen("Sci-Fi").
interessen("Kinderserie / Film").
interessen("Ninjas").
interessen("Gaming").
interessen("Sport").
interessen("Tier/Natur").
interessen("Abenteuer").
interessen("Historische Epochen").
interessen("Fantasy").
interessen("Simples Spielen").   

% LEGO Sets
lego_set("Kreativer Reisekoffer").
lego_set("Hogwarts Express & der Bahnhof von Hogsmeade").
lego_set("Imperialer Sternzerstörer").
lego_set("Donut Truck").
lego_set("Abenteuer - Wohnmobil").
lego_set("Spinjitzu-Tempel der Ninja").
lego_set("Hinterhalt auf Mandalore Battle Pack").
lego_set("Ducati Panigale V4 S Motorrad").
lego_set("Ferrari Daytona SP3").
lego_set("NASA Artemis Startrampe").
lego_set("Grosse interaktive Eisenbahn").
lego_set("3-in-1-Zauberschloss").
lego_set("Paisleys Haus").
lego_set("Bunte Bausteine-Box").
lego_set("Der Sprechende Hut").
lego_set("Minecraft Mini-Höhle").
lego_set("Mein erster Bauernhof").
lego_set("Die Milchstrassen-Galaxie").
lego_set("Titanic").
lego_set("Schloss Hogwarts mit Schlossgelände").
lego_set("McLaren P1").
lego_set("Schloss Hogwarts").
lego_set("Invisible Hand").
lego_set("Die Werkbank").
lego_set("Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern").
lego_set("Trevi-Brunnen").
lego_set("Darth Vader Helm").
lego_set("NINJAGO City Werkstätten").
lego_set("MARVEL Logo & Minifiguren").
lego_set("New York City").
lego_set("London").
lego_set("Schloss Hogwarts: Die Grosse Halle"). 
lego_set("R2-D2").
lego_set("Fast and Furious Toyota Supra MK4"). 
lego_set("Wilde Tiere: Rosa Flamingo").
lego_set("Wilde Tiere: Pandafamilie").
lego_set("Ultimatives Abenteuerschloss").
lego_set("Geschäft für Haustierzubehör").
lego_set("Simba").
lego_set("das Löwenjunge des Königs").
lego_set("X-Men: X-Mansion").
lego_set("Avengers Tower").
lego_set("New York City").
lego_set("Obi-Wan Kenobis Jedi Startfighter").
lego_set("Darth Mauls Sith Infiltrator").
lego_set("Spinjitzu-Tempel der Ninja").
lego_set("Lloyds und Arins Training-Mechs").

% ---Entscheidungslogik ---

% Zielgruppe
%erfahrung durch input param ersetzen
% Zielgruppe-Empfehlung basierend auf Alter & Erfahrung

zielgruppe_empfehlung(Alter, Erfahrung, "Kleinkinder") :-
    Alter < 4,
    (Erfahrung = "Anfänger"; Erfahrung = "Fortgeschritten"; Erfahrung = "Expert").
zielgruppe_empfehlung(Alter, "Anfänger", "Kinder - Einsteiger") :-
    Alter >= 4, Alter =< 12.
zielgruppe_empfehlung(Alter, Erfahrung, "Kinder - Fortgeschritten") :-
    Alter >= 4, Alter =< 12,
    (Erfahrung = "Fortgeschritten"; Erfahrung = "Expert").
zielgruppe_empfehlung(Alter, "Anfänger", "Jugendliche - Einsteiger") :-
    Alter > 12, Alter =< 18.
zielgruppe_empfehlung(Alter, Erfahrung, "Jugendliche - Fortgeschritten") :-
    Alter > 12, Alter =< 18,
    (Erfahrung = "Fortgeschritten"; Erfahrung = "Expert").
zielgruppe_empfehlung(Alter, "Anfänger", "Erwachsene - Einsteiger") :-
    Alter >= 18.
zielgruppe_empfehlung(Alter, "Fortgeschritten", "Erwachsene - Fortgeschritten") :-
    Alter >= 18.
zielgruppe_empfehlung(Alter, "Expert", "Erwachsene - Experte") :-
    Alter >= 18.

empfehle_zielgruppe(Alter, Erfahrung, Zielgruppe) :-
    alter(Alter),
    erfahrung(Erfahrung),
    zielgruppe_empfehlung(Alter, Erfahrung, Zielgruppe),
    zielgruppe(Zielgruppe).


% Erfahrung
% erfahrung(Bautechniken, AnzahlGebaut, Erfahrung)
%bautechnikfixwerte ersetzen durch input params

erfahrung_empfehlung(Bautechnkik, AnzahlGebaut, "Anfänger") :- 
    AnzahlGebaut =< 5.
erfahrung_empfehlung(Bautechniken, AnzahlGebaut, "Anfänger") :-
    AnzahlGebaut =< 5,
    (member("Anleitung", Bautechniken); member("Modular", Bautechniken)).
erfahrung_empfehlung(Bautechniken, AnzahlGebaut, "Fortgeschritten") :-
    AnzahlGebaut > 15, AnzahlGebaut =< 25,
    (member("Anleitung", Bautechniken); member("Eigenkreation", Bautechniken)).
erfahrung_empfehlung(Bautechniken, AnzahlGebaut, "Fortgeschritten") :-
    AnzahlGebaut =< 5,
    member("Eigenkreation", Bautechniken).
erfahrung_empfehlung(Bautechniken, AnzahlGebaut, "Fortgeschritten") :-
    AnzahlGebaut > 5, AnzahlGebaut =< 15,
    (member("Anleitung", Bautechniken);
     member("Modular", Bautechniken);
     member("Eigenkreation", Bautechniken)).
erfahrung_empfehlung(Bautechniken, AnzahlGebaut, "Expert") :-
    AnzahlGebaut > 15, AnzahlGebaut =< 25,
    (member("Modular", Bautechniken); member("Eigenkreation", Bautechniken)).
erfahrung_empfehlung(Bautechniken, AnzahlGebaut, "Expert") :-
    AnzahlGebaut > 25,
    member("Anleitung", Bautechniken),
    member("Modular", Bautechniken),
    member("Eigenkreation", Bautechniken).

empfehle_erfahrung(Bautechniken, AnzahlGebaut, Erfahrung) :-
    anzahl_gebaute_legosets(AnzahlGebaut),
    erfahrung_empfehlung(Bautechniken, AnzahlGebaut, Erfahrung),
    erfahrung(Erfahrung).

    
% Schwierigkeitsgrad: Bauteilmenge, Bauzeit in h, Komplexe Bausteine
schwierigkeitsgrad(Bauteilmenge, BauzeitStd, false, "Einfach") :- Bauteilmenge=<1500, BauzeitStd=<2.
schwierigkeitsgrad(Bauteilmenge, BauzeitStd, false, "Mittel") :- Bauteilmenge=<500, BauzeitStd>2.
schwierigkeitsgrad(Bauteilmenge, BauzeitStd, true, "Mittel") :- Bauteilmenge=<1500, BauzeitStd>=1, BauzeitStd<=5.
schwierigkeitsgrad(Bauteilmenge, BauzeitStd, false, "Mittel") :- Bauteilmenge>=500, BauzeitStd>=2, BauzeitStd<=5.
schwierigkeitsgrad(Bauteilmenge, BauzeitStd, true, "Mittel") :- Bauteilmenge>1500, BauzeitStd>=1, BauzeitStd<=5.
schwierigkeitsgrad(Bauteilmenge, BauzeitStd, false, "Schwer") :- Bauteilmenge=>500, BauzeitStd>5.
schwierigkeitsgrad(_, BauzeitStd, true, "Schwer") :- BauzeitStd>5.

 

% Themenwelt
themenwelt_empfehlung("Fahrzeuge", false, "Technik").
themenwelt_empfehlung("Fahrzeuge", true,  "Star Wars").
themenwelt_empfehlung("Disney", false, "Friends").
themenwelt_empfehlung("Disney", true,  "Disney").
themenwelt_empfehlung("Superheroes", false, "Ninjago").
themenwelt_empfehlung("Superheroes", true,  "Marvel").
themenwelt_empfehlung("Architektur", false, "Architektur").
themenwelt_empfehlung("Architektur", true,  "Harry Potter").
themenwelt_empfehlung("Sci-Fi", false, "Ninjago").
themenwelt_empfehlung("Sci-Fi", true,  "Star Wars").
themenwelt_empfehlung("Kinderserie / Film", false, "Ninjago").
themenwelt_empfehlung("Kinderserie / Film", true,  "Disney").
themenwelt_empfehlung("Ninjas", _, "Ninjago").
themenwelt_empfehlung("Gaming", false, "Creator").
themenwelt_empfehlung("Gaming", true, "Minecraft").
themenwelt_empfehlung("Sport", _, "City").
themenwelt_empfehlung("Tier/Natur", false, "Friends").
themenwelt_empfehlung("Tier/Natur", true, "Minecraft").
themenwelt_empfehlung("Abenteuer", false, "Ninjago").
themenwelt_empfehlung("Abenteuer", true, "Star Wars").
themenwelt_empfehlung("Historische Epochen", false, "Architektur").
themenwelt_empfehlung("Historische Epochen", true, "Disney").
themenwelt_empfehlung("Fantasy", false, "Ninjago").
themenwelt_empfehlung("Fantasy", true, "Harry Potter").
themenwelt_empfehlung("Simples Spielen", _, "Classic").

empfehle_themenwelt(Interesse, Lizenz, Empfohlen) :-
    interessen(Interesse),
    soll_lizenz_haben(Lizenz),

    % Anhand von Interesse und Lizenzstatus gibts die jeweilige Empfehlung
    themenwelt_empfehlung(Interesse, Lizenz, Empfohlen),
    themenwelt(Empfohlen).

% ---Hauptprogramm (Lego Set Evaluation)---
%Alle Abfrfragen von stimmenden input params
empfehle_lego_set(
    Alter, Bautechniken, AnzahlGebaut,
    Interesse, Lizenz,
    Bauteilmenge, Bauzeit, Komplex,
    Kompatibel, Preis,
    Set
) :-

    % Validierung
    alter(Alter),
    anzahl_gebaute_legosets(AnzahlGebaut),
    bauteilmenge(Bauteilmenge),
    bauzeit(Bauzeit),
    kompatibel(Kompatibel),
    preis(Preis),

    % Subentscheidungen
    empfehle_erfahrung(Bautechniken, AnzahlGebaut, Erfahrung),
    empfehle_zielgruppe(Alter, Erfahrung, Zielgruppe),
    schwierigkeitsgrad(Bauteilmenge, Bauzeit, Komplex, Schwierigkeitsgrad),
    empfehle_themenwelt(Interesse, Lizenz, Themenwelt),

    % Endentscheidung: Set finden
    passendes_lego_set(Zielgruppe, Schwierigkeitsgrad, Themenwelt, Kompatibel, Preis, Set).
