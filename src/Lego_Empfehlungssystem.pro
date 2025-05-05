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

% --- Definition der Lego Sets und ihrer Eigenschaften ---
% Set: 'Abenteuer - Wohnmobil'
lego_set('Abenteuer - Wohnmobil').
set_zielgruppe('Abenteuer - Wohnmobil', 'Kleinkinder').
set_themenwelt('Abenteuer - Wohnmobil', 'City').
set_preisbereich('Abenteuer - Wohnmobil', preisbereich(20,50)).
set_kompatibel('Abenteuer - Wohnmobil', true).
set_schwierigkeit('Abenteuer - Wohnmobil', 'Einfach').

% Set: 'Mein erster Bauernhof'
lego_set('Mein erster Bauernhof').
set_zielgruppe('Mein erster Bauernhof', 'Kleinkinder').
set_themenwelt('Mein erster Bauernhof', 'Classic').
set_preisbereich('Mein erster Bauernhof', preisbereich(20,50)).
set_kompatibel('Mein erster Bauernhof', true).
set_schwierigkeit('Mein erster Bauernhof', 'Einfach').

% Set: '3-in-1-Zauberschloss'
lego_set('3-in-1-Zauberschloss').
set_zielgruppe('3-in-1-Zauberschloss', 'Kleinkinder').
set_themenwelt('3-in-1-Zauberschloss', 'Disney').
set_preisbereich('3-in-1-Zauberschloss', preisbereich(20,50)).
set_kompatibel('3-in-1-Zauberschloss', false).
set_schwierigkeit('3-in-1-Zauberschloss', 'Einfach').

% Set: 'Grosse interaktive Eisenbahn'
lego_set('Grosse interaktive Eisenbahn').
set_zielgruppe('Grosse interaktive Eisenbahn', 'Kleinkinder').
set_themenwelt('Grosse interaktive Eisenbahn', 'Classic').
set_preisbereich('Grosse interaktive Eisenbahn', preisbereich(51,200)).
set_kompatibel('Grosse interaktive Eisenbahn', true).
set_schwierigkeit('Grosse interaktive Eisenbahn', 'Einfach').
set_themenwelt('Grosse interaktive Eisenbahn', 'Classic').

% Set: 'Spinjitzu-Tempel der Ninja'
lego_set('Spinjitzu-Tempel der Ninja').
set_zielgruppe('Spinjitzu-Tempel der Ninja', ['Kleinkinder','Kinder - Einsteiger']).
set_themenwelt('Spinjitzu-Tempel der Ninja', 'Ninjago').
set_preisbereich('Spinjitzu-Tempel der Ninja', preisbereich(20,50)).
set_kompatibel('Spinjitzu-Tempel der Ninja', true).
set_schwierigkeit('Spinjitzu-Tempel der Ninja', ['Einfach','Mittel']).

% Set: 'Kreativer Reisekoffer'
lego_set('Kreativer Reisekoffer').
set_zielgruppe('Kreativer Reisekoffer', 'Kinder - Einsteiger').
set_themenwelt('Kreativer Reisekoffer', 'Creator').
set_preisbereich('Kreativer Reisekoffer', preisbereich(20,50)).
set_kompatibel('Kreativer Reisekoffer', true).
set_schwierigkeit('Kreativer Reisekoffer', 'Einfach').
set_themenwelt('Kreativer Reisekoffer', 'Friends').

% Set: 'Minecraft Mini-Höhle'
lego_set('Minecraft Mini-Höhle').
set_zielgruppe('Minecraft Mini-Höhle', 'Kinder - Einsteiger').
set_themenwelt('Minecraft Mini-Höhle', 'Minecraft').
set_preisbereich('Minecraft Mini-Höhle', preisbereich(20,50)).
set_kompatibel('Minecraft Mini-Höhle', true).
set_schwierigkeit('Minecraft Mini-Höhle', 'Einfach').

