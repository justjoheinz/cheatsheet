#set page(
  paper: "a4",
  margin: (x: 1cm, y: 1cm),
)
#set text(size: 8pt, font: ("Helvetica Neue", "Helvetica", "Noto Sans", "Arial"), fill: rgb("#1a1a1a"))
#set par(leading: 0.5em)

// ── palette ──────────────────────────────────────────────────────────────────

#let ink      = rgb("#1a1a1a")
#let ink-sec  = rgb("#6a6a66")
#let border   = rgb("#d4d3cc")
#let surface  = rgb("#f0efea")
#let accent   = rgb("#e8420a")

// ── table: horizontal rules only, no vertical strokes ────────────────────────

#let conj-table(rows) = {
  set text(size: 7.5pt)
  table(
    columns: (1.5cm, 1fr, 1fr, 1fr, 1fr),
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
      text(size: 6.5pt, weight: 500, tracking: 0.08em, fill: ink-sec)[PRONOME],
      text(size: 6.5pt, weight: 500, tracking: 0.08em, fill: ink-sec)[PRESENTE],
      text(size: 6.5pt, weight: 500, tracking: 0.08em, fill: ink-sec)[IMPERFETTO],
      text(size: 6.5pt, weight: 500, tracking: 0.08em, fill: ink-sec)[PASS. PROS.],
      text(size: 6.5pt, weight: 500, tracking: 0.08em, fill: ink-sec)[FUTURO],
    ),
    ..rows.map(r => (r.at(0), r.at(1), r.at(2), r.at(3), r.at(4))).flatten().map(c => [#c]),
  )
}

// ── section renderer ─────────────────────────────────────────────────────────

#let verb-section(name, translation, group, rows, examples) = {
  block(breakable: false)[
    #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[#upper(group)]
    #v(1.5pt)
    #text(size: 10pt, weight: 600, fill: accent)[#name]
    #h(4pt)
    #text(size: 8pt, fill: ink-sec)[(#translation)]
    #v(3pt)
    #conj-table(rows)
    #v(3pt)
    #for ex in examples [
      #text(size: 7pt, weight: 500, fill: ink-sec)[#ex.at("tense"):] #h(1pt)#text(size: 7pt, style: "italic")[#ex.at("text")]
      #linebreak()
    ]
  ]
  v(7pt)
}

// ── comparison table renderer ────────────────────────────────────────────────

#let verb-compare(group-label, verbs, presente-rows, imp-note, ppr-note, fut-note) = {
  let n = verbs.len()
  let verb-cols = range(n).map(i => 1fr)
  block(breakable: false)[
    #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[#upper(group-label)]
    #v(1.5pt)
    #for v in verbs [#text(size: 10pt, weight: 600, fill: accent)[#v.at(0)]#h(3pt)#text(size: 8pt, fill: ink-sec)[(#v.at(1))]#h(6pt)]
    #v(3pt)
    #set text(size: 7pt)
    #table(
      columns: (1.5cm, ..verb-cols),
      align: left,
      inset: (x: 3pt, y: 3pt),
      stroke: (_, y) => (
        top:    none,
        left:   none,
        right:  none,
        bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border },
      ),
      fill: (_, row) => if row == 0 { surface } else { white },
      table.header(
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[PRONOME],
        ..verbs.map(v => text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[#upper(v.at(0))]),
      ),
      ..presente-rows.flatten().map(c => [#c]),
    )
    #v(3pt)
    #text(size: 7pt, weight: 500, fill: ink-sec)[Imperfetto (io):] #h(1pt)#text(size: 7pt, style: "italic")[#imp-note]#linebreak()
    #text(size: 7pt, weight: 500, fill: ink-sec)[Passato prossimo:] #h(1pt)#text(size: 7pt, style: "italic")[#ppr-note]#linebreak()
    #text(size: 7pt, weight: 500, fill: ink-sec)[Futuro (io):] #h(1pt)#text(size: 7pt, style: "italic")[#fut-note]
  ]
  v(7pt)
}

// ── vocabulary group renderer ────────────────────────────────────────────────

#let vocab-group(label, entries) = {
  // Precompute which row indices are note rows (no header — y=0 is first data row)
  let note-rows = ()
  let ri = 0
  for e in entries {
    if e.len() == 3 { note-rows = note-rows + (ri + 1,); ri = ri + 2 }
    else             { ri = ri + 1 }
  }

  // Build flat cell array
  let cells = ()
  for e in entries {
    cells = cells + ([#e.at(0)], text(fill: ink-sec)[#e.at(1)])
    if e.len() == 3 {
      cells = cells + (
        table.cell(colspan: 2, inset: (left: 7pt, right: 4pt, top: 1pt, bottom: 3pt))[
          #text(size: 6.5pt, fill: ink-sec, style: "italic")[#sym.arrow.r #e.at(2)]
        ],
      )
    }
  }

  block(breakable: false)[
    #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: accent)[#upper(label)]
    #v(1.5pt)
    #set text(size: 7.5pt)
    #table(
      columns: (1fr, 1fr),
      align: left,
      inset: (x: 4pt, y: 2.5pt),
      stroke: (_, y) => (
        top:    none,
        left:   none,
        right:  none,
        bottom: if note-rows.contains(y + 1) { none } else { 0.3pt + border },
      ),
      fill: white,
      ..cells,
    )
  ]
  v(7pt)
}

// ── annotation helper ────────────────────────────────────────────────────────

#let ann(body) = text(fill: ink-sec, size: 7pt, body)

// ── title ────────────────────────────────────────────────────────────────────

#block(width: 100%)[
  #text(size: 11pt, weight: 600, tracking: 0.03em)[Verbi Italiani — Coniugazione]
  #h(10pt)
  #text(size: 7pt, weight: 500, tracking: 0.1em, fill: ink-sec)[PRESENTE · IMPERFETTO · PASS. PROS. · FUTURO]
]
#v(5pt)
#line(length: 100%, stroke: 0.6pt + ink)
#v(7pt)

