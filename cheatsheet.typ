#import "shared.typ": *
#show: cheatsheet

// ── page 1 ───────────────────────────────────────────────────────────────────

#page-title[Verbi Italiani — Coniugazione][PRESENTE]

// ── two-column body ──────────────────────────────────────────────────────────

#columns(2, gutter: 0.9cm)[

// ── parlare ──────────────────────────────────────────────────────────────────
#verb-section(
  "parlare", "sprechen", "verbi in -are",
  (
    ("io",      "parlo"),
    ("tu",      "parli"),
    ("lui/lei", "parla"),
    ("noi",     "parliamo"),
    ("voi",     "parlate"),
    ("loro",    "parlano"),
  ),
  (
    ("tense": "Presente", "text": "Ogni giorno parlo con mia madre."),
  ),
)

// ── ripetere ──────────────────────────────────────────────────────────────────
#verb-section(
  "ripetere", "wiederholen", "verbi in -ere",
  (
    ("io",      "ripeto"),
    ("tu",      "ripeti"),
    ("lui/lei", "ripete"),
    ("noi",     "ripetiamo"),
    ("voi",     "ripetete"),
    ("loro",    "ripetono"),
  ),
  (
    ("tense": "Presente", "text": "Ripeto la domanda per chi non ha sentito."),
  ),
)

// ── sentire ──────────────────────────────────────────────────────────────────
#verb-section(
  "sentire", "hören/fühlen", "verbi in -ire (tipo I)",
  (
    ("io",      "sento"),
    ("tu",      "senti"),
    ("lui/lei", "sente"),
    ("noi",     "sentiamo"),
    ("voi",     "sentite"),
    ("loro",    "sentono"),
  ),
  (
    ("tense": "Presente", "text": "Sento la musica dalla finestra."),
  ),
)

// ── finire ───────────────────────────────────────────────────────────────────
#verb-section(
  "finire", "beenden", "verbi in -ire (tipo II, -isc-)",
  (
    ("io",      [finisco #text(fill: ink-sec, size: 7pt)[†]]),
    ("tu",      [finisci #text(fill: ink-sec, size: 7pt)[†]]),
    ("lui/lei", [finisce #text(fill: ink-sec, size: 7pt)[†]]),
    ("noi",     "finiamo"),
    ("voi",     "finite"),
    ("loro",    [finiscono #text(fill: ink-sec, size: 7pt)[†]]),
  ),
  (
    ("tense": "Presente", "text": "Finisco il lavoro alle cinque."),
  ),
)

#ann[† infisso -isc- in io/tu/lui/loro al Presente; assente in noi/voi. Stessa struttura: capire, preferire, costruire.]

#v(5pt)

// ── essere ───────────────────────────────────────────────────────────────────
#verb-section(
  "essere", "sein", "ausiliare",
  (
    ("io",      "sono"),
    ("tu",      "sei"),
    ("lui/lei", [è]),
    ("noi",     "siamo"),
    ("voi",     "siete"),
    ("loro",    "sono"),
  ),
  (
    ("tense": "Presente", "text": "Sono stanco dopo il lavoro."),
  ),
)

#ann[Participio: stato · stata · stati · state. Con essere il participio concorda con il soggetto.]

#v(5pt)

// ── avere ────────────────────────────────────────────────────────────────────
#verb-section(
  "avere", "haben", "ausiliare",
  (
    ("io",      "ho"),
    ("tu",      "hai"),
    ("lui/lei", "ha"),
    ("noi",     "abbiamo"),
    ("voi",     "avete"),
    ("loro",    "hanno"),
  ),
  (
    ("tense": "Presente", "text": "Ho molti libri a casa."),
  ),
)

// ── fare ─────────────────────────────────────────────────────────────────────
#verb-section(
  "fare", "machen/tun", "irregolare",
  (
    ("io",      "faccio"),
    ("tu",      "fai"),
    ("lui/lei", "fa"),
    ("noi",     "facciamo"),
    ("voi",     "fate"),
    ("loro",    "fanno"),
  ),
  (
    ("tense": "Presente", "text": "Faccio colazione alle sette."),
  ),
)

// ── volere ───────────────────────────────────────────────────────────────────
#verb-section(
  "volere", "wollen", "modale",
  (
    ("io",      "voglio"),
    ("tu",      "vuoi"),
    ("lui/lei", "vuole"),
    ("noi",     "vogliamo"),
    ("voi",     "volete"),
    ("loro",    "vogliono"),
  ),
  (
    ("tense": "Presente", "text": "Voglio un caffè, per favore."),
  ),
)

// ── potere ───────────────────────────────────────────────────────────────────
#verb-section(
  "potere", "können/dürfen", "modale",
  (
    ("io",      "posso"),
    ("tu",      "puoi"),
    ("lui/lei", [può]),
    ("noi",     "possiamo"),
    ("voi",     "potete"),
    ("loro",    "possono"),
  ),
  (
    ("tense": "Presente", "text": "Posso aprire la finestra?"),
  ),
)

// ── dovere ───────────────────────────────────────────────────────────────────
#verb-section(
  "dovere", "müssen/sollen", "modale",
  (
    ("io",      "devo"),
    ("tu",      "devi"),
    ("lui/lei", "deve"),
    ("noi",     "dobbiamo"),
    ("voi",     "dovete"),
    ("loro",    "devono"),
  ),
  (
    ("tense": "Presente", "text": "Devo studiare per l'esame."),
  ),
)

// ── dire ─────────────────────────────────────────────────────────────────────
#verb-section(
  "dire", "sagen", "irregolare",
  (
    ("io",      "dico"),
    ("tu",      "dici"),
    ("lui/lei", "dice"),
    ("noi",     "diciamo"),
    ("voi",     "dite"),
    ("loro",    "dicono"),
  ),
  (
    ("tense": "Presente", "text": "Dico sempre la verità."),
  ),
)