% Set: 'Donut Truck'
lego_set('Donut Truck').
set_zielgruppe('Donut Truck', 'Kinder - Einsteiger').
set_themenwelt('Donut Truck', 'City').
set_preisbereich('Donut Truck', preisbereich(51,200)).
set_kompatibel('Donut Truck', true).
set_schwierigkeit('Donut Truck', 'Einfach').
set_themenwelt('Donut Truck', 'City').

% Set: 'Paisleys Haus'
lego_set('Paisleys Haus').
set_zielgruppe('Paisleys Haus', 'Kinder - Einsteiger').
set_themenwelt('Paisleys Haus', 'Friends').
set_preisbereich('Paisleys Haus', preisbereich(51,200)).
set_kompatibel('Paisleys Haus', true).
set_schwierigkeit('Paisleys Haus', 'Einfach').

% Set: 'Bunte Bausteine-Box'
lego_set('Bunte Bausteine-Box').
set_zielgruppe('Bunte Bausteine-Box', 'Kinder - Einsteiger').
set_themenwelt('Bunte Bausteine-Box', 'Classic').
set_preisbereich('Bunte Bausteine-Box', preisbereich(51,200)).
set_kompatibel('Bunte Bausteine-Box', true).
set_schwierigkeit('Bunte Bausteine-Box', 'Einfach').
set_themenwelt('Bunte Bausteine-Box', 'Star Wars').
set_preisbereich('Bunte Bausteine-Box', preisbereich(20,50)).

% Set: 'Lloyds und Arins Training-Mechs'
lego_set('Lloyds und Arins Training-Mechs').
set_zielgruppe('Lloyds und Arins Training-Mechs', ['Kinder - Einsteiger','Kinder - Fortgeschritten']).
set_themenwelt('Lloyds und Arins Training-Mechs', 'Ninjago').
set_preisbereich('Lloyds und Arins Training-Mechs', preisbereich(51,200)).
set_kompatibel('Lloyds und Arins Training-Mechs', true).
set_schwierigkeit('Lloyds und Arins Training-Mechs', ['Einfach','Mittel']).

% Set: 'Obi-Wan Kenobis Jedi Startfighter'
lego_set('Obi-Wan Kenobis Jedi Startfighter').
set_zielgruppe('Obi-Wan Kenobis Jedi Startfighter', 'Kinder - Fortgeschritten').
set_themenwelt('Obi-Wan Kenobis Jedi Startfighter', 'Star Wars').
set_preisbereich('Obi-Wan Kenobis Jedi Startfighter', preisbereich(20,50)).
set_kompatibel('Obi-Wan Kenobis Jedi Startfighter', true).
set_schwierigkeit('Obi-Wan Kenobis Jedi Startfighter', 'Einfach').

% Set: 'Geschäft für Haustierzubehör'
lego_set('Geschäft für Haustierzubehör').
set_zielgruppe('Geschäft für Haustierzubehör', 'Kinder - Fortgeschritten').
set_themenwelt('Geschäft für Haustierzubehör', 'Friends').
set_preisbereich('Geschäft für Haustierzubehör', preisbereich(20,50)).
set_kompatibel('Geschäft für Haustierzubehör', true).
set_schwierigkeit('Geschäft für Haustierzubehör', 'Einfach').

% Set: 'Wilde Tiere: Pandafamilie'
lego_set('Wilde Tiere: Pandafamilie').
set_zielgruppe('Wilde Tiere: Pandafamilie', 'Kinder - Fortgeschritten').
set_themenwelt('Wilde Tiere: Pandafamilie', 'Creator').
set_preisbereich('Wilde Tiere: Pandafamilie', preisbereich(51,200)).
set_kompatibel('Wilde Tiere: Pandafamilie', true).
set_schwierigkeit('Wilde Tiere: Pandafamilie', 'Mittel').

% Set: 'Ultimatives Abenteuerschloss'
lego_set('Ultimatives Abenteuerschloss').
set_zielgruppe('Ultimatives Abenteuerschloss', 'Kinder - Fortgeschritten').
set_themenwelt('Ultimatives Abenteuerschloss', 'Disney').
set_preisbereich('Ultimatives Abenteuerschloss', preisbereich(51,200)).
set_kompatibel('Ultimatives Abenteuerschloss', true).
set_schwierigkeit('Ultimatives Abenteuerschloss', 'Mittel').

