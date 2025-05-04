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
bautechnik('Anleitung').
bautechnik('Eigenkreation').
bautechnik('Modular').
   
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
zielgruppe('Kleinkinder').
zielgruppe('Kinder - Einsteiger').
zielgruppe('Kinder - Fortgeschritten').
zielgruppe('Jugendliche - Einsteiger'). 
zielgruppe('Jugendliche - Fortgeschritten').
zielgruppe('Erwachsene - Einsteiger').
zielgruppe('Erwachsene - Fortgeschritten').
zielgruppe('Erwachsene - Expert').

% Erfahrung
erfahrung('Anfänger').
erfahrung('Fortgeschritten').
erfahrung('Expert').

% Schwierigkeitsgrad
schwierigkeitsgrad('Einfach').
schwierigkeitsgrad('Mittel').
schwierigkeitsgrad('Schwer').

% Themenwelt
themenwelt('Disney').
themenwelt('Marvel'). 
themenwelt('Harry Potter'). 
themenwelt('Ninjago').
themenwelt('Star Wars').
themenwelt('Minecraft').
themenwelt('City'). 
themenwelt('Technik').
themenwelt('Architektur').
themenwelt('Friends'). 
themenwelt('Creator').
themenwelt('Classic').

% Interessen
interessen('Fahrzeuge').
interessen('Disney').
interessen('Superheroes').
interessen('Architektur').
interessen('Sci-Fi').
interessen('Kinderserie / Film').
interessen('Ninjas').
interessen('Gaming').
interessen('Sport').
interessen('Tier/Natur').
interessen('Abenteuer').
interessen('Historische Epochen').
interessen('Fantasy').
interessen('Simples Spielen').   

% LEGO Sets
lego_set('Kreativer Reisekoffer').
lego_set('Hogwarts Express & der Bahnhof von Hogsmeade').
lego_set('Imperialer Sternzerstörer').
lego_set('Donut Truck').
lego_set('Abenteuer - Wohnmobil').
lego_set('Spinjitzu-Tempel der Ninja').
lego_set('Hinterhalt auf Mandalore Battle Pack').
lego_set('Ducati Panigale V4 S Motorrad').
lego_set('Ferrari Daytona SP3').
lego_set('NASA Artemis Startrampe').
lego_set('Grosse interaktive Eisenbahn').
lego_set('3-in-1-Zauberschloss').
lego_set('Paisleys Haus').
lego_set('Bunte Bausteine-Box').
lego_set('Der Sprechende Hut').
lego_set('Minecraft Mini-Höhle').
lego_set('Mein erster Bauernhof').
lego_set('Die Milchstrassen-Galaxie').
lego_set('Titanic').
lego_set('Schloss Hogwarts mit Schlossgelände').
lego_set('McLaren P1').
lego_set('Schloss Hogwarts').
lego_set('Invisible Hand').
lego_set('Die Werkbank').
lego_set('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern').
lego_set('Trevi-Brunnen').
lego_set('Darth Vader Helm').
lego_set('NINJAGO City Werkstätten').
lego_set('MARVEL Logo & Minifiguren').
lego_set('New York City').
lego_set('London').
lego_set('Schloss Hogwarts: Die Grosse Halle'). 
lego_set('R2-D2').
lego_set('Fast and Furious Toyota Supra MK4'). 
lego_set('Wilde Tiere: Rosa Flamingo').
lego_set('Wilde Tiere: Pandafamilie').
lego_set('Ultimatives Abenteuerschloss').
lego_set('Geschäft für Haustierzubehör').
lego_set('Simba').
lego_set('das Löwenjunge des Königs').
lego_set('X-Men: X-Mansion').
lego_set('Avengers Tower').
lego_set('New York City').
lego_set('Obi-Wan Kenobis Jedi Startfighter').
lego_set('Darth Mauls Sith Infiltrator').
lego_set('Spinjitzu-Tempel der Ninja').
lego_set('Lloyds und Arins Training-Mechs').

% ---Entscheidungslogik ---

% Zielgruppe
zielgruppe_empfehlung(Alter, Erfahrung, 'Kleinkinder') :-
    Alter < 4,
    (Erfahrung = 'Anfänger'; Erfahrung = 'Fortgeschritten'; Erfahrung = 'Expert').
