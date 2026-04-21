# Italian Cheatsheet — Agent Reference

## Project

Printable A4 PDF cheatsheets for German speakers learning Italian.
Each `.typ` file compiles to a same-named `.pdf`.

```
typst compile cheatsheet.typ
typst compile letteratura.typ
```

Typst 0.14+ required (`brew install typst`).

### Source files

| File | Content |
|---|---|
| `shared.typ` | Palette, template function, all renderer functions — imported by every cheatsheet |
| `cheatsheet.typ` | Verb conjugations, vocabulary, grammar rules (6 pages) |
| `letteratura.typ` | Literature & reading vocabulary (3 pages) |

### Starting a new cheatsheet

```typst
#import "shared.typ": *
#show: cheatsheet

#page-title[Titolo][SOTTOTITOLO · SEZIONE]

#columns(2, gutter: 0.9cm)[
// content
] // end columns
```

---

## Design

Dieter Rams principles applied to print. Key rules:

- Font: `("Helvetica Neue", "Helvetica", "Noto Sans", "Arial")` — 8pt body; Noto Sans is for the Typst web version, the warning about it not being installed locally is harmless
- Table style: horizontal rules only, no vertical strokes, no alternating fills
- Header row fill: `#f0efea`; body text: `#1a1a1a`; secondary text: `#6a6a66`; borders: `#d4d3cc`
- Two-column A4 layout via `#columns(2, gutter: 0.9cm)`; page count is not a constraint

### Typographic hierarchy

Four levels. The decision rule: **accent = primary label for content; ink-sec = structural or classifier**.

| Level | Role | Size | Weight | Tracking | Case | Fill |
|---|---|---|---|---|---|---|
| L1 — Page title | one per page | 11pt | 600 | 0.03em | Title | `ink` |
| L1 — Page subtitle | inline after title via `#h(10pt)` | 7pt | 500 | 0.1em | UPPER | `ink-sec` |
| L2 — Content block name | names the main subject of a standalone block (tense, preposition) | 9pt | 600 | — | Title | `accent` |
| L3 — Category label | names a group of related items (vocab group, pronunciation category); no separator rule above | 6.5pt | 500 | 0.1em | UPPER | `accent` |
| L4 — Section divider | structural break within a page; always preceded by `#line(length: 100%, stroke: 0.4pt + border)` | 6.5pt | 500 | 0.1em | UPPER | `ink-sec` |
| L4 — Block classifier | describes the type/group of the block below; appears above an L2 label (verb group type) | 6.5pt | 500 | 0.1em | UPPER | `ink-sec` |

**Identifying signal**: a separator `#line(...)` above a label → L4 (ink-sec). No separator, names the subject → accent (L2 or L3 by size). Classifies what follows → L4 (ink-sec).

---

## Palette variables

Defined in `shared.typ`. Import via `#import "shared.typ": *`.

```typst
#let ink      = rgb("#1a1a1a")
#let ink-sec  = rgb("#6a6a66")
#let border   = rgb("#d4d3cc")
#let surface  = rgb("#f0efea")
#let accent   = rgb("#e8420a")
```

---

## Renderer functions

All defined in `shared.typ`. Available after `#import "shared.typ": *`.

### `#verb-section` — one verb, all three tenses

Use when the verb is irregular across multiple tenses (e.g. dire, fare, essere), or as the standard paradigm example for a conjugation class.

```typst
#verb-section(
  "dire", "sagen", "irregolare",
  (
    ("io",      "dico",    "dicevo",    "ho detto"),
    ("tu",      "dici",    "dicevi",    "hai detto"),
    ("lui/lei", "dice",    "diceva",    "ha detto"),
    ("noi",     "diciamo", "dicevamo",  "abbiamo detto"),
    ("voi",     "dite",    "dicevate",  "avete detto"),
    ("loro",    "dicono",  "dicevano",  "hanno detto"),
  ),
  (
    ("tense": "Presente",         "text": "Dico sempre la verità."),
    ("tense": "Imperfetto",       "text": "Diceva sempre bugie."),
    ("tense": "Passato prossimo", "text": "Cosa hai detto?"),
  ),
)
```

### `#verb-compare` — multiple verbs side by side, Presente focus

Use when grouping verbs that share an auxiliary or conjugation pattern, and whose Imperfetto/P.prossimo can be summarised compactly (typically: irregular only in Presente).

```typst
#verb-compare(
  "irregolare (essere)",                         // category label (uppercase in output)
  (                                              // verb name + German translation pairs
    ("andare", "gehen"),
    ("venire", "kommen"),
  ),
  (                                              // Presente: one tuple per pronome row (pronome + N verb forms)
    ("io",      "vado",    "vengo"),
    ("tu",      "vai",     "vieni"),
    ("lui/lei", [va],      "viene"),             // use [content] for accented/special forms
    ("noi",     "andiamo", "veniamo"),
    ("voi",     "andate",  "venite"),
    ("loro",    "vanno",   "vengono"),
  ),
  "andavo · venivo (regolare dal tema)",         // Imperfetto compact note (io-form)
  "andato·a · venuto·a (essere — accordo)",      // P.prossimo compact note
)
```