% Set: 'Schloss Hogwarts: Die Große Halle'
lego_set('Schloss Hogwarts: Die Grosse Halle').
set_zielgruppe('Schloss Hogwarts: Die Grosse Halle', 'Kinder - Fortgeschritten').
set_themenwelt('Schloss Hogwarts: Die Grosse Halle', 'Harry Potter').
set_preisbereich('Schloss Hogwarts: Die Grosse Halle', preisbereich(201,500)).
set_kompatibel('Schloss Hogwarts: Die Grosse Halle', true).
set_schwierigkeit('Schloss Hogwarts: Die Grosse Halle', 'Schwer').
set_zielgruppe('Schloss Hogwarts: Die Grosse Halle', 'Jugendliche - Einsteiger').
set_schwierigkeit('Schloss Hogwarts: Die Grosse Halle', 'Mittel').

% Set: 'New York City'
lego_set('New York City').
set_zielgruppe('New York City', ['Kinder - Fortgeschritten','Jugendliche - Einsteiger']).
set_themenwelt('New York City', 'Architektur').
set_preisbereich('New York City', preisbereich(20,50)).
set_kompatibel('New York City', true).
set_schwierigkeit('New York City', 'Schwer').
set_zielgruppe('New York City', 'Jugendliche - Fortgeschritten').
set_preisbereich('New York City', preisbereich(51,200)).
set_kompatibel('New York City', false).
set_schwierigkeit('New York City', 'Mittel').

% Set: 'Darth Mauls Sith Infiltrator'
lego_set('Darth Mauls Sith Infiltrator').
set_zielgruppe('Darth Mauls Sith Infiltrator', ['Kinder - Einsteiger','Jugendliche - Einsteiger']).
set_themenwelt('Darth Mauls Sith Infiltrator', 'Star Wars').
set_preisbereich('Darth Mauls Sith Infiltrator', preisbereich(51,200)).
set_kompatibel('Darth Mauls Sith Infiltrator', true).
set_schwierigkeit('Darth Mauls Sith Infiltrator', ['Einfach','Mittel']).

% Set: 'Trevi-Brunnen'
lego_set('Trevi-Brunnen').
set_zielgruppe('Trevi-Brunnen', 'Jugendliche - Einsteiger').
set_themenwelt('Trevi-Brunnen', 'Architektur').
set_preisbereich('Trevi-Brunnen', preisbereich(201,500)).
set_kompatibel('Trevi-Brunnen', true).
set_schwierigkeit('Trevi-Brunnen', 'Einfach').
set_zielgruppe('Trevi-Brunnen', 'Erwachsene - Fortgeschritten').
set_preisbereich('Trevi-Brunnen', preisbereich(51,200)).
set_kompatibel('Trevi-Brunnen', false).
set_schwierigkeit('Trevi-Brunnen', 'Mittel').

% Set: 'Wilde Tiere: Rosa Flamingo'
lego_set('Wilde Tiere: Rosa Flamingo').
set_zielgruppe('Wilde Tiere: Rosa Flamingo', 'Jugendliche - Einsteiger').
set_themenwelt('Wilde Tiere: Rosa Flamingo', 'Creator').
set_preisbereich('Wilde Tiere: Rosa Flamingo', preisbereich(20,50)).
set_kompatibel('Wilde Tiere: Rosa Flamingo', true).
set_schwierigkeit('Wilde Tiere: Rosa Flamingo', 'Einfach').

% Set: 'Fast and Furious Toyota Supra MK4'
lego_set('Fast and Furious Toyota Supra MK4').
set_zielgruppe('Fast and Furious Toyota Supra MK4', 'Jugendliche - Einsteiger').
set_themenwelt('Fast and Furious Toyota Supra MK4', 'Technik').
set_preisbereich('Fast and Furious Toyota Supra MK4', preisbereich(51,200)).
set_kompatibel('Fast and Furious Toyota Supra MK4', true).
set_schwierigkeit('Fast and Furious Toyota Supra MK4', 'Einfach').