zielgruppe_empfehlung(Alter, 'Anfänger', 'Kinder - Einsteiger') :-
    Alter >= 4, Alter =< 12.
zielgruppe_empfehlung(Alter, Erfahrung, 'Kinder - Fortgeschritten') :-
    Alter >= 4, Alter =< 12,
    (Erfahrung = 'Fortgeschritten'; Erfahrung = 'Expert').
zielgruppe_empfehlung(Alter, 'Anfänger', 'Jugendliche - Einsteiger') :-
    Alter > 12, Alter =< 18.
zielgruppe_empfehlung(Alter, Erfahrung, 'Jugendliche - Fortgeschritten') :-
    Alter > 12, Alter =< 18,
    (Erfahrung = 'Fortgeschritten'; Erfahrung = 'Expert').
zielgruppe_empfehlung(Alter, 'Anfänger', 'Erwachsene - Einsteiger') :-
    Alter >= 18.
zielgruppe_empfehlung(Alter, 'Fortgeschritten', 'Erwachsene - Fortgeschritten') :-
    Alter >= 18.
zielgruppe_empfehlung(Alter, 'Expert', 'Erwachsene - Experte') :-
    Alter >= 18.

empfehle_zielgruppe(Alter, Erfahrung, Zielgruppe) :-
    zielgruppe_empfehlung(Alter, Erfahrung, Zielgruppe).

% Erfahrung
% erfahrung(Bautechniken, AnzahlGebaut, Erfahrung)
erfahrung_empfehlung(Bautechniken, AnzahlGebaut, 'Anfänger') :-
    AnzahlGebaut =< 5,
    (member('Anleitung', Bautechniken); member('Modular', Bautechniken)).
erfahrung_empfehlung(Bautechniken, AnzahlGebaut, 'Fortgeschritten') :-
    AnzahlGebaut > 15, AnzahlGebaut =< 25,
    (member('Anleitung', Bautechniken); member('Eigenkreation', Bautechniken)).
erfahrung_empfehlung(Bautechniken, AnzahlGebaut, 'Fortgeschritten') :-
    AnzahlGebaut =< 5,
    member('Eigenkreation', Bautechniken).
erfahrung_empfehlung(Bautechniken, AnzahlGebaut, 'Fortgeschritten') :-
    AnzahlGebaut > 5, AnzahlGebaut =< 15,
    (member('Anleitung', Bautechniken);
     member('Modular', Bautechniken);
     member('Eigenkreation', Bautechniken)).
erfahrung_empfehlung(Bautechniken, AnzahlGebaut, 'Expert') :-
    AnzahlGebaut > 15, AnzahlGebaut =< 25,
    (member('Modular', Bautechniken); member('Eigenkreation', Bautechniken)).
erfahrung_empfehlung(Bautechniken, AnzahlGebaut, 'Expert') :-
    AnzahlGebaut > 25,
    member('Anleitung', Bautechniken),
    member('Modular', Bautechniken),
    member('Eigenkreation', Bautechniken).

empfehle_erfahrung(Bautechniken, AnzahlGebaut, Erfahrung) :-
    erfahrung_empfehlung(Bautechniken, AnzahlGebaut, Erfahrung).

    
% Schwierigkeitsgrad: Bauteilmenge, Bauzeit in h, Komplexe Bausteine
schwierigkeitsgrad(Bauteilmenge, BauzeitStd, false, 'Einfach') :- Bauteilmenge=<1500, BauzeitStd=<2.
schwierigkeitsgrad(Bauteilmenge, BauzeitStd, false, 'Mittel') :- Bauteilmenge=<500, BauzeitStd>2.
schwierigkeitsgrad(Bauteilmenge, BauzeitStd, true, 'Mittel') :- Bauteilmenge=<1500, BauzeitStd>=1, BauzeitStd=<5.
schwierigkeitsgrad(Bauteilmenge, BauzeitStd, false, 'Mittel') :- Bauteilmenge>=500, BauzeitStd>=2, BauzeitStd=<5.
schwierigkeitsgrad(Bauteilmenge, BauzeitStd, true, 'Mittel') :- Bauteilmenge>1500, BauzeitStd>=1, BauzeitStd=<5.
schwierigkeitsgrad(Bauteilmenge, BauzeitStd, false, 'Schwer') :- Bauteilmenge >= 500, BauzeitStd > 5.
schwierigkeitsgrad(_, BauzeitStd, true, 'Schwer') :- BauzeitStd>5.