// ── andare · venire · uscire · stare ─────────────────────────────────────────
#verb-compare(
  "irregolare (essere)",
  (
    ("andare", "gehen"),
    ("venire", "kommen"),
    ("uscire", "ausgehen"),
    ("stare",  "sich befinden"),
  ),
  (
    ("io",      "vado",    "vengo",    "esco",    "sto"),
    ("tu",      "vai",     "vieni",    "esci",    "stai"),
    ("lui/lei", [va],      "viene",    "esce",    "sta"),
    ("noi",     "andiamo", "veniamo",  "usciamo", "stiamo"),
    ("voi",     "andate",  "venite",   "uscite",  "state"),
    ("loro",    "vanno",   "vengono",  "escono",  "stanno"),
  ),
)

// ── dare · sapere · bere · vedere ────────────────────────────────────────────
#verb-compare(
  "irregolare (avere)",
  (
    ("dare",   "geben"),
    ("sapere", "wissen"),
    ("bere",   "trinken"),
    ("vedere", "sehen"),
  ),
  (
    ("io",      [do],      "so",       "bevo",    "vedo"),
    ("tu",      "dai",     "sai",      "bevi",    "vedi"),
    ("lui/lei", [dà],      "sa",       "beve",    "vede"),
    ("noi",     "diamo",   "sappiamo", "beviamo", "vediamo"),
    ("voi",     "date",    "sapete",   "bevete",  "vedete"),
    ("loro",    "danno",   "sanno",    "bevono",  "vedono"),
  ),
)

] // end columns

// ── vocabulary page ───────────────────────────────────────────────────────────
#pagebreak()

#page-title[Vocabolario Comune][VERBI FREQUENTI]

#columns(2, gutter: 0.9cm)[

#vocab-group("Kommunikation", (
  ("ascoltare",  "zuhören"),
  ("leggere",    "lesen"),
  ("guardare",   "schauen / ansehen"),
  ("capire",     "verstehen"),
  ("rispondere", "antworten"),
  ("chiedere",   "fragen / bitten"),
  ("chiamare",   "anrufen"),
  ("incontrare", "treffen"),
))

#vocab-group("Bewegung", (
  ("entrare",    "eintreten"),
  ("tornare",    "zurückkehren"),
  ("arrivare",   "ankommen"),
  ("partire",    "abreisen / abfahren"),
  ("camminare",  "gehen / laufen",  "auch funktional: la macchina cammina bene (das Auto läuft gut)"),
  ("passeggiare","spazieren gehen"),
  ("correre",    "rennen / laufen"),
  ("portare",    "tragen / bringen"),
  ("prendere",   "nehmen / mitnehmen"),
))

