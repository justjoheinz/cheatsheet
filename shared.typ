// ── palette ──────────────────────────────────────────────────────────────────

#let ink      = rgb("#1a1a1a")
#let ink-sec  = rgb("#6a6a66")
#let border   = rgb("#d4d3cc")
#let surface  = rgb("#f0efea")
#let accent   = rgb("#e8420a")

// ── document template ────────────────────────────────────────────────────────

#let cheatsheet(body) = {
  set page(
    paper: "a4",
    margin: (left: 2cm, right: 1cm, top: 1cm, bottom: 1cm),
    background: {
      // DIN 824 — 2-Loch-Locher: Lochmitten bei 80 mm und 217 mm von oben,
      // Lochmitte 10,5 mm vom linken Rand (Linie 5,5–15,5 mm = zentriert auf 10,5 mm)
      place(left + top, dx: 5.5mm, dy: 80mm,
        line(length: 10mm, stroke: 0.4pt + border))
      place(left + top, dx: 5.5mm, dy: 217mm,
        line(length: 10mm, stroke: 0.4pt + border))
    },
  )
  set text(size: 8pt, font: ("Helvetica Neue", "Helvetica", "Noto Sans", "Arial"), fill: ink)
  set par(leading: 0.5em)
  body
}

// ── page title ───────────────────────────────────────────────────────────────

#let page-title(title, subtitle) = {
  block(width: 100%)[
    #text(size: 11pt, weight: 600, tracking: 0.03em)[#title]
    #h(10pt)
    #text(size: 7pt, weight: 500, tracking: 0.1em, fill: ink-sec)[#subtitle]
  ]
  v(5pt)
  line(length: 100%, stroke: 0.6pt + ink)
  v(7pt)
}

// ── table: horizontal rules only, no vertical strokes ────────────────────────

#let conj-table(rows) = {
  set text(size: 7.5pt)
  table(
    columns: (1.5cm, 1fr),
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
    ),
    ..rows.map(r => (r.at(0), r.at(1))).flatten().map(c => [#c]),
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

#let verb-compare(group-label, verbs, presente-rows) = {
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

// ── preposition usage renderer ───────────────────────────────────────────────

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

// ── condizionale comparison table ───────────────────────────────────────────

#let cond-compare(group-label, verbs, cond-rows) = {
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
      ..cond-rows.flatten().map(c => [#c]),
    )
  ]
  v(7pt)
}

// ── tense rule block renderer ────────────────────────────────────────────────

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
