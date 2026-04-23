#import "shared.typ": *
#show: cheatsheet

#page-title[Imperativo][BEFEHLSFORM — TU & VOI]

#columns(2, gutter: 0.9cm)[

// ── imperativo tu (2. Person Singular) ───────────────────────────────────────
#text(size: 9pt, weight: 600, fill: accent)[Imperativo tu — 2. Person Singular]
#v(4pt)

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

#v(6pt)
#text(size: 7pt, weight: 500)[Verneinung: non + Infinitiv]
#linebreak()
#text(size: 7pt, style: "italic")[parla! → non parlare! · vieni! → non venire!]

#v(8pt)

// ── unregelmäßige tu-Formen ───────────────────────────────────────────────────
#text(size: 9pt, weight: 600, fill: accent)[Unregelmäßige tu-Formen]
#v(4pt)

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

#colbreak()

// ── imperativo voi (2. Person Plural) ─────────────────────────────────────────
#text(size: 9pt, weight: 600, fill: accent)[Imperativo voi — 2. Person Plural]
#v(4pt)

#text(size: 7pt, weight: 500)[Regel: gleich wie Presente (voi)]
#v(2pt)
#text(size: 7pt, style: "italic")[parlate! · ripetete! · sentite! · finite!]
#v(3pt)
#text(size: 7pt, fill: ink-sec)[Gilt für alle regelmäßigen Verben ohne Ausnahme.]

#v(6pt)

#text(size: 7pt, weight: 500)[Unregelmäßige voi-Formen]
#v(2pt)
#text(size: 7pt, style: "italic")[essere → #text(weight: 600, fill: accent)[siate!] #text(fill: ink-sec, size: 6.5pt)[(statt siete)] · avere → #text(weight: 600, fill: accent)[abbiate!] #text(fill: ink-sec, size: 6.5pt)[(statt avete)] · sapere → #text(weight: 600, fill: accent)[sappiate!] #text(fill: ink-sec, size: 6.5pt)[(statt sapete)]]
#v(2pt)
#text(size: 7pt, fill: ink-sec)[Alle übrigen (andare, fare, dare, dire, venire…) = reguläre Presente-voi-Form.]

#v(6pt)
#text(size: 7pt, weight: 500)[Verneinung: non + Imperativ-Form]
#linebreak()
#text(size: 7pt, style: "italic")[parlate! → non parlate! · venite! → non venite!]

] // end columns