#vocab-group("Alltag", (
  ("mangiare",   "essen"),
  ("dormire",    "schlafen"),
  ("lavorare",   "arbeiten"),
  ("studiare",   "studieren / lernen"),
  ("comprare",   "kaufen"),
  ("aprire",     "öffnen"),
  ("chiudere",   "schließen"),
  ("cucinare",   "kochen"),
))

#vocab-group("Denken & Fühlen", (
  ("pensare",    "denken / nachdenken"),
  ("credere",    "glauben / meinen"),
  ("ricordare",  "erinnern"),
  ("dimenticare","vergessen"),
  ("sperare",    "hoffen"),
  ("preferire",  "bevorzugen"),
  ("amare",      "lieben"),
  ("piacere",    "gefallen"),
))

#vocab-group("Handlungen", (
  ("trovare",    "finden"),
  ("perdere",    "verlieren"),
  ("mettere",    "legen / stellen"),
  ("lasciare",   "lassen / verlassen",  "lasciarsi (riflessivo) = sich trennen: ci siamo lasciati"),
  ("usare",      "benutzen"),
  ("provare",    "versuchen / ausprobieren"),
  ("aiutare",    "helfen"),
  ("aspettare",  "warten"),
))

#vocab-group("Küche & Zubereitung", (
  ("preparare",  "vorbereiten / zubereiten"),
  ("tagliare",   "schneiden"),
  ("aggiungere", "hinzufügen / dazugeben"),
  ("versare",    "eingießen / schütten"),
  ("mescolare",  "mischen / rühren"),
))

#vocab-group("Kennen & Lehren", (
  ("vedere",    "sehen"),
  ("conoscere", "kennen"),
  ("imparare",  "lernen"),
  ("insegnare", "lehren / unterrichten"),
  ("spiegare",  "erklären"),
  ("mostrare",  "zeigen"),
  ("ricevere",  "erhalten / bekommen"),
  ("ripetere",  "wiederholen"),
  ("seguire",   "folgen / verfolgen"),
))

#vocab-group("Alltag & Freizeit", (
  ("vivere",    "leben"),
  ("abitare",   "wohnen"),
  ("pagare",    "bezahlen"),
  ("cambiare",  "ändern / wechseln"),
  ("passare",   "vorbeigehen / verbringen"),
  ("cantare",   "singen"),
  ("ballare",   "tanzen"),
  ("viaggiare", "reisen"),
  ("suonare",   "spielen (Instrument)"),
))

#vocab-group("Zustand & Veränderung", (
  ("diventare",  "werden"),
  ("sembrare",   "wirken / scheinen"),
  ("restare",    "bleiben"),
  ("cominciare", "anfangen / beginnen"),
  ("continuare", "weitermachen"),
  ("smettere",   "aufhören"),
  ("succedere",  "passieren / geschehen"),
  ("riuscire",   "schaffen / gelingen"),
  ("vendere",    "verkaufen"),
  ("giocare",    "spielen"),
  ("convivere",  "zusammenleben"),
))

#vocab-group("Verbi Riflessivi", (
  ("chiamarsi",     "heißen",               "come ti chiami? — wie heißt du?"),
  ("svegliarsi",    "aufwachen"),
  ("alzarsi",       "aufstehen"),
  ("lavarsi",       "sich waschen"),
  ("vestirsi",      "sich anziehen"),
  ("sedersi",       "sich setzen / hinsetzen"),
  ("addormentarsi", "einschlafen"),
  ("sentirsi",      "sich fühlen",           "come ti senti? — wie fühlst du dich?"),
  ("trovarsi",      "sich befinden"),
  ("innamorarsi",   "sich verlieben",        "innamorarsi di qualcuno"),
  ("divertirsi",    "sich amüsieren / Spaß haben"),
  ("arrabbiarsi",   "sich ärgern"),
  ("annoiarsi",     "sich langweilen"),
  ("interessarsi",  "sich interessieren",    "interessarsi di qualcosa"),
  ("preoccuparsi",  "sich sorgen",           "preoccuparsi per qualcuno"),
  ("sbagliarsi",    "sich irren"),
  ("laurearsi",     "einen Hochschulabschluss machen", "mi sono laureato/a in medicina · la laurea = der Abschluss"),
))

