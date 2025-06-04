% LEGO Empfehlungssystem in Prolog

% ---Datentypen / Wissensbasis---

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

% LEGO Set Definitionen und deren Eigenschaften
lego_set('Abenteuer - Wohnmobil').
lego_set('Mein erster Bauernhof').
lego_set('3-in-1-Zauberschloss').
lego_set('Grosse interaktive Eisenbahn').
lego_set('Spinjitzu-Tempel der Ninja').
lego_set('Kreativer Reisekoffer').
lego_set('Minecraft Mini-Höhle').
lego_set('Donut Truck').
lego_set('Paisleys Haus').
lego_set('Bunte Bausteine-Box').
lego_set('Lloyds und Arins Training-Mechs').
lego_set('Obi-Wan Kenobis Jedi Startfighter').
lego_set('Geschäft für Haustierzubehör').
lego_set('Wilde Tiere: Pandafamilie').
lego_set('Ultimatives Abenteuerschloss').
lego_set('Schloss Hogwarts: Die Grosse Halle').
lego_set('New York City').
lego_set('Darth Mauls Sith Infiltrator').
lego_set('Trevi-Brunnen').
lego_set('Wilde Tiere: Rosa Flamingo').
lego_set('Fast and Furious Toyota Supra MK4').
lego_set('R2-D2').
lego_set('MARVEL Logo & Minifiguren').
lego_set('London').
lego_set('NINJAGO City Werkstätten').
lego_set('Darth Vader Helm').
lego_set('Invisible Hand').
lego_set('Die Werkbank').
lego_set('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern').
lego_set('Der Sprechende Hut').
lego_set('Ducati Panigale V4 S Motorrad').
lego_set('McLaren P1').
lego_set('X-Men: X-Mansion').
lego_set('Schloss Hogwarts').
lego_set('Die Milchstrassen-Galaxie').
lego_set('Schloss Hogwarts mit Schlossgelände').
lego_set('Ferrari Daytona SP3').
lego_set('Titanic').
lego_set('Avengers Tower').

% Lego Set Zielgruppen
set_zielgruppe('Abenteuer - Wohnmobil', 'Kleinkinder').
set_zielgruppe('Mein erster Bauernhof', 'Kleinkinder').
set_zielgruppe('3-in-1-Zauberschloss', 'Kleinkinder').
set_zielgruppe('Grosse interaktive Eisenbahn', 'Kleinkinder').
set_zielgruppe('Spinjitzu-Tempel der Ninja', ['Kleinkinder','Kinder - Einsteiger']).
set_zielgruppe('Kreativer Reisekoffer', 'Kinder - Einsteiger').
set_zielgruppe('Minecraft Mini-Höhle', 'Kinder - Einsteiger').
set_zielgruppe('Donut Truck', 'Kinder - Einsteiger').
set_zielgruppe('Paisleys Haus', 'Kinder - Einsteiger').
set_zielgruppe('Bunte Bausteine-Box', 'Kinder - Einsteiger').
set_zielgruppe('Lloyds und Arins Training-Mechs', ['Kinder - Einsteiger','Kinder - Fortgeschritten']).
set_zielgruppe('Obi-Wan Kenobis Jedi Startfighter', 'Kinder - Fortgeschritten').
set_zielgruppe('Geschäft für Haustierzubehör', 'Kinder - Fortgeschritten').
set_zielgruppe('Wilde Tiere: Pandafamilie', 'Kinder - Fortgeschritten').
set_zielgruppe('Ultimatives Abenteuerschloss', 'Kinder - Fortgeschritten').
set_zielgruppe('Schloss Hogwarts: Die Grosse Halle', 'Kinder - Fortgeschritten').
set_zielgruppe('Schloss Hogwarts: Die Grosse Halle', 'Jugendliche - Einsteiger').
set_zielgruppe('New York City', ['Kinder - Fortgeschritten','Jugendliche - Einsteiger']).
set_zielgruppe('New York City', 'Jugendliche - Fortgeschritten'). 
set_zielgruppe('Darth Mauls Sith Infiltrator', ['Kinder - Einsteiger','Jugendliche - Einsteiger']).
set_zielgruppe('Trevi-Brunnen', 'Jugendliche - Einsteiger').
set_zielgruppe('Trevi-Brunnen', 'Erwachsene - Fortgeschritten'). 
set_zielgruppe('Wilde Tiere: Rosa Flamingo', 'Jugendliche - Einsteiger').
set_zielgruppe('Fast and Furious Toyota Supra MK4', 'Jugendliche - Einsteiger').
set_zielgruppe('R2-D2', 'Jugendliche - Einsteiger').
set_zielgruppe('MARVEL Logo & Minifiguren', 'Jugendliche - Fortgeschritten').
set_zielgruppe('London', 'Jugendliche - Fortgeschritten').
set_zielgruppe('NINJAGO City Werkstätten', 'Jugendliche - Fortgeschritten').
set_zielgruppe('Darth Vader Helm', 'Erwachsene - Einsteiger').
set_zielgruppe('Invisible Hand', 'Erwachsene - Einsteiger').
set_zielgruppe('Die Werkbank', 'Erwachsene - Einsteiger').
set_zielgruppe('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern', 'Erwachsene - Einsteiger').
set_zielgruppe('Der Sprechende Hut', 'Erwachsene - Fortgeschritten').
set_zielgruppe('Ducati Panigale V4 S Motorrad', 'Erwachsene - Fortgeschritten').
set_zielgruppe('McLaren P1', 'Erwachsene - Fortgeschritten').
set_zielgruppe('X-Men: X-Mansion', 'Erwachsene - Fortgeschritten').
set_zielgruppe('Schloss Hogwarts', 'Erwachsene - Fortgeschritten').
set_zielgruppe('Die Milchstrassen-Galaxie', 'Erwachsene - Experte').
set_zielgruppe('Schloss Hogwarts mit Schlossgelände', 'Erwachsene - Experte').
set_zielgruppe('Schloss Hogwarts mit Schlossgelände', 'Kinder - Fortgeschritten'). 
set_zielgruppe('Ferrari Daytona SP3', 'Erwachsene - Experte').
set_zielgruppe('Titanic', 'Erwachsene - Experte').
set_zielgruppe('Avengers Tower', 'Erwachsene - Experte').

