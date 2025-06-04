import re
from rdflib import Graph, Literal, Namespace, RDF, RDFS, OWL, XSD, URIRef, BNode
from rdflib.collection import Collection  # Für RDF-Listen (swrl:body, swrl:head)

# --- Konfiguration ---
PROLOG_FILE_PATH = r"c:\Users\basti\Documents\GitHub\BAI_Wissensraepresentation\src\Lego_Empfehlungssystem.pro"
OWL_OUTPUT_FILE_PATH = r"c:\Users\basti\Documents\GitHub\BAI_Wissensraepresentation\src\generated_lego_ontology_with_swrl.owl"  # Neuer Dateiname
BASE_URI = "http://www.example.org/lego-ontology#"

# --- Namespaces ---
NS = Namespace(BASE_URI)
SWRL = Namespace("http://www.w3.org/2003/11/swrl#")
SWRLB = Namespace("http://www.w3.org/2003/11/swrlb#")
SWRLa = Namespace("http://swrl.stanford.edu/ontologies/3.3/swrla.owl#")  # Für Annotationen wie isRuleEnabled

# --- Hilfsfunktionen ---
def to_uri_safe(name):
    """Konvertiert einen String in einen URI-sicheren Namen."""
    if isinstance(name, str):
        name = name.replace('/', '_or_').replace(':', '_')
        return re.sub(r'\s+', '_', name).replace('-', '_').replace('.', '_').replace('(', '').replace(')', '')
    return str(name)

def parse_prolog_list(list_str):
    """Parst eine Prolog-Liste von Atomen (z.B. "'Atom1', 'Atom2'") zu einer Python-Liste."""
    return [item.strip().strip("'") for item in list_str.split(',') if item.strip()]

def parse_prolog_file(filepath):
    print(f"DEBUG: Starting to parse Prolog file: {filepath}") # HINZUGEFÜGT
    data = {
        "declarations": {},  # For zielgruppe('Name'). etc. -> {'zielgruppe': {'Kleinkinder', ...}}
        "lego_sets": set(),
        "set_properties": [],  # Tuples like ('set_zielgruppe', 'Set Name', 'Zielgruppe Name' or ['ZG1', 'ZG2'])
        "kunden_praeferenzen": []
    }

    # Regex-Muster
    declaration_pattern = re.compile(r"(\w+)\('(.*)'\)\.")
    lego_set_pattern = re.compile(r"lego_set\('(.*)'\)\.")
    set_zielgruppe_pattern = re.compile(r"set_zielgruppe\('(.*)',\s*(.*)\)\.")
    set_themenwelt_pattern = re.compile(r"set_themenwelt\('(.*)',\s*(.*)\)\.")
    set_preisbereich_pattern = re.compile(r"set_preisbereich\('(.*)',\s*preisbereich\((\d+),(\d+)\)\)\.")
    set_kompatibel_pattern = re.compile(r"set_kompatibel\('(.*)',\s*(true|false)\)\.")
    set_schwierigkeit_pattern = re.compile(r"set_schwierigkeit\('(.*)',\s*(.*)\)\.")
    kunde_praeferenzen_pattern = re.compile(
        r"kunde_praeferenzen\(([^,]+),\s*([^,]+),\s*([^,]+),\s*([^,]+),\s*'([^']*)',\s*([^,]+),\s*([^,]+),\s*([^,]+),\s*([^,]+),\s*([^,]+),\s*'([^']*)'\)\."
    )

    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('%'):
                continue

            m = lego_set_pattern.match(line)
            if m:
                data["lego_sets"].add(m.group(1))
                continue

            m = set_zielgruppe_pattern.match(line)
            if m:
                val = m.group(2)
                if val.startswith('['):
                    data["set_properties"].append(("set_zielgruppe", m.group(1), parse_prolog_list(val[1:-1])))
                else:
                    data["set_properties"].append(("set_zielgruppe", m.group(1), val.strip("'")))
                continue

            m = set_themenwelt_pattern.match(line)
            if m:
                val = m.group(2)
                if val.startswith('['):
                    data["set_properties"].append(("set_themenwelt", m.group(1), parse_prolog_list(val[1:-1])))
                else:
                    data["set_properties"].append(("set_themenwelt", m.group(1), val.strip("'")))
                continue

            m = set_preisbereich_pattern.match(line)
            if m:
                data["set_properties"].append(("set_preisbereich", m.group(1), (int(m.group(2)), int(m.group(3)))))
                continue

            m = set_kompatibel_pattern.match(line)
            if m:
                data["set_properties"].append(("set_kompatibel", m.group(1), m.group(2) == 'true'))
                continue

            m = set_schwierigkeit_pattern.match(line)
            if m:
                val = m.group(2)
                if val.startswith('['):
                    data["set_properties"].append(("set_schwierigkeit", m.group(1), parse_prolog_list(val[1:-1])))
                else:
                    data["set_properties"].append(("set_schwierigkeit", m.group(1), val.strip("'")))
                continue

            m = kunde_praeferenzen_pattern.match(line)
            if m:
                data["kunden_praeferenzen"].append({
                    "name": m.group(1), "alter": float(m.group(2)), "preis": int(m.group(3)),
                    "kompatibel": m.group(4) == 'true', "bautechnik": m.group(5),
                    "anz_sets": int(m.group(6)), "teile": int(m.group(7)), "zeit": int(m.group(8)),
                    "komplex": m.group(9) == 'true', "lizenz": m.group(10) == 'true',
                    "interesse": m.group(11)
                })
                continue
            
            m = declaration_pattern.match(line)
            if m:
                predicate_name = m.group(1)
                individual_name = m.group(2)
                if predicate_name not in data["declarations"]:
                    data["declarations"][predicate_name] = set()
                data["declarations"][predicate_name].add(individual_name)
                continue
                
    print(f"DEBUG: Finished parsing. Declarations found: {len(data.get('declarations', {}))}") # HINZUGEFÜGT/MODIFIZIERT
    print(f"DEBUG: LEGO sets found: {len(data.get('lego_sets', []))}") # HINZUGEFÜGT/MODIFIZIERT
    print(f"DEBUG: Customer preferences found: {len(data.get('kunden_praeferenzen', []))}") # HINZUGEFÜGT/MODIFIZIERT
    print(f"DEBUG: Set properties found: {len(data.get('set_properties', []))}") # HINZUGEFÜGT/MODIFIZIERT
    return data