// ── two-column body ──────────────────────────────────────────────────────────

#columns(2, gutter: 0.9cm)[

// ── parlare ──────────────────────────────────────────────────────────────────
#verb-section(
  "parlare", "sprechen", "verbi in -are",
  (
    ("io",      "parlo",    "parlavo",    "ho parlato",      "parlerò"),
    ("tu",      "parli",    "parlavi",    "hai parlato",     "parlerai"),
    ("lui/lei", "parla",    "parlava",    "ha parlato",      "parlerà"),
    ("noi",     "parliamo", "parlavamo",  "abbiamo parlato", "parleremo"),
    ("voi",     "parlate",  "parlavate",  "avete parlato",   "parlerete"),
    ("loro",    "parlano",  "parlavano",  "hanno parlato",   "parleranno"),
  ),
  (
    ("tense": "Presente",         "text": "Ogni giorno parlo con mia madre."),
    ("tense": "Imperfetto",       "text": "Da bambino parlavo sempre italiano."),
    ("tense": "Passato prossimo", "text": "Ieri ho parlato con il professore."),
    ("tense": "Futuro",           "text": "Domani parlerò con il direttore."),
  ),
)

// ── ripetere ──────────────────────────────────────────────────────────────────
#verb-section(
  "ripetere", "wiederholen", "verbi in -ere",
  (
    ("io",      "ripeto",    "ripetevo",    "ho ripetuto",      "ripeterò"),
    ("tu",      "ripeti",    "ripetevi",    "hai ripetuto",     "ripeterai"),
    ("lui/lei", "ripete",    "ripeteva",    "ha ripetuto",      "ripeterà"),
    ("noi",     "ripetiamo", "ripetevamo",  "abbiamo ripetuto", "ripeteremo"),
    ("voi",     "ripetete",  "ripetevate",  "avete ripetuto",   "ripeterete"),
    ("loro",    "ripetono",  "ripetevano",  "hanno ripetuto",   "ripeteranno"),
  ),
  (
    ("tense": "Presente",         "text": "Ripeto la domanda per chi non ha sentito."),
    ("tense": "Imperfetto",       "text": "Il professore ripeteva sempre le stesse cose."),
    ("tense": "Passato prossimo", "text": "Ho ripetuto l'esame la settimana scorsa."),
    ("tense": "Futuro",           "text": "Ripeterò l'esercizio fino a capirlo."),
  ),
)

// ── sentire ──────────────────────────────────────────────────────────────────
#verb-section(
  "sentire", "hören/fühlen", "verbi in -ire (tipo I)",
  (
    ("io",      "sento",    "sentivo",    "ho sentito",      "sentirò"),
    ("tu",      "senti",    "sentivi",    "hai sentito",     "sentirai"),
    ("lui/lei", "sente",    "sentiva",    "ha sentito",      "sentirà"),
    ("noi",     "sentiamo", "sentivamo",  "abbiamo sentito", "sentiremo"),
    ("voi",     "sentite",  "sentivate",  "avete sentito",   "sentirete"),
    ("loro",    "sentono",  "sentivano",  "hanno sentito",   "sentiranno"),
  ),
  (
    ("tense": "Presente",         "text": "Sento la musica dalla finestra."),
    ("tense": "Imperfetto",       "text": "Sentivo un rumore strano."),
    ("tense": "Passato prossimo", "text": "Ho sentito le tue parole."),
    ("tense": "Futuro",           "text": "Sentirò la tua risposta domani."),
  ),
)

