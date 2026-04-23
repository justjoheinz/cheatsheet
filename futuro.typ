#import "shared.typ": *
#show: cheatsheet

#page-title[Futuro Semplice][BILDUNG · STAMMVERBEN · VERWENDUNG]

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
    [-ò], [-ai], [-à], [-emo], [-ete], [-anno],
  )
]
#v(8pt)

// ── Reguläre Vollkonjugation ──────────────────────────────────────────────────

#cond-compare(
  "regolare — futuro semplice",
  (
    ("parlare", "sprechen"),
    ("ripetere", "wiederholen"),
    ("sentire", "hören/fühlen"),
  ),
  (
    ("io",      "parlerò",    "ripeterò",    "sentirò"),
    ("tu",      "parlerai",   "ripeterai",   "sentirai"),
    ("lui/lei", "parlerà",    "ripeterà",    "sentirà"),
    ("noi",     "parleremo",  "ripeteremo",  "sentiremo"),
    ("voi",     "parlerete",  "ripeterete",  "sentirete"),
    ("loro",    "parleranno", "ripeteranno", "sentiranno"),
  ),
)

#colbreak()

// ── Ausiliare ─────────────────────────────────────────────────────────────────

#cond-compare(
  "ausiliare — irregolare",
  (
    ("essere", "sein"),
    ("avere", "haben"),
  ),
  (
    ("io",      "sarò",    "avrò"),
    ("tu",      "sarai",   "avrai"),
    ("lui/lei", "sarà",    "avrà"),
    ("noi",     "saremo",  "avremo"),
    ("voi",     "sarete",  "avrete"),
    ("loro",    "saranno", "avranno"),
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
    [andare],  text(fill: accent)[andr-],  [venire],  text(fill: accent)[verr-],
    [volere],  text(fill: accent)[vorr-],  [potere],  text(fill: accent)[potr-],
    [dovere],  text(fill: accent)[dovr-],  [sapere],  text(fill: accent)[sapr-],
    [fare],    text(fill: accent)[far-],   [dare],    text(fill: accent)[dar-],
    [stare],   text(fill: accent)[star-],  [bere],    text(fill: accent)[berr-],
    [tenere],  text(fill: accent)[terr-],  [rimanere],text(fill: accent)[rimarr-],
  )
  #v(3pt)
  #text(size: 6.5pt, fill: ink-sec)[Gleiche Stämme wie Condizionale semplice — nur die Endungen unterscheiden sich.]
]
#v(7pt)

// ── Verwendung ────────────────────────────────────────────────────────────────

#tense-block("Verwendung", "wann das Futuro semplice gebraucht wird", (
  ("Zukunft & Absicht", "Domani parlerò con il direttore. · L'anno prossimo studierò a Roma."),
  ("Vermutung über Gegenwart", "Saranno le tre. · Chi sarà? (Es wird wohl … sein.)"),
  ("Reale Bedingung (se + futuro)", "Se verrai, sarò contento. — Wenn du kommst, bin ich froh."),
))

] // end columns