#ann[Verbi riflessivi: Hilfsverb immer essere — Partizip kongruiert mit dem Subjekt: mi sono vestito (m.) / vestita (f.), ti sei vestito/a, si è vestito/a… Pronomen: mi · ti · si · ci · vi · si (vor dem Verb).]

#v(4pt)

] // end vocab columns

// ── preposizioni articolate page ──────────────────────────────────────────────
#pagebreak()

#page-title[Preposizioni Articolate][PRÄPOSITION + BESTIMMTER ARTIKEL]

#set text(size: 7.5pt)
#table(
  columns: (0.7cm, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  align: center,
  inset: (x: 4pt, y: 4pt),
  stroke: (_, y) => (
    top:    none,
    left:   none,
    right:  none,
    bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border },
  ),
  fill: (_, row) => if row == 0 { surface } else { white },
  table.header(
    [],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[IL],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[LO],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[LA],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[L'],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[I],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[GLI],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[LE],
  ),
  text(weight: 600, fill: accent)[a],   [al],  [allo],  [alla],  [all'],  [ai],  [agli],  [alle],
  text(weight: 600, fill: accent)[di],  [del], [dello], [della], [dell'],[dei], [degli], [delle],
  text(weight: 600, fill: accent)[in],  [nel], [nello], [nella], [nell'],[nei], [negli], [nelle],
  text(weight: 600, fill: accent)[da],  [dal], [dallo], [dalla], [dall'],[dai], [dagli], [dalle],
  text(weight: 600, fill: accent)[su],  [sul], [sullo], [sulla], [sull'],[sui], [sugli], [sulle],
  text(weight: 600, fill: accent)[con], [col], text(fill: ink-sec)[—], text(fill: ink-sec)[—], text(fill: ink-sec)[—], [coi], text(fill: ink-sec)[—], text(fill: ink-sec)[—],
)
#set text(size: 8pt)

#v(5pt)
#text(size: 7pt, fill: ink-sec)[
  *Artikelwahl:* il/i → mask. vor Konsonant · lo/gli → mask. vor s+Kons., z, gn, ps, x, y · la/le → fem. · l' → mask./fem. vor Vokal. #linebreak()
  *con:* nur col (con + il) und coi (con + i) gebräuchlich; übrige Formen werden ausgeschrieben (con lo, con la…). #linebreak()
  *per, tra, fra:* keine Verschmelzung mit dem Artikel.
]

#v(8pt)
#line(length: 100%, stroke: 0.4pt + border)
#v(6pt)
#text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[VERWENDUNG DER PRÄPOSITIONEN]
#v(6pt)

// ── prep usage notes ──────────────────────────────────────────────────────────

#columns(2, gutter: 0.9cm)[

#prep-entry("a", (
  ("Städte (Ort + Ziel):", "sono a Roma · vado a Roma"),
  ("Uhrzeit:", "alle tre (um drei Uhr)"),
  ("indir. Objekt:", "do il libro a Marco"),
  ("Entfernung:", "a due km da qui"),
))

#prep-entry("di", (
  ("Besitz / Zugehörigkeit:", "il libro di Marco"),
  ("Herkunft (Städte):", "sono di Milano"),
  ("Thema:", "parlare di sport"),
  ("Material:", "una borsa di pelle"),
))

#prep-entry("in", (
  ("Länder, Regionen, Räume:", "sono/vado in Italia · in cucina"),
  ("Verkehrsmittel:", "in macchina · in treno · in aereo"),
  ("Jahreszeiten / Monate:", "in estate · in gennaio"),
  ("⚠ a vs. in:", "a + Städte — in + Länder/Regionen/Räume"),
))

#prep-entry("da", (
  ("seit (Dauer bis jetzt):", "abito qui da tre anni"),
  ("Herkunft / Ausgangspunkt:", "vengo da Roma"),
  ("bei jemandem:", "sono da Marco (ich bin bei Marco)"),
  ("Verwendungszweck:", "una tazza da tè"),
  ("⚠ seit:", "da tre anni — nicht seit = vor!"),
))

#colbreak()

#prep-entry("su", (
  ("auf (Oberfläche):", "il libro è sul tavolo"),
  ("über (Thema):", "un libro sulla storia"),
  ("ungefähre Angabe:", "costa sui 20 euro"),
))

#prep-entry("con", (
  ("Begleitung:", "vengo con te"),
  ("Mittel / Instrument:", "scrivo con la penna"),
))