% Themenwelt
themenwelt_empfehlung('Fahrzeuge', false, 'Technik').
themenwelt_empfehlung('Fahrzeuge', true,  'Star Wars').
themenwelt_empfehlung('Disney', false, 'Friends').
themenwelt_empfehlung('Disney', true,  'Disney').
themenwelt_empfehlung('Superheroes', false, 'Ninjago').
themenwelt_empfehlung('Superheroes', true,  'Marvel').
themenwelt_empfehlung('Architektur', false, 'Architektur').
themenwelt_empfehlung('Architektur', true,  'Harry Potter').
themenwelt_empfehlung('Sci-Fi', false, 'Ninjago').
themenwelt_empfehlung('Sci-Fi', true,  'Star Wars').
themenwelt_empfehlung('Kinderserie / Film', false, 'Ninjago').
themenwelt_empfehlung('Kinderserie / Film', true,  'Disney').
themenwelt_empfehlung('Ninjas', _, 'Ninjago').
themenwelt_empfehlung('Gaming', false, 'Creator').
themenwelt_empfehlung('Gaming', true, 'Minecraft').
themenwelt_empfehlung('Sport', _, 'City').
themenwelt_empfehlung('Tier/Natur', false, 'Friends').
themenwelt_empfehlung('Tier/Natur', true, 'Minecraft').
themenwelt_empfehlung('Abenteuer', false, 'Ninjago').
themenwelt_empfehlung('Abenteuer', true, 'Star Wars').
themenwelt_empfehlung('Historische Epochen', false, 'Architektur').
themenwelt_empfehlung('Historische Epochen', true, 'Disney').
themenwelt_empfehlung('Fantasy', false, 'Ninjago').
themenwelt_empfehlung('Fantasy', true, 'Harry Potter').
themenwelt_empfehlung('Simples Spielen', _, 'Classic').

empfehle_themenwelt(Interesse, Lizenz, Empfohlen) :-
    themenwelt_empfehlung(Interesse, Lizenz, Empfohlen).

% ---Hauptprogramm (Lego Set Evaluation)---

