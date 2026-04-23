#import "shared.typ": *
#show: cheatsheet

// ── page 1 ───────────────────────────────────────────────────────────────────

#page-title[Condizionale Semplice][FORMAZIONE · DESINENZE · ECCEZIONI]

#columns(2, gutter: 0.9cm)[

// ── Bildungsregel ─────────────────────────────────────────────────────────────

#block(breakable: false)[
  #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[BILDUNGSREGEL]
  #v(4pt)
  #set text(size: 7.5pt)
  #table(
    columns: (0.6fr, 1.6fr, 1fr),
    align: left,
    inset: (x: 4pt, y: 3pt),
    stroke: (_, y) => (top: none, left: none, right: none,
      bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border }),
    fill: (_, row) => if row == 0 { surface } else { white },
    table.header(
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[KLASSE],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[STAMMBILDUNG],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[STAMM (Bsp.)],
    ),
    [-are], [-er], [parler-],
    [-ere], [-er], [ripeter-],
    [-ire], [-ir], [sentir-],
  )
  #v(6pt)
  #text(size: 6.5pt, weight: 500, fill: ink-sec)[Endungen — für alle Verbklassen gleich:]
  #v(3pt)
  #table(
    columns: (1fr, 1fr, 1.5fr, 1fr, 1fr, 1.5fr),
    align: left,
    inset: (x: 4pt, y: 3pt),
    stroke: (_, y) => (top: none, left: none, right: none,
      bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border }),
    fill: (_, row) => if row == 0 { surface } else { white },
    table.header(
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[IO],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[TU],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[LUI/LEI],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[NOI],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[VOI],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[LORO],
    ),
    [-ei], [-esti], [-ebbe], [-emmo], [-este], [-ebbero],
  )
]
#v(8pt)

// ── Reguläre Vollkonjugation ──────────────────────────────────────────────────

#cond-compare(
  "regolare — condizionale semplice",
  (
    ("parlare", "sprechen"),
    ("ripetere", "wiederholen"),
    ("sentire", "hören/fühlen"),
  ),
  (
    ("io",      "parlerei",     "ripeterei",     "sentirei"),
    ("tu",      "parleresti",   "ripeteresti",   "sentiresti"),
    ("lui/lei", "parlerebbe",   "ripeterebbe",   "sentirebbe"),
    ("noi",     "parleremmo",   "ripeteremmo",   "sentiremmo"),
    ("voi",     "parlereste",   "ripetereste",   "sentireste"),
    ("loro",    "parlerebbero", "ripeterebbero", "sentirebbero"),
  ),
)

#colbreak()

// ── Ausiliare: essere & avere ─────────────────────────────────────────────────

#cond-compare(
  "ausiliare — irregolare",
  (
    ("essere", "sein"),
    ("avere", "haben"),
  ),
  (
    ("io",      "sarei",     "avrei"),
    ("tu",      "saresti",   "avresti"),
    ("lui/lei", "sarebbe",   "avrebbe"),
    ("noi",     "saremmo",   "avremmo"),
    ("voi",     "sareste",   "avreste"),
    ("loro",    "sarebbero", "avrebbero"),
  ),
)

// ── Unregelmäßige Stämme ──────────────────────────────────────────────────────

#block(breakable: false)[
  #line(length: 100%, stroke: 0.4pt + border)
  #v(3pt)
  #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[UNREGELMÄSSIGE STÄMME — gleiche Endungen]
  #v(4pt)
  #set text(size: 7.5pt)
  #table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: left,
    inset: (x: 4pt, y: 2.5pt),
    stroke: (_, y) => (top: none, left: none, right: none,
      bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border }),
    fill: (_, row) => if row == 0 { surface } else { white },
    table.header(
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[VERB],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[STAMM],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[VERB],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[STAMM],
    ),
    [andare],   text(fill: accent)[andr-],   [venire],   text(fill: accent)[verr-],
    [volere],   text(fill: accent)[vorr-],   [potere],   text(fill: accent)[potr-],
    [dovere],   text(fill: accent)[dovr-],   [sapere],   text(fill: accent)[sapr-],
    [fare],     text(fill: accent)[far-],    [dare],     text(fill: accent)[dar-],
    [stare],    text(fill: accent)[star-],   [bere],     text(fill: accent)[berr-],
    [tenere],   text(fill: accent)[terr-],   [rimanere], text(fill: accent)[rimarr-],
  )
  #v(4pt)
  #text(size: 6.5pt, fill: ink-sec)[Doppel-r bei Verben auf -enire, -olere: venire → verr-, volere → vorr-]
  #v(2pt)
  #text(size: 6.5pt, fill: ink-sec)[Vokalausfall bei -vere, -pere, -vere: avere → avr-, sapere → sapr-]
]
#v(7pt)

] // end columns

