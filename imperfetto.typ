#import "shared.typ": *
#show: cheatsheet

#page-title[Imperfetto][BILDUNG · ENDUNGEN · UNREGELMÄSSIGE · VERWENDUNG]

#columns(2, gutter: 0.9cm)[

// ── Bildungsregel ─────────────────────────────────────────────────────────────

#block(breakable: false)[
  #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[BILDUNGSREGEL]
  #v(4pt)
  #set text(size: 7.5pt)
  #table(
    columns: (1.5cm, 1fr, 1fr, 1fr),
    align: left,
    inset: (x: 4pt, y: 3pt),
    stroke: (_, y) => (top: none, left: none, right: none,
      bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border }),
    fill: (_, row) => if row == 0 { surface } else { white },
    table.header(
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[PRONOME],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[-ARE],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[-ERE],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[-IRE],
    ),
    [io],      text(weight: 600, fill: accent)[-avo], text(weight: 600, fill: accent)[-evo], text(weight: 600, fill: accent)[-ivo],
    [tu],      text(weight: 600, fill: accent)[-avi], text(weight: 600, fill: accent)[-evi], text(weight: 600, fill: accent)[-ivi],
    [lui/lei], text(weight: 600, fill: accent)[-ava], text(weight: 600, fill: accent)[-eva], text(weight: 600, fill: accent)[-iva],
    [noi],     text(weight: 600, fill: accent)[-avamo], text(weight: 600, fill: accent)[-evamo], text(weight: 600, fill: accent)[-ivamo],
    [voi],     text(weight: 600, fill: accent)[-avate], text(weight: 600, fill: accent)[-evate], text(weight: 600, fill: accent)[-ivate],
    [loro],    text(weight: 600, fill: accent)[-avano], text(weight: 600, fill: accent)[-evano], text(weight: 600, fill: accent)[-ivano],
  )
  #v(3pt)
  #text(size: 6.5pt, fill: ink-sec)[Stamm = Infinitiv − *re* · gleiche Endstruktur für alle Klassen]
]
#v(6pt)

// ── Reguläre Vollkonjugation ──────────────────────────────────────────────────

#cond-compare(
  "regolare — imperfetto",
  (
    ("parlare", "sprechen"),
    ("ripetere", "wiederholen"),
    ("sentire",  "hören/fühlen"),
  ),
  (
    ("io",      "parlavo",   "ripetevo",   "sentivo"),
    ("tu",      "parlavi",   "ripetevi",   "sentivi"),
    ("lui/lei", "parlava",   "ripeteva",   "sentiva"),
    ("noi",     "parlavamo", "ripetevamo", "sentivamo"),
    ("voi",     "parlavate", "ripetevate", "sentivate"),
    ("loro",    "parlavano", "ripetevano", "sentivano"),
  ),
)

// ── Ausiliare: essere & avere ─────────────────────────────────────────────────

#cond-compare(
  "ausiliare",
  (
    ("essere", "sein"),
    ("avere",  "haben"),
  ),
  (
    ("io",      "ero",      "avevo"),
    ("tu",      "eri",      "avevi"),
    ("lui/lei", "era",      "aveva"),
    ("noi",     "eravamo",  "avevamo"),
    ("voi",     "eravate",  "avevate"),
    ("loro",    "erano",    "avevano"),
  ),
)

#ann[*essere* vollständig unregelmäßig. *avere* regelmäßig (Stamm *ave-*). *Modali regelmäßig:* volevo · potevo · dovevo (Stamm vol-/pot-/dove-).]

#colbreak()

// ── Unregelmäßige Stämme ──────────────────────────────────────────────────────

#block(breakable: false)[
  #text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[UNREGELMÄSSIGE STÄMME — gleiche Endungen]
  #v(4pt)
  #set text(size: 7.5pt)
  #table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: left,
    inset: (x: 4pt, y: 2.5pt),
    stroke: (_, y) => (top: none, left: none, right: none,
      bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border }),
    fill: (_, row) => if row == 0 { surface } else { white },
    table.header(
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[VERB],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[STAMM],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[IO],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[VERB],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[STAMM],
      text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[IO],
    ),
    [essere],   text(fill: accent)[er-],      [ero],      [bere],     text(fill: accent)[beve-],    [bevevo],
    [fare],     text(fill: accent)[face-],    [facevo],   [tradurre], text(fill: accent)[traduce-], [traducevo],
    [dire],     text(fill: accent)[dice-],    [dicevo],   [porre],    text(fill: accent)[pone-],    [ponevo],
    [condurre], text(fill: accent)[conduce-], [conducevo],[trarre],   text(fill: accent)[trae-],    [traevo],
  )
  #v(3pt)
  #text(size: 6.5pt, fill: ink-sec)[*-urre:* produrre → produce- · *-orre:* disporre → dispone- · *-arre:* attrarre → attrae-]
]
#v(6pt)

// ── Verwendung ────────────────────────────────────────────────────────────────

#line(length: 100%, stroke: 0.4pt + border)
#v(5pt)
#text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: ink-sec)[VERWENDUNG]
#v(5pt)

#tense-block("Vergangener Zustand", "Zustand, Eigenschaft, Beschreibung — kein Ereignis", (
  ("Zustand / Eigenschaft / Beschreibung", "Era stanco. · La casa era grande. · Aveva paura."),
  ("Dauerhafter Zustand mit Zeitangabe", "Da bambino abitavo a Milano. · Aveva vent'anni."),
))

#tense-block("Gewohnheit & Hintergrundhandlung", "Wiederholung · laufende Handlung im Hintergrund", (
  ("Wiederkehrende Gewohnheit in der Vergangenheit", "Ogni estate andavamo al mare. · Da giovane suonavo la chitarra."),
  ("*mentre* + Imperfetto = Hintergrund zum P.prossimo-Ereignis", "Mentre dormivo, è arrivato Marco."),
))

#tense-block("Höfliche Abschwächung & da + Imperfetto", "cortesia · Dauer bis zu einem Vergangenheitspunkt", (
  ("Wunsch höflich abschwächen (weicher als Presente)", "Volevo un caffè. · Speravo di poterti parlare."),
  ("*da* + Imperfetto — andauernde Handlung bis zum Moment", "Aspettavo da un'ora quando è arrivato."),
))

] // end columns