% lego_set_empfehlung(Zielgruppe, Themenwelt, Preisbereich, Kompatibel, Schwierigkeit, LegoSet).
lego_set_empfehlung('Kleinkinder','City',preisbereich(20,50),true,'Einfach','Abenteuer - Wohnmobil').
lego_set_empfehlung('Kleinkinder','Classic',preisbereich(20,50),true,'Einfach','Mein erster Bauernhof').
lego_set_empfehlung('Kleinkinder','Disney',preisbereich(20,50),false,'Einfach','3-in-1-Zauberschloss').
lego_set_empfehlung('Kleinkinder',_,preisbereich(51,200),true,'Einfach','Grosse interaktive Eisenbahn').
lego_set_empfehlung('Kleinkinder','Classic',preisbereich(51,200),true,'Einfach','Grosse interaktive Eisenbahn').
lego_set_empfehlung(['Kleinkinder','Kinder - Einsteiger'],'Ninjago',preisbereich(20,50),true,['Einfach','Mittel'],'Spinjitzu-Tempel der Ninja').
lego_set_empfehlung('Kinder - Einsteiger','Creator',preisbereich(20,50),true,'Einfach','Kreativer Reisekoffer').
lego_set_empfehlung('Kinder - Einsteiger','Minecraft',preisbereich(20,50),true,'Einfach','Minecraft Mini-Höhle').
lego_set_empfehlung('Kinder - Einsteiger','Friends',preisbereich(20,50),true,'Einfach','Kreativer Reisekoffer').
lego_set_empfehlung('Kinder - Einsteiger',_,preisbereich(51,200),true,'Einfach','Donut Truck').
lego_set_empfehlung('Kinder - Einsteiger','Friends',preisbereich(51,200),true,'Einfach','Paisleys Haus').
lego_set_empfehlung('Kinder - Einsteiger','City',preisbereich(51,200),true,'Einfach','Donut Truck').
lego_set_empfehlung('Kinder - Einsteiger','Classic',preisbereich(51,200),true,'Einfach','Bunte Bausteine-Box').
lego_set_empfehlung('Kinder - Einsteiger','Star Wars',preisbereich(20,50),true,'Einfach','Bunte Bausteine-Box').
lego_set_empfehlung(['Kinder - Einsteiger','Kinder - Fortgeschritten'],'Ninjago',preisbereich(50,101),true,['Einfach','Mittel'],'Lloyds und Arins Training-Mechs').
lego_set_empfehlung('Kinder - Fortgeschritten',_,preisbereich(20,50),true,'Einfach','Obi-Wan Kenobis Jedi Startfighter').
lego_set_empfehlung('Kinder - Fortgeschritten','Friends',preisbereich(20,50),true,'Einfach','Geschäft für Haustierzubehör').
lego_set_empfehlung('Kinder - Fortgeschritten','Creator',preisbereich(51,100),true,'Mittel','Wilde Tiere: Pandafamilie').
lego_set_empfehlung('Kinder - Fortgeschritten','Disney',preisbereich(101,200),true,'Mittel','Ultimatives Abenteuerschloss').
lego_set_empfehlung('Kinder - Fortgeschritten','Harry Potter',preisbereich(201,500),true,'Schwer','Schloss Hogwarts: Die Große Halle').
lego_set_empfehlung(['Kinder - Fortgeschritten','Jugendliche - Einsteiger'],'Architektur',preisbereich(20,100),true,'Schwer','New York City').
lego_set_empfehlung(['Kinder - Einsteiger','Jugendliche - Einsteiger'],'Star Wars',preisbereich(51,100),true,['Einfach','Mittel'],'Darth Mauls Sith Infiltrator').
lego_set_empfehlung('Jugendliche - Einsteiger',_,preisbereich(20,500),true,'Einfach','Trevi-Brunnen').
lego_set_empfehlung('Jugendliche - Einsteiger','Creator',preisbereich(20,50),true,'Einfach','Wilde Tiere: Rosa Flamingo').
lego_set_empfehlung('Jugendliche - Einsteiger','Technik',preisbereich(51,100),true,'Einfach','Fast and Furious Toyota Supra MK4').
lego_set_empfehlung('Jugendliche - Einsteiger','Star Wars',preisbereich(101,200),true,'Einfach','R2-D2').
lego_set_empfehlung('Jugendliche - Einsteiger','Harry Potter',preisbereich(201,500),true,'Mittel','Schloss Hogwarts: Die Große Halle').
lego_set_empfehlung('Jugendliche - Fortgeschritten','Marvel',preisbereich(20,500),false,'Mittel','MARVEL Logo & Minifiguren').
lego_set_empfehlung('Jugendliche - Fortgeschritten','Architektur',preisbereich(20,50),false,'Einfach','London').
lego_set_empfehlung('Jugendliche - Fortgeschritten','Architektur',preisbereich(51,100),false,'Mittel','New York City').
lego_set_empfehlung('Jugendliche - Fortgeschritten','Marvel',preisbereich(101,200),false,'Mittel','MARVEL Logo & Minifiguren').
lego_set_empfehlung('Jugendliche - Fortgeschritten','Ninjago',preisbereich(201,500),false,'Schwer','NINJAGO City Werkstätten').
lego_set_empfehlung('Erwachsene - Einsteiger',_,preisbereich(51,500),false,'Einfach','Darth Vader Helm').
lego_set_empfehlung('Erwachsene - Einsteiger','Star Wars',preisbereich(51,100),true,'Mittel','Invisible Hand').
lego_set_empfehlung('Erwachsene - Einsteiger','Minecraft',preisbereich(101,200),true,'Mittel','Die Werkbank').
lego_set_empfehlung('Erwachsene - Einsteiger','Disney',preisbereich(201,500),false,'Mittel','Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern').
lego_set_empfehlung('Erwachsene - Fortgeschritten',_,preisbereich(51,1000),false,'Mittel','Trevi-Brunnen').
lego_set_empfehlung('Erwachsene - Fortgeschritten','Harry Potter',preisbereich(51,100),false,'Mittel','Der Sprechende Hut').
lego_set_empfehlung('Erwachsene - Fortgeschritten','Technik',preisbereich(101,200),false,'Mittel','Ducati Panigale V4 S Motorrad').
lego_set_empfehlung('Erwachsene - Fortgeschritten','Technik',preisbereich(201,500),false,'Schwer','McLaren P1').
lego_set_empfehlung('Erwachsene - Fortgeschritten','Marvel',preisbereich(201,500),true,'Schwer','X-Men: X-Mansion').
lego_set_empfehlung('Erwachsene - Fortgeschritten','Harry Potter',preisbereich(501,1000),false,'Schwer','Schloss Hogwarts').
lego_set_empfehlung('Erwachsene - Experte',_,preisbereich(101,1000),false,'Mittel','Die Milchstraßen-Galaxie').
lego_set_empfehlung('Erwachsene - Experte','Harry Potter',preisbereich(101,200),false,'Mittel','Schloss Hogwarts mit Schlossgelände').
lego_set_empfehlung('Erwachsene - Experte','Technik',preisbereich(201,500),false,'Schwer','Ferrari Daytona SP3').
lego_set_empfehlung('Erwachsene - Experte','Creator',preisbereich(501,1000),false,'Schwer','Titanic').
lego_set_empfehlung('Erwachsene - Experte','Marvel',preisbereich(501,1000),true,'Schwer','Avengers Tower').
lego_set_empfehlung('Kleinkinder',_,_,_,_,'Mein erster Bauernhof').
lego_set_empfehlung('Kinder - Einsteiger',_,_,_,_,'Kreativer Reisekoffer').
lego_set_empfehlung('Kinder - Fortgeschritten',_,_,_,_,'Schloss Hogwarts mit Schlossgelände').
lego_set_empfehlung('Jugendliche - Einsteiger',_,_,_,_,'R2-D2').
lego_set_empfehlung('Jugendliche - Fortgeschritten',_,_,_,_,'NINJAGO City Werkstätten').
lego_set_empfehlung('Erwachsene - Einsteiger',_,_,_,_,'Die Werkbank').
lego_set_empfehlung('Erwachsene - Fortgeschritten',_,_,_,_,'X-Men: X-Mansion').
lego_set_empfehlung('Erwachsene - Expert',_,_,_,_,'Titanic').