% Lego Set Themenwelten
set_themenwelt('Abenteuer - Wohnmobil', 'City').
set_themenwelt('Mein erster Bauernhof', 'Classic').
set_themenwelt('3-in-1-Zauberschloss', 'Disney').
set_themenwelt('Grosse interaktive Eisenbahn', 'Classic'). 
set_themenwelt('Spinjitzu-Tempel der Ninja', 'Ninjago').
set_themenwelt('Kreativer Reisekoffer', 'Creator').
set_themenwelt('Kreativer Reisekoffer', 'Friends').  
set_themenwelt('Minecraft Mini-Höhle', 'Minecraft').
set_themenwelt('Donut Truck', 'City'). 
set_themenwelt('Paisleys Haus', 'Friends').
set_themenwelt('Bunte Bausteine-Box', 'Classic').
set_themenwelt('Bunte Bausteine-Box', 'Star Wars').  
set_themenwelt('Lloyds und Arins Training-Mechs', 'Ninjago').
set_themenwelt('Obi-Wan Kenobis Jedi Startfighter', 'Star Wars').
set_themenwelt('Geschäft für Haustierzubehör', 'Friends').
set_themenwelt('Wilde Tiere: Pandafamilie', 'Creator').
set_themenwelt('Ultimatives Abenteuerschloss', 'Disney').
set_themenwelt('Schloss Hogwarts: Die Grosse Halle', 'Harry Potter').
set_themenwelt('New York City', 'Architektur').
set_themenwelt('Darth Mauls Sith Infiltrator', 'Star Wars').
set_themenwelt('Trevi-Brunnen', 'Architektur').
set_themenwelt('Wilde Tiere: Rosa Flamingo', 'Creator').
set_themenwelt('Fast and Furious Toyota Supra MK4', 'Technik').
set_themenwelt('R2-D2', 'Star Wars').
set_themenwelt('MARVEL Logo & Minifiguren', 'Marvel').
set_themenwelt('London', 'Architektur').
set_themenwelt('NINJAGO City Werkstätten', 'Ninjago').
set_themenwelt('Darth Vader Helm', 'Star Wars').
set_themenwelt('Invisible Hand', 'Star Wars').
set_themenwelt('Die Werkbank', 'Minecraft').
set_themenwelt('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern', 'Disney').
set_themenwelt('Der Sprechende Hut', 'Harry Potter').
set_themenwelt('Ducati Panigale V4 S Motorrad', 'Technik').
set_themenwelt('McLaren P1', 'Technik').
set_themenwelt('X-Men: X-Mansion', 'Marvel').
set_themenwelt('Schloss Hogwarts', 'Harry Potter').
set_themenwelt('Die Milchstrassen-Galaxie', 'Creator').
set_themenwelt('Schloss Hogwarts mit Schlossgelände', 'Harry Potter').
set_themenwelt('Ferrari Daytona SP3', 'Technik').
set_themenwelt('Titanic', 'Creator').
set_themenwelt('Avengers Tower', 'Marvel').