def add_swrl_rule(g, rule_name, rule_comment, body_atoms_tuples, head_atoms_tuples):
    rule_uri = NS[rule_name]
    g.add((rule_uri, RDF.type, SWRL.Imp))
    g.add((rule_uri, RDFS.comment, Literal(rule_comment)))
    g.add((rule_uri, SWRLa.isRuleEnabled, Literal("true", datatype=XSD.boolean)))  # Protégé specific

    body_list_node = BNode()
    g.add((rule_uri, SWRL.body, body_list_node))
    current_body_list = Collection(g, body_list_node)

    for atom_type, elements in body_atoms_tuples:
        atom_node = BNode()
        current_body_list.append(atom_node)
        if atom_type == "class":
            g.add((atom_node, RDF.type, SWRL.ClassAtom))
            g.add((atom_node, SWRL.classPredicate, elements[0]))
            g.add((atom_node, SWRL.argument1, elements[1]))
        elif atom_type == "individual_prop":
            g.add((atom_node, RDF.type, SWRL.IndividualPropertyAtom))
            g.add((atom_node, SWRL.propertyPredicate, elements[0]))
            g.add((atom_node, SWRL.argument1, elements[1]))
            g.add((atom_node, SWRL.argument2, elements[2]))
        elif atom_type == "datavalued_prop":
            g.add((atom_node, RDF.type, SWRL.DatavaluedPropertyAtom))
            g.add((atom_node, SWRL.propertyPredicate, elements[0]))
            g.add((atom_node, SWRL.argument1, elements[1]))
            if isinstance(elements[2], Literal):
                g.add((atom_node, SWRL.argument2, elements[2]))
            else:
                g.add((atom_node, SWRL.argument2, elements[2]))
        elif atom_type == "builtin":
            g.add((atom_node, RDF.type, SWRL.BuiltinAtom))
            g.add((atom_node, SWRL.builtin, elements[0]))
            args_list_node = BNode()
            g.add((atom_node, SWRL.arguments, args_list_node))
            current_args_list = Collection(g, args_list_node)
            for arg in elements[1]:
                current_args_list.append(arg)
    
    head_list_node = BNode()
    g.add((rule_uri, SWRL.head, head_list_node))
    current_head_list = Collection(g, head_list_node)
    for atom_type, elements in head_atoms_tuples:
        atom_node = BNode()
        current_head_list.append(atom_node)
        if atom_type == "individual_prop":
            g.add((atom_node, RDF.type, SWRL.IndividualPropertyAtom))
            g.add((atom_node, SWRL.propertyPredicate, elements[0]))
            g.add((atom_node, SWRL.argument1, elements[1]))
            g.add((atom_node, SWRL.argument2, elements[2]))