// ── finire ───────────────────────────────────────────────────────────────────
#verb-section(
  "finire", "beenden", "verbi in -ire (tipo II, -isc-)",
  (
    ("io",      [finisco #text(fill: ink-sec, size: 7pt)[†]],    "finivo",    "ho finito",      "finirò"),
    ("tu",      [finisci #text(fill: ink-sec, size: 7pt)[†]],    "finivi",    "hai finito",     "finirai"),
    ("lui/lei", [finisce #text(fill: ink-sec, size: 7pt)[†]],    "finiva",    "ha finito",      "finirà"),
    ("noi",     "finiamo",  "finivamo",  "abbiamo finito", "finiremo"),
    ("voi",     "finite",   "finivate",  "avete finito",   "finirete"),
    ("loro",    [finiscono #text(fill: ink-sec, size: 7pt)[†]],  "finivano",  "hanno finito",   "finiranno"),
  ),
  (
    ("tense": "Presente",         "text": "Finisco il lavoro alle cinque."),
    ("tense": "Imperfetto",       "text": "Finivo sempre tardi."),
    ("tense": "Passato prossimo", "text": "Ho finito il libro ieri."),
    ("tense": "Futuro",           "text": "Finirò il progetto entro venerdì."),
  ),
)

#ann[† infisso -isc- in io/tu/lui/loro al Presente; assente in noi/voi. Stessa struttura: capire, preferire, costruire.]

#v(5pt)

// ── essere ───────────────────────────────────────────────────────────────────
#verb-section(
  "essere", "sein", "ausiliare",
  (
    ("io",      "sono",   "ero",      "sono stato·a",   "sarò"),
    ("tu",      "sei",    "eri",      "sei stato·a",    "sarai"),
    ("lui/lei", [è],      "era",      "è stato·a",      "sarà"),
    ("noi",     "siamo",  "eravamo",  "siamo stati·e",  "saremo"),
    ("voi",     "siete",  "eravate",  "siete stati·e",  "sarete"),
    ("loro",    "sono",   "erano",    "sono stati·e",   "saranno"),
  ),
  (
    ("tense": "Presente",         "text": "Sono stanco dopo il lavoro."),
    ("tense": "Imperfetto",       "text": "Era una bella giornata."),
    ("tense": "Passato prossimo", "text": "Siamo stati a Roma la settimana scorsa."),
    ("tense": "Futuro",           "text": "Sarà una bella giornata domani."),
  ),
)

#ann[Participio: stato · stata · stati · state. Con essere il participio concorda con il soggetto.]

#v(5pt)

// ── avere ────────────────────────────────────────────────────────────────────
#verb-section(
  "avere", "haben", "ausiliare",
  (
    ("io",      "ho",       "avevo",    "ho avuto",      "avrò"),
    ("tu",      "hai",      "avevi",    "hai avuto",     "avrai"),
    ("lui/lei", "ha",       "aveva",    "ha avuto",      "avrà"),
    ("noi",     "abbiamo",  "avevamo",  "abbiamo avuto", "avremo"),
    ("voi",     "avete",    "avevate",  "avete avuto",   "avrete"),
    ("loro",    "hanno",    "avevano",  "hanno avuto",   "avranno"),
  ),
  (
    ("tense": "Presente",         "text": "Ho molti libri a casa."),
    ("tense": "Imperfetto",       "text": "Avevamo un cane."),
    ("tense": "Passato prossimo", "text": "Ha avuto problemi con il computer."),
    ("tense": "Futuro",           "text": "Avrai più tempo il prossimo anno."),
  ),
)

// ── fare ─────────────────────────────────────────────────────────────────────
#verb-section(
  "fare", "machen/tun", "irregolare",
  (
    ("io",      "faccio",   "facevo",    "ho fatto",      "farò"),
    ("tu",      "fai",      "facevi",    "hai fatto",     "farai"),
    ("lui/lei", "fa",       "faceva",    "ha fatto",      "farà"),
    ("noi",     "facciamo", "facevamo",  "abbiamo fatto", "faremo"),
    ("voi",     "fate",     "facevate",  "avete fatto",   "farete"),
    ("loro",    "fanno",    "facevano",  "hanno fatto",   "faranno"),
  ),
  (
    ("tense": "Presente",         "text": "Faccio colazione alle sette."),
    ("tense": "Imperfetto",       "text": "Facevo sport ogni giorno."),
    ("tense": "Passato prossimo", "text": "Hanno fatto una passeggiata nel parco."),
    ("tense": "Futuro",           "text": "Farò una torta per il tuo compleanno."),
  ),
)

// ── volere ───────────────────────────────────────────────────────────────────
#verb-section(
  "volere", "wollen", "modale",
  (
    ("io",      "voglio",   "volevo",    "ho voluto",      "vorrò"),
    ("tu",      "vuoi",     "volevi",    "hai voluto",     "vorrai"),
    ("lui/lei", "vuole",    "voleva",    "ha voluto",      "vorrà"),
    ("noi",     "vogliamo", "volevamo",  "abbiamo voluto", "vorremo"),
    ("voi",     "volete",   "volevate",  "avete voluto",   "vorrete"),
    ("loro",    "vogliono", "volevano",  "hanno voluto",   "vorranno"),
  ),
  (
    ("tense": "Presente",         "text": "Voglio un caffè, per favore."),
    ("tense": "Imperfetto",       "text": "Volevo studiare medicina."),
    ("tense": "Passato prossimo", "text": "Ho voluto provare il nuovo ristorante."),
    ("tense": "Futuro",           "text": "Vorrò sapere la tua opinione."),
  ),
)

// ── potere ───────────────────────────────────────────────────────────────────
#verb-section(
  "potere", "können/dürfen", "modale",
  (
    ("io",      "posso",    "potevo",    "ho potuto",      "potrò"),
    ("tu",      "puoi",     "potevi",    "hai potuto",     "potrai"),
    ("lui/lei", [può],      "poteva",    "ha potuto",      "potrà"),
    ("noi",     "possiamo", "potevamo",  "abbiamo potuto", "potremo"),
    ("voi",     "potete",   "potevate",  "avete potuto",   "potrete"),
    ("loro",    "possono",  "potevano",  "hanno potuto",   "potranno"),
  ),
  (
    ("tense": "Presente",         "text": "Posso aprire la finestra?"),
    ("tense": "Imperfetto",       "text": "Potevamo uscire prima."),
    ("tense": "Passato prossimo", "text": "Non ho potuto dormire."),
    ("tense": "Futuro",           "text": "Potrai venire alla festa domani?"),
  ),
)

// ── dovere ───────────────────────────────────────────────────────────────────
#verb-section(
  "dovere", "müssen/sollen", "modale",
  (
    ("io",      "devo",      "dovevo",    "ho dovuto",      "dovrò"),
    ("tu",      "devi",      "dovevi",    "hai dovuto",     "dovrai"),
    ("lui/lei", "deve",      "doveva",    "ha dovuto",      "dovrà"),
    ("noi",     "dobbiamo",  "dovevamo",  "abbiamo dovuto", "dovremo"),
    ("voi",     "dovete",    "dovevate",  "avete dovuto",   "dovrete"),
    ("loro",    "devono",    "dovevano",  "hanno dovuto",   "dovranno"),
  ),
  (
    ("tense": "Presente",         "text": "Devo studiare per l'esame."),
    ("tense": "Imperfetto",       "text": "Dovevo lavorare tutto il giorno."),
    ("tense": "Passato prossimo", "text": "Ho dovuto chiamare il medico."),
    ("tense": "Futuro",           "text": "Dovrò partire presto domani mattina."),
  ),
)

// ── dire ─────────────────────────────────────────────────────────────────────
#verb-section(
  "dire", "sagen", "irregolare",
  (
    ("io",      "dico",    "dicevo",    "ho detto",      "dirò"),
    ("tu",      "dici",    "dicevi",    "hai detto",     "dirai"),
    ("lui/lei", "dice",    "diceva",    "ha detto",      "dirà"),
    ("noi",     "diciamo", "dicevamo",  "abbiamo detto", "diremo"),
    ("voi",     "dite",    "dicevate",  "avete detto",   "direte"),
    ("loro",    "dicono",  "dicevano",  "hanno detto",   "diranno"),
  ),
  (
    ("tense": "Presente",         "text": "Dico sempre la verità."),
    ("tense": "Imperfetto",       "text": "Diceva sempre bugie."),
    ("tense": "Passato prossimo", "text": "Cosa hai detto?"),
    ("tense": "Futuro",           "text": "Ti dirò la verità quando sarà il momento."),
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
  "andavo · venivo · uscivo · stavo (regolare dal tema)",
  "andato·a · venuto·a · uscito·a · stato·a (essere — accordo). stato·a = stesso participio di essere; il contesto distingue.",
  "andrò · verrò · uscirò · starò (stem irregolare: andr-, verr-, uscir-, star-)",
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
  "davo · sapevo · bevevo · vedevo (dare/sapere: regolare; bere: tema bev- da bibere; vedere: regolare)",
  "dato · saputo · bevuto · visto (avere)",
  "darò · saprò · berrò · vedrò (dare: regolare; sapere: sapr-; bere: berr-; vedere: vedr-)",
)

// ── footer (conjugation pages) ────────────────────────────────────────────────
#place(bottom + left, scope: "parent", float: true)[
  #line(length: 100%, stroke: 0.4pt + border)
  #v(3pt)
  #text(size: 7pt, fill: ink-sec)[
    *Passato prossimo:* ausiliare (avere o essere) + participio passato. Con *essere* il participio concorda in genere e numero con il soggetto. Verbi regolari: -are → -ato · -ere → -uto · -ire → -ito. Irregolari: fare → fatto · essere → stato.]
]

] // end columns

