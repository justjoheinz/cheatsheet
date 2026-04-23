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