def create_owl_ontology(data, output_filepath):
    print("DEBUG: Starting to create OWL ontology.") # HINZUGEFÜGT
    print(f"DEBUG: Data received by create_owl_ontology - Declarations: {len(data.get('declarations', {}))}, Sets: {len(data.get('lego_sets', []))}, Customers: {len(data.get('kunden_praeferenzen', []))}") # HINZUGEFÜGT
    g = Graph()
    g.bind("owl", OWL)
    g.bind("rdf", RDF)
    g.bind("rdfs", RDFS)
    g.add((URIRef(BASE_URI), RDF.type, OWL.Ontology))  # Ontology declaration
    g.bind("xsd", XSD)
    g.bind("swrl", SWRL)
    g.bind("swrlb", SWRLB)
    g.bind("swrla", SWRLa)  # Bind SWRLa
    g.bind("lego", NS)

    LegoSet = NS.LegoSet
    Kunde = NS.Kunde
    Zielgruppe = NS.Zielgruppe
    Erfahrung = NS.Erfahrung
    Schwierigkeitsgrad = NS.Schwierigkeitsgrad
    Themenwelt = NS.Themenwelt
    Interesse = NS.Interesse
    Bautechnik = NS.Bautechnik

    g.add((LegoSet, RDF.type, OWL.Class))
    g.add((Kunde, RDF.type, OWL.Class))
    g.add((Zielgruppe, RDF.type, OWL.Class))
    g.add((Erfahrung, RDF.type, OWL.Class))
    g.add((Schwierigkeitsgrad, RDF.type, OWL.Class))
    g.add((Themenwelt, RDF.type, OWL.Class))
    g.add((Interesse, RDF.type, OWL.Class))
    g.add((Bautechnik, RDF.type, OWL.Class))

    hatSetEigeneZielgruppe = NS.hatSetEigeneZielgruppe
    gehoertZuThemenwelt = NS.gehoertZuThemenwelt
    hatSetSchwierigkeitsgrad = NS.hatSetSchwierigkeitsgrad
    hatPreisMin = NS.hatPreisMin
    hatPreisMax = NS.hatPreisMax
    istKompatibel = NS.istKompatibel
    hatBevorzugteBautechnik = NS.hatBevorzugteBautechnik
    hatKundenInteresse = NS.hatKundenInteresse
    hatErfahrung = NS.hatErfahrung
    empfiehltSetFuerKunde = NS.empfiehltSetFuerKunde
    hatAbgeleiteteZielgruppe = NS.hatAbgeleiteteZielgruppe
    hatGewuenschtenSchwierigkeitsgrad = NS.hatGewuenschtenSchwierigkeitsgrad
    hatBevorzugteThemenwelt = NS.hatBevorzugteThemenwelt
    hatAlter = NS.hatAlter
    hatWunschPreis = NS.hatWunschPreis
    wuenschtKompatibel = NS.wuenschtKompatibel
    hatAnzahlGebauterSets = NS.hatAnzahlGebauterSets
    praeferiertBauteilmenge = NS.praeferiertBauteilmenge
    praeferiertBauzeit = NS.praeferiertBauzeit
    praeferiertKomplexeBausteine = NS.praeferiertKomplexeBausteine
    wuenschtLizenz = NS.wuenschtLizenz

    g.add((hatSetEigeneZielgruppe, RDF.type, OWL.ObjectProperty))
    g.add((hatSetEigeneZielgruppe, RDFS.domain, LegoSet))
    g.add((hatSetEigeneZielgruppe, RDFS.range, Zielgruppe))
    g.add((gehoertZuThemenwelt, RDF.type, OWL.ObjectProperty))
    g.add((gehoertZuThemenwelt, RDFS.domain, LegoSet))
    g.add((gehoertZuThemenwelt, RDFS.range, Themenwelt))
    g.add((hatSetSchwierigkeitsgrad, RDF.type, OWL.ObjectProperty))
    g.add((hatSetSchwierigkeitsgrad, RDFS.domain, LegoSet))
    g.add((hatSetSchwierigkeitsgrad, RDFS.range, Schwierigkeitsgrad))
    g.add((hatPreisMin, RDF.type, OWL.DatatypeProperty))
    g.add((hatPreisMin, RDFS.domain, LegoSet))
    g.add((hatPreisMin, RDFS.range, XSD.integer))
    g.add((hatPreisMax, RDF.type, OWL.DatatypeProperty))
    g.add((hatPreisMax, RDFS.domain, LegoSet))
    g.add((hatPreisMax, RDFS.range, XSD.integer))
    g.add((istKompatibel, RDF.type, OWL.DatatypeProperty))
    g.add((istKompatibel, RDFS.domain, LegoSet))
    g.add((istKompatibel, RDFS.range, XSD.boolean))
    g.add((hatBevorzugteBautechnik, RDF.type, OWL.ObjectProperty))
    g.add((hatBevorzugteBautechnik, RDFS.domain, Kunde))
    g.add((hatBevorzugteBautechnik, RDFS.range, Bautechnik))
    g.add((hatKundenInteresse, RDF.type, OWL.ObjectProperty))
    g.add((hatKundenInteresse, RDFS.domain, Kunde))
    g.add((hatKundenInteresse, RDFS.range, Interesse))
    g.add((hatErfahrung, RDF.type, OWL.ObjectProperty))
    g.add((hatErfahrung, RDFS.domain, Kunde))
    g.add((hatErfahrung, RDFS.range, Erfahrung))
    g.add((empfiehltSetFuerKunde, RDF.type, OWL.ObjectProperty))
    g.add((empfiehltSetFuerKunde, RDFS.domain, Kunde))
    g.add((empfiehltSetFuerKunde, RDFS.range, LegoSet))
    g.add((hatAbgeleiteteZielgruppe, RDF.type, OWL.ObjectProperty))
    g.add((hatAbgeleiteteZielgruppe, RDFS.domain, Kunde))
    g.add((hatAbgeleiteteZielgruppe, RDFS.range, Zielgruppe))
    g.add((hatGewuenschtenSchwierigkeitsgrad, RDF.type, OWL.ObjectProperty))
    g.add((hatGewuenschtenSchwierigkeitsgrad, RDFS.domain, Kunde))
    g.add((hatGewuenschtenSchwierigkeitsgrad, RDFS.range, Schwierigkeitsgrad))
    g.add((hatBevorzugteThemenwelt, RDF.type, OWL.ObjectProperty))
    g.add((hatBevorzugteThemenwelt, RDFS.domain, Kunde))
    g.add((hatBevorzugteThemenwelt, RDFS.range, Themenwelt))
    g.add((hatAlter, RDF.type, OWL.DatatypeProperty))
    g.add((hatAlter, RDFS.domain, Kunde))
    g.add((hatAlter, RDFS.range, XSD.decimal))
    g.add((hatWunschPreis, RDF.type, OWL.DatatypeProperty))
    g.add((hatWunschPreis, RDFS.domain, Kunde))
    g.add((hatWunschPreis, RDFS.range, XSD.integer))
    g.add((wuenschtKompatibel, RDF.type, OWL.DatatypeProperty))
    g.add((wuenschtKompatibel, RDFS.domain, Kunde))
    g.add((wuenschtKompatibel, RDFS.range, XSD.boolean))
    g.add((hatAnzahlGebauterSets, RDF.type, OWL.DatatypeProperty))
    g.add((hatAnzahlGebauterSets, RDFS.domain, Kunde))
    g.add((hatAnzahlGebauterSets, RDFS.range, XSD.integer))
    g.add((praeferiertBauteilmenge, RDF.type, OWL.DatatypeProperty))
    g.add((praeferiertBauteilmenge, RDFS.domain, Kunde))
    g.add((praeferiertBauteilmenge, RDFS.range, XSD.integer))
    g.add((praeferiertBauzeit, RDF.type, OWL.DatatypeProperty))
    g.add((praeferiertBauzeit, RDFS.domain, Kunde))
    g.add((praeferiertBauzeit, RDFS.range, XSD.integer))
    g.add((praeferiertKomplexeBausteine, RDF.type, OWL.DatatypeProperty))
    g.add((praeferiertKomplexeBausteine, RDFS.domain, Kunde))
    g.add((praeferiertKomplexeBausteine, RDFS.range, XSD.boolean))
    g.add((wuenschtLizenz, RDF.type, OWL.DatatypeProperty))
    g.add((wuenschtLizenz, RDFS.domain, Kunde))
    g.add((wuenschtLizenz, RDFS.range, XSD.boolean))

    class_map = {
        "zielgruppe": Zielgruppe,
        "erfahrung": Erfahrung,
        "schwierigkeitsgrad": Schwierigkeitsgrad,
        "themenwelt": Themenwelt,
        "interessen": Interesse,
        "bautechnik": Bautechnik
    }
    for pred_name, individuals_set in data["declarations"].items():
        owl_class = class_map.get(pred_name)
        if owl_class:
            for ind_name_orig in individuals_set:
                ind_name_safe = to_uri_safe(ind_name_orig)
                ind_uri = NS[ind_name_safe]
                g.add((ind_uri, RDF.type, OWL.NamedIndividual))
                g.add((ind_uri, RDF.type, owl_class))
                g.add((ind_uri, RDFS.label, Literal(ind_name_orig, lang="de")))

    for set_name_orig in data["lego_sets"]:
        set_name_safe = to_uri_safe(set_name_orig)
        set_uri = NS[set_name_safe]
        g.add((set_uri, RDF.type, OWL.NamedIndividual))
        g.add((set_uri, RDF.type, LegoSet))
        g.add((set_uri, RDFS.label, Literal(set_name_orig, lang="de")))

    for prop_type, set_name_orig, value in data["set_properties"]:
        set_name_safe = to_uri_safe(set_name_orig)
        set_uri = NS[set_name_safe]

        if prop_type == "set_zielgruppe":
            if isinstance(value, list):
                for zg_orig in value:
                    zg_safe = to_uri_safe(zg_orig)
                    g.add((set_uri, hatSetEigeneZielgruppe, NS[zg_safe]))
            else:
                zg_safe = to_uri_safe(value)
                g.add((set_uri, hatSetEigeneZielgruppe, NS[zg_safe]))
        elif prop_type == "set_themenwelt":
            if isinstance(value, list):
                for tw_orig in value:
                    tw_safe = to_uri_safe(tw_orig)
                    g.add((set_uri, gehoertZuThemenwelt, NS[tw_safe]))
            else:
                tw_safe = to_uri_safe(value)
                g.add((set_uri, gehoertZuThemenwelt, NS[tw_safe]))
        elif prop_type == "set_preisbereich":
            g.add((set_uri, hatPreisMin, Literal(value[0], datatype=XSD.integer)))
            g.add((set_uri, hatPreisMax, Literal(value[1], datatype=XSD.integer)))
        elif prop_type == "set_kompatibel":
            g.add((set_uri, istKompatibel, Literal(value, datatype=XSD.boolean)))
        elif prop_type == "set_schwierigkeit":
            if isinstance(value, list):
                for sg_orig in value:
                    sg_safe = to_uri_safe(sg_orig)
                    g.add((set_uri, hatSetSchwierigkeitsgrad, NS[sg_safe]))
            else:
                sg_safe = to_uri_safe(value)
                g.add((set_uri, hatSetSchwierigkeitsgrad, NS[sg_safe]))

    for kunde_data in data["kunden_praeferenzen"]:
        kunde_name_safe = to_uri_safe(kunde_data["name"])
        kunde_uri = NS[kunde_name_safe]
        g.add((kunde_uri, RDF.type, OWL.NamedIndividual))
        g.add((kunde_uri, RDF.type, Kunde))
        g.add((kunde_uri, RDFS.label, Literal(kunde_data["name"], lang="de")))

        g.add((kunde_uri, hatAlter, Literal(kunde_data["alter"], datatype=XSD.decimal)))
        g.add((kunde_uri, hatWunschPreis, Literal(kunde_data["preis"], datatype=XSD.integer)))
        g.add((kunde_uri, wuenschtKompatibel, Literal(kunde_data["kompatibel"], datatype=XSD.boolean)))

        bt_safe = to_uri_safe(kunde_data["bautechnik"])
        g.add((kunde_uri, hatBevorzugteBautechnik, NS[bt_safe]))

        g.add((kunde_uri, hatAnzahlGebauterSets, Literal(kunde_data["anz_sets"], datatype=XSD.integer)))
        g.add((kunde_uri, praeferiertBauteilmenge, Literal(kunde_data["teile"], datatype=XSD.integer)))
        g.add((kunde_uri, praeferiertBauzeit, Literal(kunde_data["zeit"], datatype=XSD.integer)))
        g.add((kunde_uri, praeferiertKomplexeBausteine, Literal(kunde_data["komplex"], datatype=XSD.boolean)))
        g.add((kunde_uri, wuenschtLizenz, Literal(kunde_data["lizenz"], datatype=XSD.boolean)))

        int_safe = to_uri_safe(kunde_data["interesse"])
        g.add((kunde_uri, hatKundenInteresse, NS[int_safe]))

    # --- SWRL Regeln hinzufügen ---
    # Variablen (einmal pro Regel oder global, wenn Namen eindeutig sind)
    var_k = NS.k # Kunde
    var_alter = NS.alter
    var_anz = NS.anzahlGebaut
    var_menge = NS.menge
    var_zeit = NS.zeit

    # All rule definitions will be stored here and then sorted
    rules_to_add = []

    # Original Rule 1 (ErfahrungAnfaengerAnleitungBeiGeringerAnzahl)
    rules_to_add.append({
        "name_numeric": 1,
        "comment": "Wenn AnzSets <= 5 und Bautechnik Anleitung, dann Erfahrung Anfänger.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAnzahlGebauterSets, var_k, var_anz)),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_anz, Literal(5, datatype=XSD.integer)])),
                 ("individual_prop", (hatBevorzugteBautechnik, var_k, NS[to_uri_safe("Anleitung")]))],
        "head": [("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Anfänger")]))]
    })
    # Original Rule 2 (ErfahrungAnfaengerModularBeiGeringerAnzahl)
    rules_to_add.append({
        "name_numeric": 2,
        "comment": "Wenn AnzSets <= 5 und Bautechnik Modular, dann Erfahrung Anfänger.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAnzahlGebauterSets, var_k, var_anz)),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_anz, Literal(5, datatype=XSD.integer)])),
                 ("individual_prop", (hatBevorzugteBautechnik, var_k, NS[to_uri_safe("Modular")]))],
        "head": [("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Anfänger")]))]
    })
    # Original Rule 3 (ErfahrungFortgeschrittenAnleitungBeiMittlererAnzahl)
    rules_to_add.append({
        "name_numeric": 3,
        "comment": "Wenn AnzSets > 5 & <= 15 und Bautechnik Anleitung, dann Erfahrung Fortgeschritten.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAnzahlGebauterSets, var_k, var_anz)),
                 ("builtin", (SWRLB.greaterThan, [var_anz, Literal(5, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_anz, Literal(15, datatype=XSD.integer)])),
                 ("individual_prop", (hatBevorzugteBautechnik, var_k, NS[to_uri_safe("Anleitung")]))],
        "head": [("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Fortgeschritten")]))]
    })
    # Original Rule 4 (ErfahrungFortgeschrittenModularBeiMittlererAnzahl)
    rules_to_add.append({
        "name_numeric": 4,
        "comment": "Wenn AnzSets > 5 & <= 15 und Bautechnik Modular, dann Erfahrung Fortgeschritten.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAnzahlGebauterSets, var_k, var_anz)),
                 ("builtin", (SWRLB.greaterThan, [var_anz, Literal(5, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_anz, Literal(15, datatype=XSD.integer)])),
                 ("individual_prop", (hatBevorzugteBautechnik, var_k, NS[to_uri_safe("Modular")]))],
        "head": [("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Fortgeschritten")]))]
    })
    # Original Rule 5 (ErfahrungExpertAnleitungBeiHoherAnzahl)
    rules_to_add.append({
        "name_numeric": 5,
        "comment": "Wenn AnzSets > 15 und Bautechnik Anleitung, dann Erfahrung Expert.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAnzahlGebauterSets, var_k, var_anz)),
                 ("builtin", (SWRLB.greaterThan, [var_anz, Literal(15, datatype=XSD.integer)])),
                 ("individual_prop", (hatBevorzugteBautechnik, var_k, NS[to_uri_safe("Anleitung")]))],
        "head": [("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Expert")]))]
    })
    # Original Rule 6 (ErfahrungExpertModularBeiHoherAnzahl)
    rules_to_add.append({
        "name_numeric": 6,
        "comment": "Wenn AnzSets > 15 und Bautechnik Modular, dann Erfahrung Expert.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAnzahlGebauterSets, var_k, var_anz)),
                 ("builtin", (SWRLB.greaterThan, [var_anz, Literal(15, datatype=XSD.integer)])),
                 ("individual_prop", (hatBevorzugteBautechnik, var_k, NS[to_uri_safe("Modular")]))],
        "head": [("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Expert")]))]
    })
    # Original Rule 7 (ErfahrungAnfaengerEigenkreationBeiNullSets)
    rules_to_add.append({
        "name_numeric": 7,
        "comment": "Wenn AnzSets = 0 und Bautechnik Eigenkreation, dann Erfahrung Anfänger.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAnzahlGebauterSets, var_k, var_anz)),
                 ("builtin", (SWRLB.equal, [var_anz, Literal(0, datatype=XSD.integer)])),
                 ("individual_prop", (hatBevorzugteBautechnik, var_k, NS[to_uri_safe("Eigenkreation")]))],
        "head": [("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Anfänger")]))]
    })
    # Original Rule 8 (ErfahrungFortgeschrittenEigenkreationBeiGeringerAnzahl)
    rules_to_add.append({
        "name_numeric": 8,
        "comment": "Wenn AnzSets > 0 & <= 5 und Bautechnik Eigenkreation, dann Erfahrung Fortgeschritten.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAnzahlGebauterSets, var_k, var_anz)),
                 ("builtin", (SWRLB.greaterThan, [var_anz, Literal(0, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_anz, Literal(5, datatype=XSD.integer)])),
                 ("individual_prop", (hatBevorzugteBautechnik, var_k, NS[to_uri_safe("Eigenkreation")]))],
        "head": [("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Fortgeschritten")]))]
    })
    # Original Rule 9 (ErfahrungExpertEigenkreationBeiHoehererAnzahl)
    rules_to_add.append({
        "name_numeric": 9,
        "comment": "Wenn AnzSets > 5 und Bautechnik Eigenkreation, dann Erfahrung Expert.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAnzahlGebauterSets, var_k, var_anz)),
                 ("builtin", (SWRLB.greaterThan, [var_anz, Literal(5, datatype=XSD.integer)])),
                 ("individual_prop", (hatBevorzugteBautechnik, var_k, NS[to_uri_safe("Eigenkreation")]))],
        "head": [("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Expert")]))]
    })
    # Original Rule 10 (ZielgruppeKleinkinderFuerAnfaengerUnter4)
    rules_to_add.append({
        "name_numeric": 10,
        "comment": "Wenn Alter < 4 und Erfahrung Anfänger, dann Zielgruppe Kleinkinder.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAlter, var_k, var_alter)),
                 ("builtin", (SWRLB.lessThan, [var_alter, Literal("4.0", datatype=XSD.decimal)])),
                 ("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Anfänger")]))],
        "head": [("individual_prop", (hatAbgeleiteteZielgruppe, var_k, NS[to_uri_safe("Kleinkinder")]))]
    })
    # Original Rule 11 (ZielgruppeKleinkinderFuerFortgeschritteneUnter4)
    rules_to_add.append({
        "name_numeric": 11,
        "comment": "Wenn Alter < 4 und Erfahrung Fortgeschritten, dann Zielgruppe Kleinkinder.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAlter, var_k, var_alter)),
                 ("builtin", (SWRLB.lessThan, [var_alter, Literal("4.0", datatype=XSD.decimal)])),
                 ("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Fortgeschritten")]))],
        "head": [("individual_prop", (hatAbgeleiteteZielgruppe, var_k, NS[to_uri_safe("Kleinkinder")]))]
    })
    # Original Rule 12 (ZielgruppeKleinkinderFuerExpertenUnter4)
    rules_to_add.append({
        "name_numeric": 12,
        "comment": "Wenn Alter < 4 und Erfahrung Expert, dann Zielgruppe Kleinkinder.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAlter, var_k, var_alter)),
                 ("builtin", (SWRLB.lessThan, [var_alter, Literal("4.0", datatype=XSD.decimal)])),
                 ("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Expert")]))],
        "head": [("individual_prop", (hatAbgeleiteteZielgruppe, var_k, NS[to_uri_safe("Kleinkinder")]))]
    })
    # Original Rule 13 (ZielgruppeKinderEinsteigerFuerAnfaenger4bis12)
    rules_to_add.append({
        "name_numeric": 13,
        "comment": "Wenn Alter 4-12 und Erfahrung Anfänger, dann Zielgruppe Kinder - Einsteiger.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAlter, var_k, var_alter)),
                 ("builtin", (SWRLB.greaterThanOrEqual, [var_alter, Literal("4.0", datatype=XSD.decimal)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_alter, Literal("12.0", datatype=XSD.decimal)])),
                 ("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Anfänger")]))],
        "head": [("individual_prop", (hatAbgeleiteteZielgruppe, var_k, NS[to_uri_safe("Kinder - Einsteiger")]))]
    })
    # Original Rule 14 (ZielgruppeKinderFortgeschrittenFuerFortgeschrittene4bis12)
    rules_to_add.append({
        "name_numeric": 14,
        "comment": "Wenn Alter 4-12 und Erfahrung Fortgeschritten, dann Zielgruppe Kinder - Fortgeschritten.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAlter, var_k, var_alter)),
                 ("builtin", (SWRLB.greaterThanOrEqual, [var_alter, Literal("4.0", datatype=XSD.decimal)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_alter, Literal("12.0", datatype=XSD.decimal)])),
                 ("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Fortgeschritten")]))],
        "head": [("individual_prop", (hatAbgeleiteteZielgruppe, var_k, NS[to_uri_safe("Kinder - Fortgeschritten")]))]
    })
    # Original Rule 15 (ZielgruppeKinderFortgeschrittenFuerExperten4bis12)
    rules_to_add.append({
        "name_numeric": 15,
        "comment": "Wenn Alter 4-12 und Erfahrung Expert, dann Zielgruppe Kinder - Fortgeschritten.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAlter, var_k, var_alter)),
                 ("builtin", (SWRLB.greaterThanOrEqual, [var_alter, Literal("4.0", datatype=XSD.decimal)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_alter, Literal("12.0", datatype=XSD.decimal)])),
                 ("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Expert")]))],
        "head": [("individual_prop", (hatAbgeleiteteZielgruppe, var_k, NS[to_uri_safe("Kinder - Fortgeschritten")]))]
    })
    # Original Rule 16 (ZielgruppeJugendlicheEinsteigerFuerAnfaenger13bis18)
    rules_to_add.append({
        "name_numeric": 16,
        "comment": "Wenn Alter 13-18 und Erfahrung Anfänger, dann Zielgruppe Jugendliche - Einsteiger.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAlter, var_k, var_alter)),
                 ("builtin", (SWRLB.greaterThan, [var_alter, Literal("12.0", datatype=XSD.decimal)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_alter, Literal("18.0", datatype=XSD.decimal)])),
                 ("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Anfänger")]))],
        "head": [("individual_prop", (hatAbgeleiteteZielgruppe, var_k, NS[to_uri_safe("Jugendliche - Einsteiger")]))]
    })
    # Original Rule 17 (ZielgruppeJugendlicheFortgeschrittenFuerFortgeschrittene13bis18)
    rules_to_add.append({
        "name_numeric": 17,
        "comment": "Wenn Alter 13-18 und Erfahrung Fortgeschritten, dann Zielgruppe Jugendliche - Fortgeschritten.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAlter, var_k, var_alter)),
                 ("builtin", (SWRLB.greaterThan, [var_alter, Literal("12.0", datatype=XSD.decimal)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_alter, Literal("18.0", datatype=XSD.decimal)])),
                 ("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Fortgeschritten")]))],
        "head": [("individual_prop", (hatAbgeleiteteZielgruppe, var_k, NS[to_uri_safe("Jugendliche - Fortgeschritten")]))]
    })
    # Original Rule 18 (ZielgruppeJugendlicheFortgeschrittenFuerExperten13bis18)
    rules_to_add.append({
        "name_numeric": 18,
        "comment": "Wenn Alter 13-18 und Erfahrung Expert, dann Zielgruppe Jugendliche - Fortgeschritten.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAlter, var_k, var_alter)),
                 ("builtin", (SWRLB.greaterThan, [var_alter, Literal("12.0", datatype=XSD.decimal)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_alter, Literal("18.0", datatype=XSD.decimal)])),
                 ("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Expert")]))],
        "head": [("individual_prop", (hatAbgeleiteteZielgruppe, var_k, NS[to_uri_safe("Jugendliche - Fortgeschritten")]))]
    })
    # Original Rule 19 (ZielgruppeErwachseneEinsteigerFuerAnfaengerUeber18)
    rules_to_add.append({
        "name_numeric": 19,
        "comment": "Wenn Alter > 18 und Erfahrung Anfänger, dann Zielgruppe Erwachsene - Einsteiger.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAlter, var_k, var_alter)),
                 ("builtin", (SWRLB.greaterThan, [var_alter, Literal("18.0", datatype=XSD.decimal)])),
                 ("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Anfänger")]))],
        "head": [("individual_prop", (hatAbgeleiteteZielgruppe, var_k, NS[to_uri_safe("Erwachsene - Einsteiger")]))]
    })
    # Original Rule 20 (ZielgruppeErwachseneFortgeschrittenFuerFortgeschritteneUeber18)
    rules_to_add.append({
        "name_numeric": 20,
        "comment": "Wenn Alter > 18 und Erfahrung Fortgeschritten, dann Zielgruppe Erwachsene - Fortgeschritten.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAlter, var_k, var_alter)),
                 ("builtin", (SWRLB.greaterThan, [var_alter, Literal("18.0", datatype=XSD.decimal)])),
                 ("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Fortgeschritten")]))],
        "head": [("individual_prop", (hatAbgeleiteteZielgruppe, var_k, NS[to_uri_safe("Erwachsene - Fortgeschritten")]))]
    })
    # Original Rule 21 (ZielgruppeErwachseneExpertFuerExpertenUeber18)
    rules_to_add.append({
        "name_numeric": 21,
        "comment": "Wenn Alter > 18 und Erfahrung Expert, dann Zielgruppe Erwachsene - Expert.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (hatAlter, var_k, var_alter)),
                 ("builtin", (SWRLB.greaterThan, [var_alter, Literal("18.0", datatype=XSD.decimal)])),
                 ("individual_prop", (hatErfahrung, var_k, NS[to_uri_safe("Expert")]))],
        "head": [("individual_prop", (hatAbgeleiteteZielgruppe, var_k, NS[to_uri_safe("Erwachsene - Expert")]))]
    })
    # Original Rule 22 (SchwierigkeitEinfachKeineKomplexen)
    rules_to_add.append({
        "name_numeric": 22,
        "comment": "Präferenz Einfach: Menge<=1500, Zeit<=2, keine komplexen Bausteine.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (praeferiertBauteilmenge, var_k, var_menge)),
                 ("datavalued_prop", (praeferiertBauzeit, var_k, var_zeit)),
                 ("datavalued_prop", (praeferiertKomplexeBausteine, var_k, Literal("false", datatype=XSD.boolean))),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_menge, Literal(1500, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_zeit, Literal(2, datatype=XSD.integer)]))],
        "head": [("individual_prop", (hatGewuenschtenSchwierigkeitsgrad, var_k, NS[to_uri_safe("Einfach")]))]
    })
    # Original Rule 23 (SchwierigkeitMittelMitKomplexenBeiGeringerMengeZeit)
    rules_to_add.append({
        "name_numeric": 23,
        "comment": "Präferenz Mittel: Menge<=1500, Zeit<=2, mit komplexen Bausteinen.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (praeferiertBauteilmenge, var_k, var_menge)),
                 ("datavalued_prop", (praeferiertBauzeit, var_k, var_zeit)),
                 ("datavalued_prop", (praeferiertKomplexeBausteine, var_k, Literal("true", datatype=XSD.boolean))),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_menge, Literal(1500, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_zeit, Literal(2, datatype=XSD.integer)]))],
        "head": [("individual_prop", (hatGewuenschtenSchwierigkeitsgrad, var_k, NS[to_uri_safe("Mittel")]))]
    })
    # Original Rule 24 (SchwierigkeitMittelKeineKomplexenFall1)
    rules_to_add.append({
        "name_numeric": 24,
        "comment": "Präferenz Mittel (keine Komplexen): Menge >1500 & <=4000, Zeit <=2.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (praeferiertBauteilmenge, var_k, var_menge)),
                 ("datavalued_prop", (praeferiertBauzeit, var_k, var_zeit)),
                 ("datavalued_prop", (praeferiertKomplexeBausteine, var_k, Literal("false", datatype=XSD.boolean))),
                 ("builtin", (SWRLB.greaterThan, [var_menge, Literal(1500, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_menge, Literal(4000, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_zeit, Literal(2, datatype=XSD.integer)]))],
        "head": [("individual_prop", (hatGewuenschtenSchwierigkeitsgrad, var_k, NS[to_uri_safe("Mittel")]))]
    })
    # Original Rule 25 (SchwierigkeitMittelKeineKomplexenFall2)
    rules_to_add.append({
        "name_numeric": 25,
        "comment": "Präferenz Mittel (keine Komplexen): Menge <=1500, Zeit >2 & <=8.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (praeferiertBauteilmenge, var_k, var_menge)),
                 ("datavalued_prop", (praeferiertBauzeit, var_k, var_zeit)),
                 ("datavalued_prop", (praeferiertKomplexeBausteine, var_k, Literal("false", datatype=XSD.boolean))),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_menge, Literal(1500, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.greaterThan, [var_zeit, Literal(2, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_zeit, Literal(8, datatype=XSD.integer)]))],
        "head": [("individual_prop", (hatGewuenschtenSchwierigkeitsgrad, var_k, NS[to_uri_safe("Mittel")]))]
    })
    # Original Rule 26 (SchwierigkeitSchwerMitKomplexenFall1)
    rules_to_add.append({
        "name_numeric": 26,
        "comment": "Präferenz Schwer (mit Komplexen): Menge >1500 & <=4000, Zeit <=2.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (praeferiertBauteilmenge, var_k, var_menge)),
                 ("datavalued_prop", (praeferiertBauzeit, var_k, var_zeit)),
                 ("datavalued_prop", (praeferiertKomplexeBausteine, var_k, Literal("true", datatype=XSD.boolean))),
                 ("builtin", (SWRLB.greaterThan, [var_menge, Literal(1500, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_menge, Literal(4000, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_zeit, Literal(2, datatype=XSD.integer)]))],
        "head": [("individual_prop", (hatGewuenschtenSchwierigkeitsgrad, var_k, NS[to_uri_safe("Schwer")]))]
    })
    # Original Rule 27 (SchwierigkeitSchwerMitKomplexenFall2)
    rules_to_add.append({
        "name_numeric": 27,
        "comment": "Präferenz Schwer (mit Komplexen): Menge <=1500, Zeit >2 & <=8.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (praeferiertBauteilmenge, var_k, var_menge)),
                 ("datavalued_prop", (praeferiertBauzeit, var_k, var_zeit)),
                 ("datavalued_prop", (praeferiertKomplexeBausteine, var_k, Literal("true", datatype=XSD.boolean))),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_menge, Literal(1500, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.greaterThan, [var_zeit, Literal(2, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_zeit, Literal(8, datatype=XSD.integer)]))],
        "head": [("individual_prop", (hatGewuenschtenSchwierigkeitsgrad, var_k, NS[to_uri_safe("Schwer")]))]
    })
    # Original Rule 28 (SchwierigkeitSchwerKeineKomplexenFall1)
    rules_to_add.append({
        "name_numeric": 28,
        "comment": "Präferenz Schwer (keine Komplexen): Menge >4000, Zeit <=2.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (praeferiertBauteilmenge, var_k, var_menge)),
                 ("datavalued_prop", (praeferiertBauzeit, var_k, var_zeit)),
                 ("datavalued_prop", (praeferiertKomplexeBausteine, var_k, Literal("false", datatype=XSD.boolean))),
                 ("builtin", (SWRLB.greaterThan, [var_menge, Literal(4000, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_zeit, Literal(2, datatype=XSD.integer)]))],
        "head": [("individual_prop", (hatGewuenschtenSchwierigkeitsgrad, var_k, NS[to_uri_safe("Schwer")]))]
    })
    # Original Rule 29 (SchwierigkeitSchwerKeineKomplexenFall2)
    rules_to_add.append({
        "name_numeric": 29,
        "comment": "Präferenz Schwer (keine Komplexen): Menge <=1500, Zeit >8.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (praeferiertBauteilmenge, var_k, var_menge)),
                 ("datavalued_prop", (praeferiertBauzeit, var_k, var_zeit)),
                 ("datavalued_prop", (praeferiertKomplexeBausteine, var_k, Literal("false", datatype=XSD.boolean))),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_menge, Literal(1500, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.greaterThan, [var_zeit, Literal(8, datatype=XSD.integer)]))],
        "head": [("individual_prop", (hatGewuenschtenSchwierigkeitsgrad, var_k, NS[to_uri_safe("Schwer")]))]
    })
    # Original Rule 30 (SchwierigkeitSchwerKeineKomplexenFall3)
    rules_to_add.append({
        "name_numeric": 30,
        "comment": "Präferenz Schwer (keine Komplexen): Menge >1500 & <=4000, Zeit >2 & <=8.",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (praeferiertBauteilmenge, var_k, var_menge)),
                 ("datavalued_prop", (praeferiertBauzeit, var_k, var_zeit)),
                 ("datavalued_prop", (praeferiertKomplexeBausteine, var_k, Literal("false", datatype=XSD.boolean))),
                 ("builtin", (SWRLB.greaterThan, [var_menge, Literal(1500, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_menge, Literal(4000, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.greaterThan, [var_zeit, Literal(2, datatype=XSD.integer)])),
                 ("builtin", (SWRLB.lessThanOrEqual, [var_zeit, Literal(8, datatype=XSD.integer)]))],
        "head": [("individual_prop", (hatGewuenschtenSchwierigkeitsgrad, var_k, NS[to_uri_safe("Schwer")]))]
    })
    # Original Rule 31 (SchwierigkeitSchwerMitKomplexenFallbackMenge)
    rules_to_add.append({
        "name_numeric": 31,
        "comment": "Präferenz Schwer (mit Komplexen): Menge > 1500 (Fallback für nicht Mittel).",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (praeferiertBauteilmenge, var_k, var_menge)),
                 ("datavalued_prop", (praeferiertKomplexeBausteine, var_k, Literal("true", datatype=XSD.boolean))),
                 ("builtin", (SWRLB.greaterThan, [var_menge, Literal(1500, datatype=XSD.integer)]))],
        "head": [("individual_prop", (hatGewuenschtenSchwierigkeitsgrad, var_k, NS[to_uri_safe("Schwer")]))]
    })
    # Original Rule 32 (SchwierigkeitSchwerMitKomplexenFallbackZeit)
    rules_to_add.append({
        "name_numeric": 32,
        "comment": "Präferenz Schwer (mit Komplexen): Zeit > 2 (Fallback für nicht Mittel).",
        "body": [("class", (Kunde, var_k)),
                 ("datavalued_prop", (praeferiertBauzeit, var_k, var_zeit)),
                 ("datavalued_prop", (praeferiertKomplexeBausteine, var_k, Literal("true", datatype=XSD.boolean))),
                 ("builtin", (SWRLB.greaterThan, [var_zeit, Literal(2, datatype=XSD.integer)]))],
        "head": [("individual_prop", (hatGewuenschtenSchwierigkeitsgrad, var_k, NS[to_uri_safe("Schwer")]))]
    })
    # Original Rule 33 (ThemenweltTechnikFuerFahrzeugeOhneLizenz)
    rules_to_add.append({
        "name_numeric": 33,
        "comment": "Interesse Fahrzeuge, keine Lizenz -> Themenwelt Technik.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Fahrzeuge")])),
                 ("datavalued_prop", (wuenschtLizenz, var_k, Literal("false", datatype=XSD.boolean)))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Technik")]))]
    })
    # Original Rule 34 (ThemenweltStarWarsFuerFahrzeugeMitLizenz)
    rules_to_add.append({
        "name_numeric": 34,
        "comment": "Interesse Fahrzeuge, mit Lizenz -> Themenwelt Star Wars.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Fahrzeuge")])),
                 ("datavalued_prop", (wuenschtLizenz, var_k, Literal("true", datatype=XSD.boolean)))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Star Wars")]))]
    })
    # Original Rule 35 (ThemenweltDisneyFuerInteresseDisney)
    rules_to_add.append({
        "name_numeric": 35,
        "comment": "Interesse Disney -> Themenwelt Disney.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Disney")]))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Disney")]))]
    })
    # Original Rule 36 (ThemenweltMarvelFuerInteresseSuperheroes)
    rules_to_add.append({
        "name_numeric": 36,
        "comment": "Interesse Superheroes -> Themenwelt Marvel.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Superheroes")]))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Marvel")]))]
    })
    # Original Rule 37 (ThemenweltArchitekturFuerInteresseArchitektur)
    rules_to_add.append({
        "name_numeric": 37,
        "comment": "Interesse Architektur -> Themenwelt Architektur.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Architektur")]))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Architektur")]))]
    })
    # Original Rule 38 (ThemenweltCreatorFuerSciFiOhneLizenz)
    rules_to_add.append({
        "name_numeric": 38,
        "comment": "Interesse Sci-Fi, keine Lizenz -> Themenwelt Creator.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Sci-Fi")])),
                 ("datavalued_prop", (wuenschtLizenz, var_k, Literal("false", datatype=XSD.boolean)))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Creator")]))]
    })
    # Original Rule 39 (ThemenweltStarWarsFuerSciFiMitLizenz)
    rules_to_add.append({
        "name_numeric": 39,
        "comment": "Interesse Sci-Fi, mit Lizenz -> Themenwelt Star Wars.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Sci-Fi")])),
                 ("datavalued_prop", (wuenschtLizenz, var_k, Literal("true", datatype=XSD.boolean)))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Star Wars")]))]
    })
    # Original Rule 40 (ThemenweltCityFuerKinderserieOhneLizenz)
    rules_to_add.append({
        "name_numeric": 40,
        "comment": "Interesse Kinderserie / Film, keine Lizenz -> Themenwelt City.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Kinderserie / Film")])),
                 ("datavalued_prop", (wuenschtLizenz, var_k, Literal("false", datatype=XSD.boolean)))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("City")]))]
    })
    # Original Rule 41 (ThemenweltDisneyFuerKinderserieMitLizenz)
    rules_to_add.append({
        "name_numeric": 41,
        "comment": "Interesse Kinderserie / Film, mit Lizenz -> Themenwelt Disney.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Kinderserie / Film")])),
                 ("datavalued_prop", (wuenschtLizenz, var_k, Literal("true", datatype=XSD.boolean)))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Disney")]))]
    })
    # Original Rule 42 (ThemenweltNinjagoFuerInteresseNinjas)
    rules_to_add.append({
        "name_numeric": 42,
        "comment": "Interesse Ninjas -> Themenwelt Ninjago.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Ninjas")]))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Ninjago")]))]
    })
    # Original Rule 43 (ThemenweltMinecraftFuerInteresseGaming)
    rules_to_add.append({
        "name_numeric": 43,
        "comment": "Interesse Gaming -> Themenwelt Minecraft.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Gaming")]))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Minecraft")]))]
    })
    # Original Rule 44 (ThemenweltTechnikFuerSportOhneLizenz)
    rules_to_add.append({
        "name_numeric": 44,
        "comment": "Interesse Sport, keine Lizenz -> Themenwelt Technik.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Sport")])),
                 ("datavalued_prop", (wuenschtLizenz, var_k, Literal("false", datatype=XSD.boolean)))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Technik")]))]
    })
    # Original Rule 45 (ThemenweltCreatorFuerSportMitLizenz)
    rules_to_add.append({
        "name_numeric": 45,
        "comment": "Interesse Sport, mit Lizenz -> Themenwelt Creator.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Sport")])),
                 ("datavalued_prop", (wuenschtLizenz, var_k, Literal("true", datatype=XSD.boolean)))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Creator")]))]
    })
    # Original Rule 46 (ThemenweltFriendsFuerInteresseTierNatur)
    rules_to_add.append({
        "name_numeric": 46,
        "comment": "Interesse Tier/Natur -> Themenwelt Friends.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Tier/Natur")]))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Friends")]))]
    })
    # Original Rule 47 (ThemenweltCityFuerAbenteuerOhneLizenz)
    rules_to_add.append({
        "name_numeric": 47,
        "comment": "Interesse Abenteuer, keine Lizenz -> Themenwelt City.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Abenteuer")])),
                 ("datavalued_prop", (wuenschtLizenz, var_k, Literal("false", datatype=XSD.boolean)))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("City")]))]
    })
    # Original Rule 48 (ThemenweltHarryPotterFuerAbenteuerMitLizenz)
    rules_to_add.append({
        "name_numeric": 48,
        "comment": "Interesse Abenteuer, mit Lizenz -> Themenwelt Harry Potter.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Abenteuer")])),
                 ("datavalued_prop", (wuenschtLizenz, var_k, Literal("true", datatype=XSD.boolean)))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Harry Potter")]))]
    })
    # Original Rule 49 (ThemenweltArchitekturFuerHistorischeEpochen)
    rules_to_add.append({
        "name_numeric": 49,
        "comment": "Interesse Historische Epochen -> Themenwelt Architektur.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Historische Epochen")]))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Architektur")]))]
    })
    # Original Rule 50 (ThemenweltCreatorFuerFantasyOhneLizenz)
    rules_to_add.append({
        "name_numeric": 50,
        "comment": "Interesse Fantasy, keine Lizenz -> Themenwelt Creator.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Fantasy")])),
                 ("datavalued_prop", (wuenschtLizenz, var_k, Literal("false", datatype=XSD.boolean)))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Creator")]))]
    })
    # Original Rule 51 (ThemenweltHarryPotterFuerFantasyMitLizenz)
    rules_to_add.append({
        "name_numeric": 51,
        "comment": "Interesse Fantasy, mit Lizenz -> Themenwelt Harry Potter.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Fantasy")])),
                 ("datavalued_prop", (wuenschtLizenz, var_k, Literal("true", datatype=XSD.boolean)))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Harry Potter")]))]
    })
    # Original Rule 52 (ThemenweltClassicFuerSimplesSpielen)
    rules_to_add.append({
        "name_numeric": 52,
        "comment": "Interesse Simples Spielen -> Themenwelt Classic.",
        "body": [("class", (Kunde, var_k)),
                 ("individual_prop", (hatKundenInteresse, var_k, NS[to_uri_safe("Simples Spielen")]))],
        "head": [("individual_prop", (hatBevorzugteThemenwelt, var_k, NS[to_uri_safe("Classic")]))]
    })

    # Sort rules by their numeric part of the name for sequential definition in the script
    # This step is implicitly handled by defining them in order S1, S2...
    # Now add them to the graph using the new "S" names
    for rule_def in rules_to_add:
        rule_s_name = f"S{rule_def['name_numeric']}"
        add_swrl_rule(g, rule_s_name, rule_def["comment"], rule_def["body"], rule_def["head"])

    print(f"DEBUG: Graph has {len(g)} triples before serialization.")

    print(f"DEBUG: Attempting to serialize to: {output_filepath}") # HINZUGEFÜGT
    try:
        g.serialize(destination=output_filepath, format="xml", encoding="utf-8")
        print(f"DEBUG: Serialization supposedly complete. Check file: {output_filepath}") # HINZUGEFÜGT
    except Exception as e:
        print(f"ERROR DURING SERIALIZATION: {e}") # HINZUGEFÜGT

if __name__ == "__main__":
    print("DEBUG: Script execution started in __main__.") # HINZUGEFÜGT
    print(f"DEBUG: Attempting to read Prolog file: {PROLOG_FILE_PATH}") # HINZUGEFÜGT
    parsed_data = parse_prolog_file(PROLOG_FILE_PATH)
    print(f"DEBUG: Prolog parsing complete. Data keys: {list(parsed_data.keys())}") # HINZUGEFÜGT
    
    print(f"DEBUG: Attempting to generate OWL ontology to: {OWL_OUTPUT_FILE_PATH}") # HINZUGEFÜGT
    create_owl_ontology(parsed_data, OWL_OUTPUT_FILE_PATH)
    print("DEBUG: Script execution finished in __main__.") # HINZUGEFÜGT