// ── vocabulary page ───────────────────────────────────────────────────────────
#pagebreak()

#block(width: 100%)[
  #text(size: 11pt, weight: 600, tracking: 0.03em)[Vocabolario Comune]
  #h(10pt)
  #text(size: 7pt, weight: 500, tracking: 0.1em, fill: ink-sec)[VERBI FREQUENTI]
]
#v(5pt)
#line(length: 100%, stroke: 0.6pt + ink)
#v(7pt)

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

// ── parole utili page ─────────────────────────────────────────────────────────
#pagebreak()

#block(width: 100%)[
  #text(size: 11pt, weight: 600, tracking: 0.03em)[Parole Utili]
  #h(10pt)
  #text(size: 7pt, weight: 500, tracking: 0.1em, fill: ink-sec)[AVVERBI · CONGIUNZIONI · INDEFINITI · LUOGO]
]
#v(5pt)
#line(length: 100%, stroke: 0.6pt + ink)
#v(7pt)

#columns(2, gutter: 0.9cm)[

#vocab-group("Frequenz", (
  ("sempre",      "immer"),
  ("quasi sempre","fast immer"),
  ("spesso",      "oft"),
  ("per lo più",  "meistens"),
  ("a volte",     "manchmal"),
  ("di solito",   "normalerweise"),
  ("raramente",   "selten"),
  ("mai",       "nie",       "Doppelnegation: non bevo mai vino (non vor dem Verb, mai danach)"),
))