// ── page 2 ───────────────────────────────────────────────────────────────────

#page-title[Condizionale Semplice — Verwendung][VERBI MODALI · IRREGOLARI · USO]

#columns(2, gutter: 0.9cm)[

// ── Verbi Modali ──────────────────────────────────────────────────────────────

#cond-compare(
  "verbi modali",
  (
    ("volere", "wollen"),
    ("potere", "können/dürfen"),
    ("dovere", "müssen/sollen"),
  ),
  (
    ("io",      "vorrei",     "potrei",     "dovrei"),
    ("tu",      "vorresti",   "potresti",   "dovresti"),
    ("lui/lei", "vorrebbe",   "potrebbe",   "dovrebbe"),
    ("noi",     "vorremmo",   "potremmo",   "dovremmo"),
    ("voi",     "vorreste",   "potreste",   "dovreste"),
    ("loro",    "vorrebbero", "potrebbero", "dovrebbero"),
  ),
)

// ── Wichtige Bewegungs- und Stammverben ───────────────────────────────────────

#cond-compare(
  "irregolare — stamm + endungen",
  (
    ("andare", "gehen"),
    ("venire", "kommen"),
    ("fare", "machen/tun"),
  ),
  (
    ("io",      "andrei",     "verrei",     "farei"),
    ("tu",      "andresti",   "verresti",   "faresti"),
    ("lui/lei", "andrebbe",   "verrebbe",   "farebbe"),
    ("noi",     "andremmo",   "verremmo",   "faremmo"),
    ("voi",     "andreste",   "verreste",   "fareste"),
    ("loro",    "andrebbero", "verrebbero", "farebbero"),
  ),
)

// ── Condizionale Passato ──────────────────────────────────────────────────────

#block(breakable: false)[
  #line(length: 100%, stroke: 0.4pt + border)
  #v(3pt)
  #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[CONDIZIONALE PASSATO — ZUSAMMENGESETZT]
  #v(4pt)
  #set text(size: 7.5pt)
  #text(weight: 500)[sarei / avrei] + participio passato
  #v(4pt)
  #set text(size: 7pt)
  #text(fill: ink-sec, style: "italic")[Avrei comprato il biglietto. — Ich hätte das Ticket gekauft.]
  #linebreak()
  #text(fill: ink-sec, style: "italic")[Sarei andato·a prima. — Ich wäre früher gegangen.]
  #linebreak()
  #text(fill: ink-sec, style: "italic")[Avresti dovuto dirmelo. — Du hättest es mir sagen sollen.]
]
#v(7pt)

#colbreak()

// ── Verwendung ────────────────────────────────────────────────────────────────

#tense-block("Höfliche Bitten", "cortesia — höflicher als der Indikativ", (
  ("Wunsch höflich ausdrücken", "Vorrei un caffè, per favore."),
  ("Um Erlaubnis bitten", "Potrei avere il conto?"),
  ("Jemanden um etwas bitten", "Potresti aiutarmi un momento?"),
  ("Höflicher Vorschlag", "Potremmo parlarne dopo?"),
))

#tense-block("Wünsche & Träume", "desideri — irreale Vorstellung", (
  ("Sehnsucht / Traum", "Vorrei vivere in Italia."),
  ("Hypothetischer Wunsch", "Mangerei volentieri una pizza."),
  ("Ziel / Berufswunsch", "Diventerei insegnante."),
))

#tense-block("Ratschläge", "consigli — dovresti / potresti", (
  ("Empfehlung (du solltest …)", "Dovresti dormire di più."),
  ("Vorschlag (du könntest …)", "Potresti provare a telefonare."),
  ("Vorwurf (hättest … sollen)", "Avresti dovuto dirmelo prima."),
))

] // end columns