% Lego Set Preisbereiche
set_preisbereich('Abenteuer - Wohnmobil', preisbereich(20,50)).
set_preisbereich('Mein erster Bauernhof', preisbereich(20,50)).
set_preisbereich('3-in-1-Zauberschloss', preisbereich(20,50)).
set_preisbereich('Grosse interaktive Eisenbahn', preisbereich(51,200)).
set_preisbereich('Spinjitzu-Tempel der Ninja', preisbereich(20,50)).
set_preisbereich('Kreativer Reisekoffer', preisbereich(20,50)).
set_preisbereich('Minecraft Mini-Höhle', preisbereich(20,50)).
set_preisbereich('Donut Truck', preisbereich(51,200)).
set_preisbereich('Paisleys Haus', preisbereich(51,200)).
set_preisbereich('Bunte Bausteine-Box', preisbereich(51,200)).
set_preisbereich('Bunte Bausteine-Box', preisbereich(20,50)). 
set_preisbereich('Lloyds und Arins Training-Mechs', preisbereich(51,200)).
set_preisbereich('Obi-Wan Kenobis Jedi Startfighter', preisbereich(20,50)).
set_preisbereich('Geschäft für Haustierzubehör', preisbereich(20,50)).
set_preisbereich('Wilde Tiere: Pandafamilie', preisbereich(51,200)).
set_preisbereich('Ultimatives Abenteuerschloss', preisbereich(51,200)).
set_preisbereich('Schloss Hogwarts: Die Grosse Halle', preisbereich(201,500)).
set_preisbereich('New York City', preisbereich(20,50)).
set_preisbereich('New York City', preisbereich(51,200)). 
set_preisbereich('Darth Mauls Sith Infiltrator', preisbereich(51,200)).
set_preisbereich('Trevi-Brunnen', preisbereich(201,500)).
set_preisbereich('Trevi-Brunnen', preisbereich(51,200)). 
set_preisbereich('Wilde Tiere: Rosa Flamingo', preisbereich(20,50)).
set_preisbereich('Fast and Furious Toyota Supra MK4', preisbereich(51,200)).
set_preisbereich('R2-D2', preisbereich(51,200)).
set_preisbereich('MARVEL Logo & Minifiguren', preisbereich(201,500)).
set_preisbereich('MARVEL Logo & Minifiguren', preisbereich(51,200)). 
set_preisbereich('London', preisbereich(20,50)).
set_preisbereich('NINJAGO City Werkstätten', preisbereich(201,500)).
set_preisbereich('Darth Vader Helm', preisbereich(51,200)).
set_preisbereich('Invisible Hand', preisbereich(51,200)).
set_preisbereich('Die Werkbank', preisbereich(51,200)).
set_preisbereich('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern', preisbereich(201,500)).
set_preisbereich('Der Sprechende Hut', preisbereich(51,200)).
set_preisbereich('Ducati Panigale V4 S Motorrad', preisbereich(51,200)).
set_preisbereich('McLaren P1', preisbereich(201,500)).
set_preisbereich('X-Men: X-Mansion', preisbereich(201,500)).
set_preisbereich('Schloss Hogwarts', preisbereich(501,1000)).
set_preisbereich('Die Milchstrassen-Galaxie', preisbereich(51,200)).
set_preisbereich('Schloss Hogwarts mit Schlossgelände', preisbereich(51,200)).
set_preisbereich('Ferrari Daytona SP3', preisbereich(201,500)).
set_preisbereich('Titanic', preisbereich(501,1000)).
set_preisbereich('Avengers Tower', preisbereich(501,1000)).