#vocab-group("Zeit", (
  ("ora / adesso", "jetzt"),
  ("poi",          "dann / danach"),
  ("dopo",         "nachher / danach"),
  ("prima",        "vorher / früher"),
  ("già",          "schon / bereits",  "in Fragen: Ha già mangiato? = Hat er schon gegessen?"),
  ("ancora",       "noch / wieder",    "non … ancora = noch nicht; non … più = nicht mehr"),
  ("subito",       "sofort"),
  ("presto",       "früh / bald"),
  ("tardi",        "spät"),
  ("breve",        "kurz (zeitlich)", "für räumlich kurz: corto/a; in breve = kurz gesagt"),
  ("fa",           "vor (zeitlich)",   "immer nachgestellt: due anni fa (vor zwei Jahren)"),
  ("scorso/a",     "letzt-",           "immer nachgestellt: la settimana scorsa, il mese scorso"),
  ("prossimo/a",   "nächst-",          "immer nachgestellt: la settimana prossima, l'anno prossimo"),
))

#vocab-group("Größe & Form", (
  ("grande",    "groß",    "m./f. gleich; gran vor Konsonant: gran lavoro"),
  ("piccolo/a", "klein"),
  ("lungo/a",   "lang"),
  ("corto/a",   "kurz"),
  ("alto/a",    "hoch / groß (Person)"),
  ("basso/a",   "niedrig / klein (Person)"),
  ("largo/a",   "breit"),
  ("stretto/a", "schmal / eng"),
  ("sottile",   "dünn",    "m./f. gleich"),
  ("spesso/a",  "dick (Sache)", "grasso/a für Personen"),
  ("pesante",   "schwer",  "m./f. gleich"),
  ("leggero/a", "leicht"),
))

