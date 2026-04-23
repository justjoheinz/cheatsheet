#import "shared.typ": *
#show: cheatsheet

// ── pronuncia ─────────────────────────────────────────────────────────────────
#let lb = "\u{5B}"
#let rb = "\u{5D}"

#page-title[Pronuncia][REGOLE DI PRONUNCIA — CONSONANTI · VOCALI · ACCENTO]

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