Use `[content]` literal (not a plain string) for forms with accents or inline annotations:
- `[è]`, `[va]`, `[dà]`, `[può]`, `[do]`
- `[finisco #text(fill: ink-sec, size: 7pt)[†]]` for footnote markers

### `#vocab-group` — vocabulary list, two columns

```typst
#vocab-group("Alltag", (
  ("mangiare",  "essen"),
  ("dormire",   "schlafen"),
  ("lasciare",  "lassen / verlassen", "lasciarsi (riflessivo) = sich trennen: ci siamo lasciati"),
))
```

Entries are 2-tuples `("italiano", "deutsch")` or 3-tuples `("italiano", "deutsch", "note")`.
A 3-tuple renders the note as an indented subrow (arrow + italic text) spanning both columns; the border above the note row is suppressed so it visually attaches to the entry above.

Row index precomputation (no `table.header` in vocab-group — `y=0` is the first data row):
```typst
let note-rows = ()
let ri = 0
for e in entries {
  if e.len() == 3 { note-rows = note-rows + (ri + 1,); ri = ri + 2 }
  else             { ri = ri + 1 }
}
```

Group labels render in accent color (`fill: accent`).

### `#prep-entry` — preposition usage block

```typst
#prep-entry("a", (
  ("Städte (Ort + Ziel):", "sono a Roma · vado a Roma"),
  ("Uhrzeit:", "alle tre (um drei Uhr)"),
))
```

Renders the preposition name in large accent color, followed by labeled use-case lines.

### `#tense-block` — tense rule block

```typst
#tense-block("Presente", "Gegenwart / Gewohnheit / nahe Zukunft", (
  ("Gegenwärtiger Zustand oder Handlung", "Sono stanco. · Lavoro in ufficio."),
  ("Gewohnheit oder Wiederholung",        "Ogni mattina bevo un caffè."),
))
```

Each rule is a 2-tuple: rule label (weight 500) + italic example sentence.

### `#ann` — annotation helper

```typst
#ann[† infisso -isc- in io/tu/lui/loro al Presente; assente in noi/voi.]
```

Renders body text in `ink-sec` at 7pt. Used for footnotes below verb sections.

### `#page-title` — page header

```typst
#page-title[Titolo][SOTTOTITOLO]
```

Renders L1 title + subtitle inline, followed by a `0.6pt + ink` separator line and spacing.
Use at the top of every page. Exception: Pronuncia page in `cheatsheet.typ` uses a lighter
`0.3pt + border` line — kept inline there.

---

## Document structure

### cheatsheet.typ (6 pages)

#### Pages 1–2: Verbi Italiani — Coniugazione

Two-column conjugation tables. All `#verb-section` and `#verb-compare` calls.

Footer note: Passato prossimo formation rules + `·` notation explanation (`x/y = maskulin/feminin`).

#### Page 3: Vocabolario Comune — Verbi Frequenti

Two-column `#vocab-group` calls. Ends with a reflexive verb footnote via `#ann`.

#### Page 4: Parole Utili

Two-column `#vocab-group` calls for function words (adverbs, conjunctions, indefinites, place words).

#### Page 5: Preposizioni Articolate

Full contraction grid (preposition × article), followed by a two-column section "Verwendung der Präpositionen" using `#prep-entry`. `#colbreak()` placed before `su` to balance columns.

#### Page 6: I Tempi Verbali

Two-column `#tense-block` calls for the three tenses, followed by:
- Imperfetto vs. Passato prossimo contrast section (two-column inline blocks)
- Gerundio & Progressivo: formation table (-ando/-endo) + stare + gerundio usage
- Imperativo — 2. Person Singular (tu): formation table + irregular forms table
- Imperativo voi
- Pronomi oggetto diretto: pronoun table + Passato prossimo agreement rules

### letteratura.typ (3 pages)

#### Page 1: Il Libro

Two-column `#vocab-group` calls: Physisches Buch, Struktur, Personen & Rollen (Text), Branche & Berufe, Gattungen. Nouns include article (`"il romanzo"`, `"la pagina"`).

#### Page 2: Contenuto & Racconto

Two-column `#vocab-group` calls: Trama & Thema, Erzählstruktur, Stil, Lektüre & Verstehen.

#### Page 3: Media & Lesepraxis