#vocab-group("Quantität & Indefinita", (
  ("tutto/a",   "alles / ganz"),
  ("molto/a",   "viel / sehr"),
  ("poco/a",    "wenig"),
  ("più",       "mehr",             "unveränderlich; non … più = nicht mehr"),
  ("più … di",  "mehr … als",       "più grande di me"),
  ("meno",      "weniger",          "unveränderlich"),
  ("meno … di", "weniger … als",    "meno grande di me"),
  ("abbastanza","genug / ziemlich"),
  ("troppo/a",  "zu viel / zu"),
  ("qualcosa",  "etwas"),
  ("niente",    "nichts",           "Doppelnegation: non vedo niente; Variante: nulla"),
  ("qualcuno/a","jemand"),
  ("nessuno/a", "niemand / keiner", "Doppelnegation: non vedo nessuno"),
  ("ogni",      "jeder / jede / jedes"),
))

#vocab-group("Konjunktionen", (
  ("e",       "und"),
  ("ma",      "aber"),
  ("o",       "oder"),
  ("però",    "aber / jedoch"),
  ("quindi",  "also / deshalb"),
  ("perché",  "weil / warum",        "Konjunktion: …perché… (weil); Fragewort: Perché…? (warum)"),
  ("quando",  "als / wenn / wann",   "Vergangenheit: als — Gegenwart/Zukunft: wenn — Fragewort: wann"),
  ("se",      "wenn / ob",           "Bedingung: se vieni… (wenn); indirekte Frage: …se vuole (ob)"),
  ("mentre",  "während",  "Konjunktion + Verb: mentre mangio… (während ich esse…)"),
  ("durante", "während",  "Präposition + Nomen: durante la lezione (während des Unterrichts)"),
  ("anche",   "auch"),
  ("allora",  "also / dann"),
  ("che",     "dass / der/die/das",  "Konjunktion: so che… (dass); Relativpronomen: il libro che leggo"),
))

#vocab-group("Ort & Richtung", (
  ("qui / qua", "hier"),
  ("lì / là",   "dort"),
  ("dentro",    "drinnen / hinein"),
  ("fuori",     "draußen / hinaus"),
  ("sopra",     "oben / darüber",   "sopra al tavolo · sopra di me"),
  ("sotto",     "unten / darunter", "sotto al tavolo · sotto di me"),
  ("vicino",    "in der Nähe"),
  ("lontano",   "weit / weit weg"),
  ("ovunque",   "überall"),
))

#vocab-group("Fragewörter", (
  ("chi",          "wer",              "Chi sei? · Chi viene stasera?"),
  ("che cosa / cosa", "was",           "Cosa fai? · Che cosa vuoi?"),
  ("dove",         "wo / wohin",       "Dove sei? · Dove vai?"),
  ("quando",       "wann",             "Quando arrivi? · Quando partiamo?"),
  ("perché",       "warum",            "Perché piangi? — Antwort: perché… (weil…)"),
  ("come",         "wie",              "Come stai? · Come ti chiami?"),
  ("quanto/a",     "wie viel",         "Quanto costa? · Quanti anni hai?"),
  ("quale / quali","welche/r/s",       "Quale preferisci? · Quali sono i tuoi hobby?"),
))

] // end parole columns

// ── preposizioni articolate page ──────────────────────────────────────────────
#pagebreak()

#block(width: 100%)[
  #text(size: 11pt, weight: 600, tracking: 0.03em)[Preposizioni Articolate]
  #h(10pt)
  #text(size: 7pt, weight: 500, tracking: 0.1em, fill: ink-sec)[PRÄPOSITION + BESTIMMTER ARTIKEL]
]
#v(5pt)
#line(length: 100%, stroke: 0.6pt + ink)
#v(7pt)

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

#let prep-entry(prep, notes) = {
  block(breakable: false)[
    #text(size: 9pt, weight: 600, fill: accent)[#prep]
    #v(1.5pt)
    #for n in notes [
      #text(size: 6.5pt, weight: 500, fill: ink-sec)[#n.at(0)] #h(3pt)#text(size: 7pt)[#n.at(1)]
      #linebreak()
    ]
  ]
  v(6pt)
}

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

#block(width: 100%)[
  #text(size: 11pt, weight: 600, tracking: 0.03em)[I Tempi Verbali]
  #h(10pt)
  #text(size: 7pt, weight: 500, tracking: 0.1em, fill: ink-sec)[GEBRAUCHSREGELN — PRESENTE · IMPERFETTO · PASSATO PROSSIMO]
]
#v(5pt)
#line(length: 100%, stroke: 0.6pt + ink)
#v(8pt)

