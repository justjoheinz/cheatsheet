#import "shared.typ": *
#show: cheatsheet

#page-title[Passato Prossimo][FORMAZIONE · PARTICIPIO · USO]

#columns(2, gutter: 0.9cm)[

// ── Bildungsregel ─────────────────────────────────────────────────────────────

#block(breakable: false)[
  #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[BILDUNGSREGEL]
  #v(4pt)
  #set text(size: 7.5pt)
  #table(
    columns: (0.6fr, 1fr, 1fr),
    align: left,
    inset: (x: 4pt, y: 3pt),
    stroke: (_, y) => (top: none, left: none, right: none,
      bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border }),
    fill: (_, row) => if row == 0 { surface } else { white },
    table.header(
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[KLASSE],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[PARTIZIP-ENDUNG],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[BEISPIEL],
    ),
    [-are], text(fill: accent)[-ato], [parlare → parlato],
    [-ere], text(fill: accent)[-uto], [ripetere → ripetuto],
    [-ire], text(fill: accent)[-ito], [sentire → sentito],
  )
  #v(6pt)
  #text(size: 6.5pt, weight: 500, fill: ink-sec)[Ausiliare avere — für alle Verbklassen gleich:]
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
    [ho], [hai], [ha], [abbiamo], [avete], [hanno],
  )
]
#v(8pt)

// ── Reguläre Vollkonjugation ──────────────────────────────────────────────────

#cond-compare(
  "regolare con avere — passato prossimo",
  (
    ("parlare", "sprechen"),
    ("ripetere", "wiederholen"),
    ("sentire", "hören/fühlen"),
  ),
  (
    ("io",      "ho parlato",      "ho ripetuto",      "ho sentito"),
    ("tu",      "hai parlato",     "hai ripetuto",     "hai sentito"),
    ("lui/lei", "ha parlato",      "ha ripetuto",      "ha sentito"),
    ("noi",     "abbiamo parlato", "abbiamo ripetuto", "abbiamo sentito"),
    ("voi",     "avete parlato",   "avete ripetuto",   "avete sentito"),
    ("loro",    "hanno parlato",   "hanno ripetuto",   "hanno sentito"),
  ),
)

// ── Verwendung ────────────────────────────────────────────────────────────────

#tense-block("Verwendung", "wann das Passato prossimo gebraucht wird", (
  ("Einmaliges abgeschlossenes Ereignis", "Ieri ho chiamato Marco."),
  ("Handlung mit Ergebnis im Vordergrund", "Ho mangiato. (Ich habe gegessen — bin satt.)"),
  ("Ereignis zu einem bestimmten Zeitpunkt", "Due anni fa ho iniziato a studiare l'italiano."),
  ("Kurzfristig zurückliegende Handlung", "Oggi mi sono svegliato tardi."),
))

#colbreak()

// ── Con essere — accordo ──────────────────────────────────────────────────────

#cond-compare(
  "con essere — accordo del participio",
  (
    ("andare", "gehen"),
    ("venire", "kommen"),
  ),
  (
    ("io",      "sono andato·a",  "sono venuto·a"),
    ("tu",      "sei andato·a",   "sei venuto·a"),
    ("lui/lei", [è andato·a],     [è venuto·a]),
    ("noi",     "siamo andati·e", "siamo venuti·e"),
    ("voi",     "siete andati·e", "siete venuti·e"),
    ("loro",    "sono andati·e",  "sono venuti·e"),
  ),
)

#ann[Con essere il participio concorda con il soggetto: ·a = fem. Sg. · ·i = m. Pl. · ·e = fem. Pl.]

#v(7pt)

// ── Verbi con essere ──────────────────────────────────────────────────────────

#block(breakable: false)[
  #line(length: 100%, stroke: 0.4pt + border)
  #v(3pt)
  #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[VERBI CON ESSERE]
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
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[PARTIZIP],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[VERB],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[PARTIZIP],
    ),
    [andare],   text(fill: accent)[andato·a],   [venire],   text(fill: accent)[venuto·a],
    [arrivare], text(fill: accent)[arrivato·a], [partire],  text(fill: accent)[partito·a],
    [uscire],   text(fill: accent)[uscito·a],   [entrare],  text(fill: accent)[entrato·a],
    [tornare],  text(fill: accent)[tornato·a],  [scendere], text(fill: accent)[sceso·a],
    [salire],   text(fill: accent)[salito·a],   [rimanere], text(fill: accent)[rimasto·a],
    [essere],   text(fill: accent)[stato·a],    [stare],    text(fill: accent)[stato·a],
    [restare],  text(fill: accent)[restato·a],  [diventare],text(fill: accent)[diventato·a],
    [nascere],  text(fill: accent)[nato·a],     [morire],   text(fill: accent)[morto·a],
  )
  #v(3pt)
  #text(size: 7pt, fill: ink-sec)[Verbi riflessivi: immer essere — mi sono lavato·a · ci siamo alzati·e]
]
#v(7pt)