Two-column `#vocab-group` calls: Zeitungen & Magazine, Erscheinungsform, Buchmarkt, Kritik & Empfehlung, Bibliothek & Buchhandlung, Digitale Formate.

---

## Current verb inventory

### Full tables (`#verb-section`)

| Verb | DE | Group label |
|---|---|---|
| parlare | sprechen | verbi in -are |
| ripetere | wiederholen | verbi in -ere |
| sentire | hören/fühlen | verbi in -ire (tipo I) |
| finire | beenden | verbi in -ire (tipo II, -isc-) |
| essere | sein | ausiliare |
| avere | haben | ausiliare |
| fare | machen/tun | irregolare |
| volere | wollen | modale |
| potere | können/dürfen | modale |
| dovere | müssen/sollen | modale |
| dire | sagen | irregolare |

### Comparison tables (`#verb-compare`)

| Group label | Verbs | Auxiliary |
|---|---|---|
| irregolare (essere) | andare · venire · uscire · stare | essere |
| irregolare (avere) | dare · sapere · bere | avere |

---

## Current vocabulary groups

### Page 3 — Vocabolario Comune

| Group label | Verbs (count) |
|---|---|
| Kommunikation | ascoltare, leggere, guardare, capire, rispondere, chiedere, chiamare, incontrare (8) |
| Bewegung | entrare, tornare, arrivare, partire, camminare, passeggiare, correre, portare, prendere (9) |
| Alltag | mangiare, dormire, lavorare, studiare, comprare, aprire, chiudere, cucinare (8) |
| Denken & Fühlen | pensare, credere, ricordare, dimenticare, sperare, preferire, amare, piacere (8) |
| Handlungen | trovare, perdere, mettere, lasciare, usare, provare, aiutare, aspettare (8) |
| Küche & Zubereitung | preparare, tagliare, aggiungere, versare, mescolare (5) |
| Kennen & Lehren | vedere, conoscere, imparare, insegnare, spiegare, mostrare, ricevere, ripetere, seguire (9) |
| Alltag & Freizeit | vivere, abitare, pagare, cambiare, passare, cantare, ballare, viaggiare, suonare (9) |
| Zustand & Veränderung | diventare, sembrare, restare, cominciare, continuare, smettere, succedere, riuscire, vendere, giocare, convivere (11) |
| Verbi Riflessivi | chiamarsi, svegliarsi, alzarsi, lavarsi, vestirsi, sedersi, addormentarsi, sentirsi, trovarsi, innamorarsi, divertirsi, arrabbiarsi, annoiarsi, interessarsi, preoccuparsi, sbagliarsi, laurearsi (17) |

### Page 4 — Parole Utili

| Group label | Entries (count) |
|---|---|
| Frequenz | sempre, spesso, a volte, di solito, raramente, mai (6) |
| Zeit | ora/adesso, poi, dopo, prima, già, ancora, subito, presto, tardi, fa, scorso, prossimo (12) |
| Quantität & Indefinita | tutto, molto, poco, abbastanza, troppo, qualcosa, niente, qualcuno, nessuno, ogni (10) |
| Konjunktionen | e, ma, o, però, quindi, perché, quando, se, mentre, durante, anche, allora, che (13) |
| Ort & Richtung | qui/qua, lì/là, dentro, fuori, sopra, sotto, vicino, lontano, ovunque (9) |
| Fragewörter | chi, che cosa/cosa, dove, quando, perché, come, quanto, quale/quali (8) |

---

## Linguistic notes

- **essere auxiliary**: past participle agrees with subject in gender and number (andato·a·i·e). Show with `·` notation. Footer explains: `x/y = maskulin/feminin`.
- **stare**: shares participle `stato` with essere — note in ppr-note.
- **finire** type (-isc-): infisso in io/tu/lui/loro of Presente only; absent in noi/voi. Mark with `†`. Same pattern: capire, preferire, costruire.
- **bere**: stem from Latin *bibere* → bev- (bevevo, bevuto — irregular stem, regular endings).
- **Passato prossimo** = auxiliary (avere/essere) + past participle. Regular participles: -are → -ato, -ere → -uto, -ire → -ito.
- **Reflexive verbs**: always use essere as auxiliary; participle agrees with subject. Pronouns: mi · ti · si · ci · vi · si (before the verb).
- **Doppelnegation**: `non … mai`, `non … niente`, `non … nessuno` — non before verb, negative word after.
- **fa** (vor/ago): always postpositioned — `due anni fa`.
- **mentre vs. durante**: mentre + verb clause; durante + noun.
- **Apostrophe vs. accent**: va', fa', da', sta', di' use apostrophe (apocope), not accent.
- **Imperativo negation** (tu): non + infinitive — `non parlare!`, `non venire!`.
- **ripetere** replaced **scrivere** as the -ere paradigm verb (fully regular; past participle ripetuto).