preis_im_bereich(Preis, preisbereich(20,50))   :- Preis >= 20,  Preis =< 50.
preis_im_bereich(Preis, preisbereich(51,200))  :- Preis >= 51,  Preis =< 200.
preis_im_bereich(Preis, preisbereich(201,500)) :- Preis >= 201, Preis =< 500.
preis_im_bereich(Preis, preisbereich(501,1000)):- Preis >= 501, Preis =< 1000.

empfehle_lego_set(
    Alter, Preis_Eingabe, Kompatibel, Bautechnik, Anzahl_Legosets, BauteilMenge, Bauzeit,
    KomplexeBausteine, Lizenz, Interesse, Ausgabe_Set
	) :-
    
    alter(Alter),
    kompatibel(Kompatibel),
    bautechnik(Bautechnik),
    anzahl_gebaute_legosets(Anzahl_Legosets),
    bauteilmenge(BauteilMenge),
    bauzeit(Bauzeit),
    komplexe_bausteine(KomplexeBausteine),
    soll_lizenz_haben(Lizenz),

    % Empfehlungen ermitteln
    empfehle_themenwelt(Interesse, Lizenz, Themenwelt),
    schwierigkeitsgrad(BauteilMenge, Bauzeit, KomplexeBausteine, Schwierigkeitsgrad),
    empfehle_erfahrung([Bautechnik], Anzahl_Legosets, Erfahrung),
    empfehle_zielgruppe(Alter, Erfahrung, Zielgruppe),

    interessen(Interesse),
    erfahrung(Erfahrung),
    schwierigkeitsgrad(Schwierigkeitsgrad),
    zielgruppe(Zielgruppe),
    
    preis_im_bereich(Preis_Eingabe, Preisbereich),
    
    lego_set_empfehlung(
                Zielgruppe,
                Themenwelt,
                Preisbereich,
                Kompatibel,
                Schwierigkeitsgrad,
                Ausgabe_Set
    ),
    lego_set(Ausgabe_Set).