// ── Participi irregolari ──────────────────────────────────────────────────────

#block(breakable: false)[
  #line(length: 100%, stroke: 0.4pt + border)
  #v(3pt)
  #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[PARTICIPI IRREGOLARI — gleiche Endungen, unregelmäßiger Stamm]
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
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[PARTIZIP],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[VERB],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[PARTIZIP],
    ),
    [fare],      text(fill: accent)[fatto],    [dire],      text(fill: accent)[detto],
    [vedere],    text(fill: accent)[visto],    [leggere],   text(fill: accent)[letto],
    [scrivere],  text(fill: accent)[scritto],  [aprire],    text(fill: accent)[aperto],
    [mettere],   text(fill: accent)[messo],    [prendere],  text(fill: accent)[preso],
    [chiedere],  text(fill: accent)[chiesto],  [chiudere],  text(fill: accent)[chiuso],
    [rispondere],text(fill: accent)[risposto], [rompere],   text(fill: accent)[rotto],
    [bere],      text(fill: accent)[bevuto],   [perdere],   text(fill: accent)[perso],
    [scegliere], text(fill: accent)[scelto],   [offrire],   text(fill: accent)[offerto],
  )
]
#v(7pt)

// ── Pronomi oggetto diretto ───────────────────────────────────────────────────

#block(breakable: false)[
  #line(length: 100%, stroke: 0.4pt + border)
  #v(3pt)
  #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[PRONOMI OGGETTO DIRETTO — KONGRUENZ MIT DEM PARTIZIP]
  #v(4pt)
  #set text(size: 7.5pt)
  #table(
    columns: (1.1cm, 1fr),
    align: left,
    inset: (x: 4pt, y: 2.5pt),
    stroke: (_, y) => (top: none, left: none, right: none,
      bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border }),
    fill: (_, row) => if row == 0 { surface } else { white },
    table.header(
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[PRON.],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[DEUTSCH],
    ),
    text(weight: 600, fill: accent)[mi], [mich],
    text(weight: 600, fill: accent)[ti], [dich],
    text(weight: 600, fill: accent)[lo], [ihn / es (m.)],
    text(weight: 600, fill: accent)[la], [sie / es (f.)],
    text(weight: 600, fill: accent)[ci], [uns],
    text(weight: 600, fill: accent)[vi], [euch],
    text(weight: 600, fill: accent)[li], [sie (m. Pl.)],
    text(weight: 600, fill: accent)[le], [sie (f. Pl.)],
  )
  #v(2pt)
  #text(size: 7pt, fill: ink-sec)[vor dem konj. Verb]
  #v(5pt)
  #text(size: 7pt, weight: 500)[lo / la → l' + Partizip kongruiert]
  #v(3pt)
  #block(inset: (bottom: 3pt))[
    #text(size: 7pt, style: "italic", fill: ink-sec)[Hai visto Marco? → #text(fill: ink)[L']ho #text(fill: accent)[visto].]
    #linebreak()
    #text(size: 7pt, style: "italic", fill: ink-sec)[Hai visto Maria? → #text(fill: ink)[L']ho #text(fill: accent)[vista].]
  ]
  #text(size: 7pt, weight: 500)[li / le → kein Apostroph]
  #v(3pt)
  #block(inset: (bottom: 3pt))[
    #text(size: 7pt, style: "italic", fill: ink-sec)[Hai comprato i libri? → #text(fill: ink)[Li] ho #text(fill: accent)[comprati].]
    #linebreak()
    #text(size: 7pt, style: "italic", fill: ink-sec)[Hai comprato le mele? → #text(fill: ink)[Le] ho #text(fill: accent)[comprate].]
  ]
  #text(size: 7pt, weight: 500)[mi / ti / ci / vi → fakultativ]
  #v(3pt)
  #text(size: 7pt, style: "italic", fill: ink-sec)[Mi ha chiamato. / Mi ha chiamata. (beide korrekt)]
]
#v(7pt)

] // end columns