% Set: 'R2-D2'
lego_set('R2-D2').
set_zielgruppe('R2-D2', 'Jugendliche - Einsteiger').
set_themenwelt('R2-D2', 'Star Wars').
set_preisbereich('R2-D2', preisbereich(51,200)).
set_kompatibel('R2-D2', true).
set_schwierigkeit('R2-D2', 'Einfach').

% Set: 'MARVEL Logo & Minifiguren'
lego_set('MARVEL Logo & Minifiguren').
set_zielgruppe('MARVEL Logo & Minifiguren', 'Jugendliche - Fortgeschritten').
set_themenwelt('MARVEL Logo & Minifiguren', 'Marvel').
set_preisbereich('MARVEL Logo & Minifiguren', preisbereich(201,500)).
set_kompatibel('MARVEL Logo & Minifiguren', false).
set_schwierigkeit('MARVEL Logo & Minifiguren', 'Mittel').
set_preisbereich('MARVEL Logo & Minifiguren', preisbereich(51,200)).

% Set: 'London'
lego_set('London').
set_zielgruppe('London', 'Jugendliche - Fortgeschritten').
set_themenwelt('London', 'Architektur').
set_preisbereich('London', preisbereich(20,50)).
set_kompatibel('London', false).
set_schwierigkeit('London', 'Einfach').

% Set: 'NINJAGO City Werkstätten'
lego_set('NINJAGO City Werkstätten').
set_zielgruppe('NINJAGO City Werkstätten', 'Jugendliche - Fortgeschritten').
set_themenwelt('NINJAGO City Werkstätten', 'Ninjago').
set_preisbereich('NINJAGO City Werkstätten', preisbereich(201,500)).
set_kompatibel('NINJAGO City Werkstätten', false).
set_schwierigkeit('NINJAGO City Werkstätten', 'Schwer').

% Set: 'Darth Vader Helm'
lego_set('Darth Vader Helm').
set_zielgruppe('Darth Vader Helm', 'Erwachsene - Einsteiger').
set_themenwelt('Darth Vader Helm', 'Star Wars').
set_preisbereich('Darth Vader Helm', preisbereich(51,200)).
set_kompatibel('Darth Vader Helm', false).
set_schwierigkeit('Darth Vader Helm', 'Einfach').

% Set: 'Invisible Hand'
lego_set('Invisible Hand').
set_zielgruppe('Invisible Hand', 'Erwachsene - Einsteiger').
set_themenwelt('Invisible Hand', 'Star Wars').
set_preisbereich('Invisible Hand', preisbereich(51,200)).
set_kompatibel('Invisible Hand', true).
set_schwierigkeit('Invisible Hand', 'Mittel').

% Set: 'Die Werkbank'
lego_set('Die Werkbank').
set_zielgruppe('Die Werkbank', 'Erwachsene - Einsteiger').
set_themenwelt('Die Werkbank', 'Minecraft').
set_preisbereich('Die Werkbank', preisbereich(51,200)).
set_kompatibel('Die Werkbank', true).
set_schwierigkeit('Die Werkbank', 'Mittel').

% Set: 'Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern'
lego_set('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern').
set_zielgruppe('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern', 'Erwachsene - Einsteiger').
set_themenwelt('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern', 'Disney').
set_preisbereich('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern', preisbereich(201,500)).
set_kompatibel('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern', false).
set_schwierigkeit('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern', 'Mittel').

% Set: 'Der Sprechende Hut'
lego_set('Der Sprechende Hut').
set_zielgruppe('Der Sprechende Hut', 'Erwachsene - Fortgeschritten').
set_themenwelt('Der Sprechende Hut', 'Harry Potter').
set_preisbereich('Der Sprechende Hut', preisbereich(51,200)).
set_kompatibel('Der Sprechende Hut', false).
set_schwierigkeit('Der Sprechende Hut', 'Mittel').