#let tense-block(name, subtitle, rules) = {
  block(breakable: false)[
    #text(size: 9pt, weight: 600, fill: accent)[#name]
    #h(5pt)
    #text(size: 7pt, fill: ink-sec)[#subtitle]
    #v(3pt)
    #line(length: 100%, stroke: 0.3pt + border)
    #v(3pt)
    #for r in rules [
      #block(inset: (bottom: 3pt))[
        #text(size: 7pt, weight: 500)[#r.at(0)]
        #linebreak()
        #text(size: 7pt, style: "italic", fill: ink-sec)[#r.at(1)]
      ]
    ]
  ]
  v(8pt)
}

#grid(columns: (1fr, 1fr), gutter: 0.9cm,
  [
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
  ],
  [
    #tense-block("Passato prossimo", "Abgeschlossenes Ereignis", (
      ("Einmaliges abgeschlossenes Ereignis",
       "Ieri ho chiamato Marco."),
      ("Handlung mit Ergebnis im Vordergrund",
       "Ho mangiato. (Ich habe gegessen — bin satt.)"),
      ("Ereignis zu einem bestimmten Zeitpunkt",
       "Due anni fa ho iniziato a studiare l'italiano."),
      ("Kurzfristig zurückliegende Handlung",
       "Oggi mi sono svegliato tardi."),
    ))

    #tense-block("Imperfetto", "Vergangener Zustand / Gewohnheit / Hintergrund", (
      ("Vergangener Zustand oder Eigenschaft",
       "Era molto stanco. · Da bambino abitavo a Milano."),
      ("Wiederkehrende Handlung in der Vergangenheit",
       "Ogni estate andavamo al mare."),
      ("Hintergrundgeschehen (parallel zu einem Ereignis)",
       "Mentre dormivo, è arrivato Marco."),
      ("Höfliche Abschwächung",
       "Volevo un caffè. (Ich hätte gerne einen Kaffee.)"),
    ))
  ],
) // end tense grid

// ── contrast section ──────────────────────────────────────────────────────────
#v(4pt)
#line(length: 100%, stroke: 0.4pt + border)
#v(5pt)
#text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[IMPERFETTO VS. PASSATO PROSSIMO]
#v(5pt)

#columns(2, gutter: 0.9cm)[

#block[
  #text(size: 7pt, weight: 500)[Passato prossimo = Vordergrund]
  #linebreak()
  #text(size: 7pt)[Einmaliges, abgeschlossenes Ereignis — was *passierte*.]
  #v(2pt)
  #text(size: 7pt, weight: 500)[Imperfetto = Hintergrund]
  #linebreak()
  #text(size: 7pt)[Andauernder Zustand oder laufende Handlung — was gerade *war* oder *lief*.]
]

#block[
  #text(size: 7pt, weight: 500)[Klassisches Muster:]
  #linebreak()
  #text(size: 7pt, style: "italic")[Mentre #text(fill: accent)[leggevo] (Imp.), Marco #text(fill: accent)[è arrivato] (P.pr.).]
  #v(2pt)
  #text(size: 7pt, style: "italic")[Da bambino #text(fill: accent)[andavo] (Imp.) spesso al parco, ma ieri #text(fill: accent)[sono andato] (P.pr.) al cinema.]
]

] // end contrast columns

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

// ── pronomi oggetto diretto ───────────────────────────────────────────────────
#v(8pt)
#line(length: 100%, stroke: 0.4pt + border)
#v(5pt)
#text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: accent)[PRONOMI OGGETTO DIRETTO]
#v(5pt)

