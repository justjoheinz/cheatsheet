#import "shared.typ": *
#show: cheatsheet

// ── preposizioni articolate ───────────────────────────────────────────────────

#page-title[Preposizioni Articolate][PREPOSIZIONE · ARTICOLO DETERMINATIVO]

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