#prep-entry("per", (
  ("Zweck / Empfänger:", "un regalo per te · studio per l'esame"),
  ("Richtung / Ziel:", "il treno per Roma"),
  ("abgeschl. Dauer:", "ho lavorato per tre anni"),
))

#prep-entry("tra / fra", (
  ("zwischen:", "tra te e me · fra due città"),
  ("in … Zeit (Zukunft):", "tra due giorni (in zwei Tagen)"),
  ("⚠ Achtung:", "tra due giorni ≠ in due giorni"),
  ("tra = fra:", "bedeutungsgleich, beliebig austauschbar"),
))

] // end prep-usage columns

// ── i tempi verbali page ──────────────────────────────────────────────────────
#pagebreak()

#page-title[I Tempi Verbali][GEBRAUCHSREGELN — PRESENTE]
#v(1pt)

#tense-block("Presente", "Gegenwart / Gewohnheit / nahe Zukunft", (
  ("Gegenwärtiger Zustand oder Handlung",
   "Sono stanco. · Lavoro in ufficio."),
  ("Gewohnheit oder Wiederholung",
   "Ogni mattina bevo un caffè."),
  ("Allgemeine Wahrheit",
   "Il sole sorge a est."),
  ("Nahe Zukunft mit Zeitangabe",
   "Domani vado a Roma."),
  ("Seit-Konstruktion: da + Presente",
   "Studio l'italiano da due anni. (Ich lerne seit zwei Jahren Italienisch — und tue es noch.)"),
))

// ── gerundio & progressivo ────────────────────────────────────────────────────
#v(4pt)
#line(length: 100%, stroke: 0.4pt + border)
#v(5pt)
#text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: accent)[GERUNDIO & PROGRESSIVO]
#v(5pt)

#grid(columns: (1fr, 1fr), gutter: 0.9cm,
  block(breakable: false)[
    #text(size: 7pt, weight: 500)[Bildung: Infinitivstamm + Endung]
    #v(3pt)
    #set text(size: 7.5pt)
    #table(
      columns: (1.5cm, 1.2cm, 1fr),
      align: left,
      inset: (x: 4pt, y: 3pt),
      stroke: (_, y) => (
        top: none, left: none, right: none,
        bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border },
      ),
      fill: (_, y) => if y == 0 { surface } else { white },
      table.header(
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[TYP],
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[ENDUNG],
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[BEISPIEL],
      ),
      [-are], text(weight: 600, fill: accent)[-ando], [parlare → parlando],
      [-ere], text(weight: 600, fill: accent)[-endo], [ripetere → ripetendo],
      [-ire], text(weight: 600, fill: accent)[-endo], [sentire → sentendo],
    )
    #v(4pt)
    #text(size: 7pt, fill: ink-sec)[Unregelmäßig: fare → #text(fill: ink)[facendo] · dire → #text(fill: ink)[dicendo] · bere → #text(fill: ink)[bevendo]]
  ],
  block(breakable: false)[
    #text(size: 7pt, weight: 500)[stare + gerundio — laufende Handlung]
    #v(4pt)
    #block(inset: (bottom: 3pt))[
      #text(size: 7pt, weight: 500)[Gegenwart (Progressivo presente)]
      #linebreak()
      #text(size: 7pt, style: "italic", fill: ink-sec)[Sto mangiando. (Ich esse gerade.)]
    ]
    #block(inset: (bottom: 3pt))[
      #text(size: 7pt, weight: 500)[Vergangenheit (Progressivo passato)]
      #linebreak()
      #text(size: 7pt, style: "italic", fill: ink-sec)[Stavo leggendo quando è arrivato Marco.]
      #linebreak()
      #text(size: 7pt, fill: ink-sec)[stavo · stavi · stava · stavamo · stavate · stavano + gerundio]
    ]
    #block[
      #text(size: 7pt, weight: 500)[sto mangiando vs. mangio]
      #linebreak()
      #text(size: 7pt, fill: ink-sec)[Progressivo = gerade jetzt; Presente = generell / gewohnheitsmäßig.]
    ]
  ],
)

// ── imperativo section ────────────────────────────────────────────────────────
#v(8pt)
#line(length: 100%, stroke: 0.4pt + border)
#v(5pt)
#text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: accent)[IMPERATIVO]
#v(5pt)