% Lego Set Kompatibilität
set_kompatibel('Abenteuer - Wohnmobil', true).
set_kompatibel('Mein erster Bauernhof', true).
set_kompatibel('3-in-1-Zauberschloss', false).
set_kompatibel('Grosse interaktive Eisenbahn', true).
set_kompatibel('Spinjitzu-Tempel der Ninja', true).
set_kompatibel('Kreativer Reisekoffer', true).
set_kompatibel('Minecraft Mini-Höhle', true).
set_kompatibel('Donut Truck', true).
set_kompatibel('Paisleys Haus', true).
set_kompatibel('Bunte Bausteine-Box', true).
set_kompatibel('Lloyds und Arins Training-Mechs', true).
set_kompatibel('Obi-Wan Kenobis Jedi Startfighter', true).
set_kompatibel('Geschäft für Haustierzubehör', true).
set_kompatibel('Wilde Tiere: Pandafamilie', true).
set_kompatibel('Ultimatives Abenteuerschloss', true).
set_kompatibel('Schloss Hogwarts: Die Grosse Halle', true).
set_kompatibel('New York City', true).
set_kompatibel('New York City', false). 
set_kompatibel('Darth Mauls Sith Infiltrator', true).
set_kompatibel('Trevi-Brunnen', true).
set_kompatibel('Trevi-Brunnen', false). 
set_kompatibel('Wilde Tiere: Rosa Flamingo', true).
set_kompatibel('Fast and Furious Toyota Supra MK4', true).
set_kompatibel('R2-D2', true).
set_kompatibel('MARVEL Logo & Minifiguren', false).
set_kompatibel('London', false).
set_kompatibel('NINJAGO City Werkstätten', false).
set_kompatibel('Darth Vader Helm', false).
set_kompatibel('Invisible Hand', true).
set_kompatibel('Die Werkbank', true).
set_kompatibel('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern', false).
set_kompatibel('Der Sprechende Hut', false).
set_kompatibel('Ducati Panigale V4 S Motorrad', false).
set_kompatibel('McLaren P1', false).
set_kompatibel('X-Men: X-Mansion', true).
set_kompatibel('Schloss Hogwarts', false).
set_kompatibel('Die Milchstrassen-Galaxie', false).
set_kompatibel('Schloss Hogwarts mit Schlossgelände', false).
set_kompatibel('Ferrari Daytona SP3', false).
set_kompatibel('Titanic', false).
set_kompatibel('Avengers Tower', true).

% Lego Set Schwierigkeitsgrade
set_schwierigkeit('Abenteuer - Wohnmobil', 'Einfach').
set_schwierigkeit('Mein erster Bauernhof', 'Einfach').
set_schwierigkeit('3-in-1-Zauberschloss', 'Einfach').
set_schwierigkeit('Grosse interaktive Eisenbahn', 'Einfach').
set_schwierigkeit('Spinjitzu-Tempel der Ninja', ['Einfach','Mittel']).
set_schwierigkeit('Kreativer Reisekoffer', 'Einfach').
set_schwierigkeit('Minecraft Mini-Höhle', 'Einfach').
set_schwierigkeit('Donut Truck', 'Einfach').
set_schwierigkeit('Paisleys Haus', 'Einfach').
set_schwierigkeit('Bunte Bausteine-Box', 'Einfach').
set_schwierigkeit('Lloyds und Arins Training-Mechs', ['Einfach','Mittel']).
set_schwierigkeit('Obi-Wan Kenobis Jedi Startfighter', 'Einfach').
set_schwierigkeit('Geschäft für Haustierzubehör', 'Einfach').
set_schwierigkeit('Wilde Tiere: Pandafamilie', 'Mittel').
set_schwierigkeit('Ultimatives Abenteuerschloss', 'Mittel').
set_schwierigkeit('Schloss Hogwarts: Die Grosse Halle', 'Schwer').
set_schwierigkeit('Schloss Hogwarts: Die Grosse Halle', 'Mittel'). 
set_schwierigkeit('New York City', 'Schwer').
set_schwierigkeit('New York City', 'Mittel'). 
set_schwierigkeit('Darth Mauls Sith Infiltrator', ['Einfach','Mittel']).
set_schwierigkeit('Trevi-Brunnen', 'Einfach').
set_schwierigkeit('Trevi-Brunnen', 'Mittel'). 
set_schwierigkeit('Wilde Tiere: Rosa Flamingo', 'Einfach').
set_schwierigkeit('Fast and Furious Toyota Supra MK4', 'Einfach').
set_schwierigkeit('R2-D2', 'Einfach').
set_schwierigkeit('MARVEL Logo & Minifiguren', 'Mittel').
set_schwierigkeit('London', 'Einfach').
set_schwierigkeit('NINJAGO City Werkstätten', 'Schwer').
set_schwierigkeit('Darth Vader Helm', 'Einfach').
set_schwierigkeit('Invisible Hand', 'Mittel').
set_schwierigkeit('Die Werkbank', 'Mittel').
set_schwierigkeit('Disney Hocus Pocus: Das Hexenhaus der Sanderson-Schwestern', 'Mittel').
set_schwierigkeit('Der Sprechende Hut', 'Mittel').
set_schwierigkeit('Ducati Panigale V4 S Motorrad', 'Mittel').
set_schwierigkeit('McLaren P1', 'Schwer').
set_schwierigkeit('X-Men: X-Mansion', 'Schwer').
set_schwierigkeit('Schloss Hogwarts', 'Schwer').
set_schwierigkeit('Die Milchstrassen-Galaxie', 'Mittel').
set_schwierigkeit('Schloss Hogwarts mit Schlossgelände', 'Mittel').
set_schwierigkeit('Ferrari Daytona SP3', 'Schwer').
set_schwierigkeit('Titanic', 'Schwer').
set_schwierigkeit('Avengers Tower', 'Schwer').

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