% Set: 'Ducati Panigale V4 S Motorrad'
lego_set('Ducati Panigale V4 S Motorrad').
set_zielgruppe('Ducati Panigale V4 S Motorrad', 'Erwachsene - Fortgeschritten').
set_themenwelt('Ducati Panigale V4 S Motorrad', 'Technik').
set_preisbereich('Ducati Panigale V4 S Motorrad', preisbereich(51,200)).
set_kompatibel('Ducati Panigale V4 S Motorrad', false).
set_schwierigkeit('Ducati Panigale V4 S Motorrad', 'Mittel').

% Set: 'McLaren P1'
lego_set('McLaren P1').
set_zielgruppe('McLaren P1', 'Erwachsene - Fortgeschritten').
set_themenwelt('McLaren P1', 'Technik').
set_preisbereich('McLaren P1', preisbereich(201,500)).
set_kompatibel('McLaren P1', false).
set_schwierigkeit('McLaren P1', 'Schwer').

% Set: 'X-Men: X-Mansion'
lego_set('X-Men: X-Mansion').
set_zielgruppe('X-Men: X-Mansion', 'Erwachsene - Fortgeschritten').
set_themenwelt('X-Men: X-Mansion', 'Marvel').
set_preisbereich('X-Men: X-Mansion', preisbereich(201,500)).
set_kompatibel('X-Men: X-Mansion', true).
set_schwierigkeit('X-Men: X-Mansion', 'Schwer').

% Set: 'Schloss Hogwarts'
lego_set('Schloss Hogwarts').
set_zielgruppe('Schloss Hogwarts', 'Erwachsene - Fortgeschritten').
set_themenwelt('Schloss Hogwarts', 'Harry Potter').
set_preisbereich('Schloss Hogwarts', preisbereich(501,1000)).
set_kompatibel('Schloss Hogwarts', false).
set_schwierigkeit('Schloss Hogwarts', 'Schwer').

% Set: 'Die Milchstraßen-Galaxie'
lego_set('Die Milchstrassen-Galaxie').
set_zielgruppe('Die Milchstrassen-Galaxie', 'Erwachsene - Experte').
set_themenwelt('Die Milchstrassen-Galaxie', 'Creator').
set_preisbereich('Die Milchstrassen-Galaxie', preisbereich(51,200)).
set_kompatibel('Die Milchstrassen-Galaxie', false).
set_schwierigkeit('Die Milchstrassen-Galaxie', 'Mittel').

% Set: 'Schloss Hogwarts mit Schlossgelände'
lego_set('Schloss Hogwarts mit Schlossgelände').
set_zielgruppe('Schloss Hogwarts mit Schlossgelände', 'Erwachsene - Experte').
set_themenwelt('Schloss Hogwarts mit Schlossgelände', 'Harry Potter').
set_preisbereich('Schloss Hogwarts mit Schlossgelände', preisbereich(51,200)).
set_kompatibel('Schloss Hogwarts mit Schlossgelände', false).
set_schwierigkeit('Schloss Hogwarts mit Schlossgelände', 'Mittel').
set_zielgruppe('Schloss Hogwarts mit Schlossgelände', 'Kinder - Fortgeschritten').

% Set: 'Ferrari Daytona SP3'
lego_set('Ferrari Daytona SP3').
set_zielgruppe('Ferrari Daytona SP3', 'Erwachsene - Experte').
set_themenwelt('Ferrari Daytona SP3', 'Technik').
set_preisbereich('Ferrari Daytona SP3', preisbereich(201,500)).
set_kompatibel('Ferrari Daytona SP3', false).
set_schwierigkeit('Ferrari Daytona SP3', 'Schwer').

% Set: 'Titanic'
lego_set('Titanic').
set_zielgruppe('Titanic', 'Erwachsene - Experte').
set_themenwelt('Titanic', 'Creator').
set_preisbereich('Titanic', preisbereich(501,1000)).
set_kompatibel('Titanic', false).
set_schwierigkeit('Titanic', 'Schwer').