#grid(columns: (1fr, 1fr), gutter: 0.9cm,
  block(breakable: false)[
    #text(size: 7pt, weight: 500)[Bildung: Infinitiv − re = Stamm + Endung]
    #v(3pt)
    #set text(size: 7.5pt)
    #table(
      columns: (2cm, 1.2cm, 1fr),
      align: left,
      inset: (x: 4pt, y: 3pt),
      stroke: (_, y) => (
        top: none, left: none, right: none,
        bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border },
      ),
      fill: (_, y) => if y == 0 { surface } else { white },
      table.header(
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[TYP],
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[ENDUNG],
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[BEISPIELE],
      ),
      [-are], text(weight: 600, fill: accent)[-a],    [parla! · mangia! · studia!],
      [-ere], text(weight: 600, fill: accent)[-i],    [ripeti! · vendi! · ricevi!],
      [-ire (I)], text(weight: 600, fill: accent)[-i],    [senti! · dormi! · parti!],
      [-ire (II)], text(weight: 600, fill: accent)[-isci], [finisci! · capisci!],
    )
    #v(5pt)
    #text(size: 7pt, weight: 500)[Verneinung: non + Infinitiv]
    #linebreak()
    #text(size: 7pt, style: "italic")[parla! → non parlare! · vieni! → non venire!]
  ],
  block(breakable: false)[
    #text(size: 7pt, weight: 500)[Unregelmäßige Formen]
    #v(3pt)
    #set text(size: 7.5pt)
    #table(
      columns: (1fr, 1fr),
      align: left,
      inset: (x: 4pt, y: 3pt),
      stroke: (_, y) => (
        top: none, left: none, right: none,
        bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border },
      ),
      fill: (_, y) => if y == 0 { surface } else { white },
      table.header(
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[INFINITIV],
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[IMPERATIVO],
      ),
      [andare], text(weight: 600, fill: accent)[va'  #text(weight: 400, fill: ink-sec, size: 6.5pt)[(/ vai)]],
      [dare],   text(weight: 600, fill: accent)[da'  #text(weight: 400, fill: ink-sec, size: 6.5pt)[(/ dai)]],
      [dire],   text(weight: 600, fill: accent)[di'],
      [essere], text(weight: 600, fill: accent)[sii],
      [avere],  text(weight: 600, fill: accent)[abbi],
      [fare],   text(weight: 600, fill: accent)[fa'  #text(weight: 400, fill: ink-sec, size: 6.5pt)[(/ fai)]],
      [stare],  text(weight: 600, fill: accent)[sta' #text(weight: 400, fill: ink-sec, size: 6.5pt)[(/ stai)]],
      [venire], text(weight: 600, fill: accent)[vieni],
    )
  ],
) // end imperativo grid

// ── imperativo voi ────────────────────────────────────────────────────────────
#block(breakable: false)[
#v(5pt)
#line(length: 100%, stroke: 0.3pt + border)
#v(4pt)

#grid(columns: (1fr, 1fr), gutter: 0.9cm,
  block[
    #text(size: 7pt, weight: 500)[Imperativo voi — gleich wie Presente (voi)]
    #v(2pt)
    #text(size: 7pt, style: "italic")[parlate! · ripetete! · sentite! · finite!]
    #v(3pt)
    #text(size: 7pt, fill: ink-sec)[Gilt für alle regelmäßigen Verben ohne Ausnahme.]
  ],
  block[
    #text(size: 7pt, weight: 500)[Unregelmäßige voi-Formen]
    #v(2pt)
    #text(size: 7pt, style: "italic")[essere → #text(weight: 600, fill: accent)[siate!] · avere → #text(weight: 600, fill: accent)[abbiate!] · sapere → #text(weight: 600, fill: accent)[sappiate!]]
    #v(2pt)
    #text(size: 7pt, fill: ink-sec)[Alle übrigen (andare, fare, dare, dire, venire…) = reguläre Presente-voi-Form.]
  ],
)
] // end imperativo voi

// ── pronuncia ─────────────────────────────────────────────────────────────────
#let lb = "\u{5B}"
#let rb = "\u{5D}"

#pagebreak()