#grid(columns: (1fr, 1fr), gutter: 0.9cm,
  block(breakable: false)[
    #set text(size: 7.5pt)
    #table(
      columns: (1.2cm, 1fr),
      align: left,
      inset: (x: 4pt, y: 2.5pt),
      stroke: (_, y) => (
        top: none, left: none, right: none,
        bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border },
      ),
      fill: (_, y) => if y == 0 { surface } else { white },
      table.header(
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[PRONOME],
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[DEUTSCH],
      ),
      text(weight: 600, fill: accent)[mi], [mich],
      text(weight: 600, fill: accent)[ti], [dich],
      text(weight: 600, fill: accent)[lo], [ihn / es (m.) — l' vor Vokal/h],
      text(weight: 600, fill: accent)[la], [sie / es (f.) — l' vor Vokal/h],
      text(weight: 600, fill: accent)[ci], [uns],
      text(weight: 600, fill: accent)[vi], [euch],
      text(weight: 600, fill: accent)[li], [sie (m. Pl.)],
      text(weight: 600, fill: accent)[le], [sie (f. Pl.)],
    )
    #v(3pt)
    #text(size: 7pt, fill: ink-sec)[Position: immer vor dem konjugierten Verb.]
  ],
  block(breakable: false)[
    #text(size: 7pt, weight: 500)[Mit Passato prossimo: Partizip kongruiert mit Pronomen]
    #v(4pt)
    #block(inset: (bottom: 4pt))[
      #text(size: 7pt, weight: 500)[lo / la → l' + Partizip in Genus/Numerus]
      #linebreak()
      #text(size: 7pt, style: "italic", fill: ink-sec)[Hai visto Marco? → Sì, #text(fill: ink)[l'ho] #text(fill: accent)[visto].]
      #linebreak()
      #text(size: 7pt, style: "italic", fill: ink-sec)[Hai visto Maria? → Sì, #text(fill: ink)[l'ho] #text(fill: accent)[vista].]
    ]
    #block(inset: (bottom: 4pt))[
      #text(size: 7pt, weight: 500)[li / le → kein Apostroph]
      #linebreak()
      #text(size: 7pt, style: "italic", fill: ink-sec)[Hai comprato i libri? → #text(fill: ink)[Li] ho #text(fill: accent)[comprati].]
      #linebreak()
      #text(size: 7pt, style: "italic", fill: ink-sec)[Hai comprato le mele? → #text(fill: ink)[Le] ho #text(fill: accent)[comprate].]
    ]
    #block[
      #text(size: 7pt, weight: 500)[mi / ti / ci / vi → Kongruenz fakultativ]
      #linebreak()
      #text(size: 7pt, style: "italic", fill: ink-sec)[Mi ha chiamato. / Mi ha chiamata. (beide korrekt)]
    ]
  ],
)

// ── pronuncia ─────────────────────────────────────────────────────────────────
#let lb = "\u{5B}"
#let rb = "\u{5D}"

#pagebreak()

#text(size: 10pt, weight: 600, fill: accent)[Pronuncia]
#h(6pt)
#text(size: 8pt, weight: 500, tracking: 0.08em, fill: ink-sec)[AUSSPRACHEREGELN — KONSONANTEN · VOKALE · BETONUNG]
#line(length: 100%, stroke: 0.3pt + border)
#v(8pt)

#block(breakable: false)[
  #text(size: 7pt, weight: 500)[Konsonanten & Sonderzeichen]
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
  #text(size: 7pt, weight: 500)[Doppelkonsonanten]
  #v(3pt)
  #text(size: 7pt, fill: ink-sec)[Doppelkonsonanten werden gedehnt gesprochen. Bedeutungsunterschied möglich:]
  #v(2pt)
  #text(size: 7pt, style: "italic")[fatto] #text(size: 7pt, fill: ink-sec)[(gemacht) ≠] #text(size: 7pt, style: "italic")[fato] #text(size: 7pt, fill: ink-sec)[(Schicksal) · ] #text(size: 7pt, style: "italic")[palla] #text(size: 7pt, fill: ink-sec)[(Ball) ≠] #text(size: 7pt, style: "italic")[pala] #text(size: 7pt, fill: ink-sec)[(Schaufel)]
]

#colbreak()

#block(breakable: false)[
  #text(size: 7pt, weight: 500)[Vokale & Betonung]
  #v(3pt)
  #text(size: 7pt, fill: ink-sec)[Vokale sind rein — kein Umlaut, kein Diphthong. Betonung i.d.R. auf der vorletzten Silbe.]
  #v(2pt)
  #text(size: 7pt, fill: ink-sec)[Akzentzeichen = unregelmäßige Betonung:] #text(size: 7pt, style: "italic")[città · caffè · perché]
]

] // end pronuncia columns

// ── numeri page ───────────────────────────────────────────────────────────────
#pagebreak()

#block(width: 100%)[
  #text(size: 11pt, weight: 600, tracking: 0.03em)[I Numeri]
  #h(10pt)
  #text(size: 7pt, weight: 500, tracking: 0.1em, fill: ink-sec)[KARDINALZAHLEN · ORDINALZAHLEN]
]
#v(5pt)
#line(length: 100%, stroke: 0.6pt + ink)
#v(7pt)

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