% Set: 'Avengers Tower'
lego_set('Avengers Tower').
set_zielgruppe('Avengers Tower', 'Erwachsene - Experte').
set_themenwelt('Avengers Tower', 'Marvel').
set_preisbereich('Avengers Tower', preisbereich(501,1000)).
set_kompatibel('Avengers Tower', true).
set_schwierigkeit('Avengers Tower', 'Schwer').

% --- Hilfsprädikate für Matching (wenn Fakten Listen enthalten) ---

% Prüft, ob die gesuchte Zielgruppe im Fakt enthalten ist (Atom oder Liste)
set_zielgruppe_match(Set, GesuchteZielgruppe) :-
    set_zielgruppe(Set, ZielgruppeFakt),
    (   is_list(ZielgruppeFakt) -> member(GesuchteZielgruppe, ZielgruppeFakt)
    ;   ZielgruppeFakt == GesuchteZielgruppe
    ).

% Prüft, ob der gesuchte Schwierigkeitsgrad im Fakt enthalten ist (Atom oder Liste)
set_schwierigkeit_match(Set, GesuchterSchwierigkeitsgrad) :-
    set_schwierigkeit(Set, SchwierigkeitFakt),
    (   is_list(SchwierigkeitFakt) -> member(GesuchterSchwierigkeitsgrad, SchwierigkeitFakt)
    ;   SchwierigkeitFakt == GesuchterSchwierigkeitsgrad
    ).


preis_im_bereich(Preis, preisbereich(20,50))   :- Preis >= 20,  Preis =< 50.
preis_im_bereich(Preis, preisbereich(51,200))  :- Preis >= 51,  Preis =< 200.
preis_im_bereich(Preis, preisbereich(201,500)) :- Preis >= 201, Preis =< 500.
preis_im_bereich(Preis, preisbereich(501,1000)):- Preis >= 501, Preis =< 1000.

empfehle_lego_set(
    Alter, Preis_Eingabe, Kompatibel_Eingabe, Bautechnik, Anzahl_Legosets, BauteilMenge, Bauzeit,
    KomplexeBausteine, Lizenz, Interesse, Ausgabe_Set
    ) :-

    alter(Alter),
    kompatibel(Kompatibel_Eingabe),
    bautechnik(Bautechnik),
    anzahl_gebaute_legosets(Anzahl_Legosets),
    bauteilmenge(BauteilMenge),
    bauzeit(Bauzeit),
    komplexe_bausteine(KomplexeBausteine),
    soll_lizenz_haben(Lizenz),
    interessen(Interesse), 

    % Subdecissions ableiten
    empfehle_themenwelt(Interesse, Lizenz, Themenwelt),
    schwierigkeitsgrad(BauteilMenge, Bauzeit, KomplexeBausteine, Schwierigkeitsgrad),
    empfehle_erfahrung([Bautechnik], Anzahl_Legosets, Erfahrung),
    empfehle_zielgruppe(Alter, Erfahrung, Zielgruppe),

    erfahrung(Erfahrung),
    schwierigkeitsgrad(Schwierigkeit),
    zielgruppe(Zielgruppe),
    themenwelt(Themenwelt),

    preis_im_bereich(Preis_Eingabe, Preisbereich),

    % Set suchen, das ALLEN abgeleiteten Kriterien entspricht
    lego_set(Ausgabe_Set), % Wähle ein existierendes Set
    set_zielgruppe_match(Ausgabe_Set, Zielgruppe),          % Prüfe Zielgruppe (ggf. Liste)
    set_themenwelt(Ausgabe_Set, Themenwelt),                % Prüfe Themenwelt
    set_preisbereich(Ausgabe_Set, Preisbereich),            % Prüfe Preisbereich
    set_kompatibel(Ausgabe_Set, Kompatibel_Eingabe),        % Prüfe Kompatibilität
    set_schwierigkeit_match(Ausgabe_Set, Schwierigkeitsgrad). % Prüfe Schwierigkeit (ggf. Liste)