% Preisbereich Definition
preis_im_bereich(Preis, preisbereich(20,50))   :- Preis >= 20,  Preis =< 50.
preis_im_bereich(Preis, preisbereich(51,200))  :- Preis >= 51,  Preis =< 200.
preis_im_bereich(Preis, preisbereich(201,500)) :- Preis >= 201, Preis =< 500.
preis_im_bereich(Preis, preisbereich(501,1000)):- Preis >= 501, Preis =< 1000.


% kunde_praeferenzen(Name, Alter, Preis_Kunde, Kompatibel, Bautechnik, AnzSets, Teile, Zeit, Komplex, Lizenz, Interesse).
kunde_praeferenzen(anna, 8, 45, true, 'Anleitung', 2, 200, 1, false, true, 'Gaming'). 
kunde_praeferenzen(ben, 3, 30, true, 'Anleitung', 0, 50, 1, false, false, 'Simples Spielen').
kunde_praeferenzen(clara, 10, 150, true, 'Anleitung', 6, 500, 3, false, true, 'Disney'). 
kunde_praeferenzen(david, 18, 80, true, 'Anleitung', 2, 800, 4, true, true, 'Sci-Fi'). 
kunde_praeferenzen(finn, 6, 40, true, 'Anleitung', 1, 150, 1, false, true, 'Ninjas').
kunde_praeferenzen(kerem, 12, 250, true, 'Eigenkreation', 8, 600, 5, true, true, 'Fantasy').
kunde_praeferenzen(bastian, 40, 400, false, 'Modular', 10, 3000, 15, true, false, 'Fahrzeuge'). 
kunde_praeferenzen(fabia, 7, 60, true, 'Anleitung', 3, 250, 2, false, false, 'Tier/Natur'). 
kunde_praeferenzen(elena, 30, 400, true, 'Anleitung', 20, 5000, 20, true, true, 'Superheroes'). 

% ---Hauptprogramm (Lego Set Evaluation)---

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

% --- Empfehlungsregel basierend auf Kunde ---
empfehle_set_fuer_kunde(Kunde, EmpfohlenesSet) :-
    kunde_praeferenzen(Kunde, Alter, Preis_Kunde, Kompatibel, Bautechnik, AnzSets, Teile, Zeit, Komplex, Lizenz, Interesse),
    empfehle_lego_set(Alter, Preis_Kunde, Kompatibel, Bautechnik, AnzSets, Teile, Zeit, Komplex, Lizenz, Interesse, EmpfohlenesSet).

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
    schwierigkeitsgrad(Schwierigkeitsgrad),
    zielgruppe(Zielgruppe),
    themenwelt(Themenwelt),

    preis_im_bereich(Preis_Eingabe, Preisbereich),

    % Set suchen, das ALLEN abgeleiteten Kriterien entspricht
    lego_set(Ausgabe_Set), 
    set_zielgruppe_match(Ausgabe_Set, Zielgruppe),          
    set_themenwelt(Ausgabe_Set, Themenwelt),                
    set_preisbereich(Ausgabe_Set, Preisbereich),            
    set_kompatibel(Ausgabe_Set, Kompatibel_Eingabe),        
    set_schwierigkeit_match(Ausgabe_Set, Schwierigkeitsgrad).