#block(width: 100%)[
  #text(size: 11pt, weight: 600, tracking: 0.03em)[Pronuncia]
  #h(10pt)
  #text(size: 7pt, weight: 500, tracking: 0.1em, fill: ink-sec)[AUSSPRACHEREGELN — KONSONANTEN · VOKALE · BETONUNG]
]
#line(length: 100%, stroke: 0.3pt + border)
#v(8pt)

#block(breakable: false)[
  #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: accent)[#upper[Konsonanten & Sonderzeichen]]
  #v(3pt)
  #set text(size: 7pt)
  #table(
    columns: (1.3cm, 2cm, 1.4cm, 1fr),
    align: left,
    inset: (x: 4pt, y: 3.5pt),
    stroke: (_, y) => (
      top:    none,
      left:   none,
      right:  none,
      bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border },
    ),
    fill: (_, row) => if row == 0 { surface } else { white },
    table.header(
      text(size: 6.5pt, weight: 500, tracking: 0.08em, fill: ink-sec)[SCHREIB.],
      text(size: 6.5pt, weight: 500, tracking: 0.08em, fill: ink-sec)[VOR],
      text(size: 6.5pt, weight: 500, tracking: 0.08em, fill: ink-sec)[KLANG],
      text(size: 6.5pt, weight: 500, tracking: 0.08em, fill: ink-sec)[BEISPIELE],
    ),
    text(weight: 600, fill: accent)[c],    [a, o, u],  [k — wie Katze],       [casa · come · cucinare],
    text(weight: 600, fill: accent)[c],    [e, i],     [tsch — wie Tschüss],  [certo · cinema · ciao],
    text(weight: 600, fill: accent)[g],    [a, o, u],  [g — wie Gabe],        [gatto · gonna · gusto],
    text(weight: 600, fill: accent)[g],    [e, i],     [dsch — wie Dschungel],[gelato · giorno · già],
    text(weight: 600, fill: accent)[ch],   [e, i],     [k — wie Katze],       [che · chi · chiaro],
    text(weight: 600, fill: accent)[gh],   [e, i],     [g — wie Gabe],        [ghiaccio · spaghetti],
    text(weight: 600, fill: accent)[sc],   [e, i],     [sch — wie Schule],    [scena · sci · uscire · pesce],
    text(weight: 600, fill: accent)[sc],   [a, o, u],  [sk — wie Skandal],     [scala · scopo · scuro],
    text(weight: 600, fill: accent)[gli],  [],         [lj-Laut wie Million], [figlio · voglio · gli · famiglia],
    text(weight: 600, fill: accent)[gn],   [],         [nj-Laut, nasal],      [bagno · gnocchi · signore · ogni],
    text(weight: 600, fill: accent)[z/zz], [],         [ts oder dz],          [pizza · grazie — zero · zona],
    text(weight: 600, fill: accent)[h],    [],         [stumm],               [ho · hai · ha · hanno · hotel],
  )
]

#v(8pt)

#columns(2, gutter: 0.9cm)[

#block(breakable: false)[
  #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: accent)[#upper[Doppelkonsonanten]]
  #v(3pt)
  #text(size: 7pt, fill: ink-sec)[Doppelkonsonanten werden gedehnt gesprochen. Bedeutungsunterschied möglich:]
  #v(2pt)
  #text(size: 7pt, style: "italic")[fatto] #text(size: 7pt, fill: ink-sec)[(gemacht) ≠] #text(size: 7pt, style: "italic")[fato] #text(size: 7pt, fill: ink-sec)[(Schicksal) · ] #text(size: 7pt, style: "italic")[palla] #text(size: 7pt, fill: ink-sec)[(Ball) ≠] #text(size: 7pt, style: "italic")[pala] #text(size: 7pt, fill: ink-sec)[(Schaufel)]
]

#colbreak()

#block(breakable: false)[
  #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: accent)[#upper[Vokale & Betonung]]
  #v(3pt)
  #text(size: 7pt, fill: ink-sec)[Vokale sind rein — kein Umlaut, kein Diphthong. Betonung i.d.R. auf der vorletzten Silbe.]
  #v(2pt)
  #text(size: 7pt, fill: ink-sec)[Akzentzeichen = unregelmäßige Betonung:] #text(size: 7pt, style: "italic")[città · caffè · perché]
]

] // end pronuncia columns

// ── numeri page ───────────────────────────────────────────────────────────────
#pagebreak()

#page-title[I Numeri][KARDINALZAHLEN · ORDINALZAHLEN]

