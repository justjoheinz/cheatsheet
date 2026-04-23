#import "shared.typ": *
#show: cheatsheet

// ── numeri ────────────────────────────────────────────────────────────────────

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