#columns(2, gutter: 0.9cm)[
#set text(size: 7.5pt)

// 0–10: Kardinal + unregelmäßige Ordinalzahlen
#text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: accent)[0 – 10]
#v(4pt)
#table(
  columns: (1.2cm, 1fr, 1fr),
  align: left,
  inset: (x: 4pt, y: 2.5pt),
  stroke: (_, y) => (
    top: none, left: none, right: none,
    bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border },
  ),
  fill: (_, y) => if y == 0 { surface } else { white },
  table.header(
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[NR.],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[KARDINAL],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[ORDINAL (M.)],
  ),
  [0],  [zero],       [—],
  [1],  [uno · una],  [primo],
  [2],  [due],        [secondo],
  [3],  [tre],        [terzo],
  [4],  [quattro],    [quarto],
  [5],  [cinque],     [quinto],
  [6],  [sei],        [sesto],
  [7],  [sette],      [settimo],
  [8],  [otto],       [ottavo],
  [9],  [nove],       [nono],
  [10], [dieci],      [decimo],
)

#colbreak()

// 11–19: Kardinal + Ordinalregel
#text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: accent)[11 – 19]
#v(4pt)
#table(
  columns: (1.2cm, 1fr, 1fr),
  align: left,
  inset: (x: 4pt, y: 2.5pt),
  stroke: (_, y) => (
    top: none, left: none, right: none,
    bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border },
  ),
  fill: (_, y) => if y == 0 { surface } else { white },
  table.header(
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[NR.],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[KARDINAL],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[ORDINAL (M.)],
  ),
  [11], [undici],      [undicesimo],
  [12], [dodici],      [dodicesimo],
  [13], [tredici],     [tredicesimo],
  [14], [quattordici], [quattordicesimo],
  [15], [quindici],    [quindicesimo],
  [16], [sedici],      [sedicesimo],
  [17], [diciassette], [diciassettesimo],
  [18], [diciotto],    [diciottesimo],
  [19], [diciannove],  [diciannovesimo],
)
#v(4pt)
#ann[*Ordinal ab 11°:* Kardinalzahl + -esimo/a (letzter Vokal fällt weg) — undicesimo, dodicesimo …]

#v(6pt)

// Zehner & Größenordnungen
#text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: accent)[ZEHNER · GRÖSSENORDNUNGEN]
#v(4pt)
#table(
  columns: (1.2cm, 1fr, 1fr),
  align: left,
  inset: (x: 4pt, y: 2.5pt),
  stroke: (_, y) => (
    top: none, left: none, right: none,
    bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border },
  ),
  fill: (_, y) => if y == 0 { surface } else { white },
  table.header(
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[NR.],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[KARDINAL],
    text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[ORDINAL (M.)],
  ),
  [20],    [venti],       [ventesimo],
  [21],    [ventuno #text(fill: ink-sec, size: 6.5pt)[¹]],   [ventunesimo],
  [22],    [ventidue],    [ventiduesimo],
  [23],    [ventitré #text(fill: ink-sec, size: 6.5pt)[²]],  [ventitreesimo],
  [30],    [trenta],      [trentesimo],
  [40],    [quaranta],    [quarantesimo],
  [50],    [cinquanta],   [cinquantesimo],
  [60],    [sessanta],    [sessantesimo],
  [70],    [settanta],    [settantesimo],
  [80],    [ottanta],     [ottantesimo],
  [90],    [novanta],     [novantesimo],
  [100],   [cento],       [centesimo],
  [1.000], [mille],       [millesimo],
)
#v(4pt)
#ann[*¹ Elision:* Zehner + uno/otto → letzter Vokal fällt weg: ventuno, ventotto, trentuno, trentotto … Bei allen anderen Einern bleibt er: ventidue, ventisei …]
#v(4pt)
#ann[*² Akzent auf -tré:* ventitré, trentatré, quarantatré … Ordinal: Akzent fällt weg, -e bleibt — ventitreesimo]
#v(4pt)
#ann[*Ordinalzahlen kongruieren wie Adjektive* — Endung richtet sich nach Genus und Numerus des Bezugsnomens: primo (m. sg.) · prima (f. sg.) · primi (m. pl.) · prime (f. pl.) · *Abkürzung:* 1° (m.) · 1ª (f.)]

] // end numeri columns

