<!-- BEGIN swamp managed section - DO NOT EDIT -->
# Project

This repository is managed with [swamp](https://github.com/systeminit/swamp).

## Rules

1. **Search before you build.** When automating AWS, APIs, or any external service: (a) search local types with `swamp model type search <query>`, (b) search community extensions with `swamp extension search <query>`, (c) if a community extension exists, install it with `swamp extension pull <package>` instead of building from scratch, (d) only create a custom extension model in `extensions/models/` if nothing exists. Use the `swamp-extension-model` skill for guidance. The `command/shell` model is ONLY for ad-hoc one-off shell commands, NEVER for wrapping CLI tools or building integrations.
2. **Extend, don't be clever.** When a model covers the domain but lacks the method you need, extend it with `export const extension` — don't bypass it with shell scripts, CLI tools, or multi-step hacks. One method, one purpose. Use `swamp model type describe <type> --json` to check available methods.
3. **Use the data model.** Once data exists in a model (via `lookup`, `start`, `sync`, etc.), reference it with CEL expressions. Don't re-fetch data that's already available.
4. **CEL expressions everywhere.** Wire models together with CEL expressions. Always prefer `data.latest("<name>", "<dataName>").attributes.<field>` over the deprecated `model.<name>.resource.<spec>.<instance>.attributes.<field>` pattern.
5. **Verify before destructive operations.** Always `swamp model get <name> --json` and verify resource IDs before running delete/stop/destroy methods.
6. **Prefer fan-out methods over loops.** When operating on multiple targets, use a single method that handles all targets internally (factory pattern) rather than looping N separate `swamp model method run` calls against the same model. Multiple parallel calls against the same model contend on the per-model lock, causing timeouts. A single fan-out method acquires the lock once and produces all outputs in one execution. Check `swamp model type describe` for methods that accept filters or produce multiple outputs.
7. **Extension npm deps are bundled, not lockfile-tracked.** Swamp's bundler inlines all npm packages (except zod) into extension bundles at bundle time. `deno.lock` and `package.json` do NOT cover extension model dependencies — this is by design. Always pin explicit versions in `npm:` import specifiers (e.g., `npm:lodash-es@4.17.21`).
8. **Reports for reusable data pipelines.** When the task involves building a repeatable pipeline to transform, aggregate, or analyze model output (security reports, cost analysis, compliance checks, summaries), create a report extension. Use the `swamp-report` skill for guidance.

## Skills

**IMPORTANT:** Always load swamp skills, even when in plan mode. The skills provide
essential context for working with this repository.

- `swamp-model` - Work with swamp models (creating, editing, validating)
- `swamp-workflow` - Work with workflows (creating, editing, running)
- `swamp-vault` - Manage secrets and credentials
- `swamp-data` - Manage model data lifecycle
- `swamp-report` - Create and run reports for models and workflows
- `swamp-repo` - Repository management
- `swamp-extension-model` - Create custom TypeScript models
- `swamp-extension-driver` - Create custom execution drivers
- `swamp-extension-datastore` - Create custom datastore backends
- `swamp-extension-vault` - Create custom vault providers
- `swamp-issue` - Submit bug reports and feature requests
- `swamp-troubleshooting` - Debug and diagnose swamp issues

## Getting Started

**IMPORTANT:** At the start of every conversation, run
`swamp model search --json`. If no models are returned (empty result), you MUST
immediately invoke the `swamp-getting-started` skill before doing anything else.
This walks new users through an interactive onboarding tutorial.

If models already exist, start by using the `swamp-model` skill to work with
swamp models.

## Commands

Use `swamp --help` to see available commands.
<!-- END swamp managed section -->

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
| `cheatsheet.typ` | Vocabulary (Verbi Frequenti) + tense usage rules (2 pages) |
| `verbi.typ` | Verbi Frequenti — standalone vocab cheatsheet (1 page) |
| `presente.typ` | Presente conjugation tables (1 page) |
| `imperfetto.typ` | Imperfetto formation, paradigms, usage (1 page) |
| `passato.typ` | Passato Prossimo formation, paradigms, usage (1 page) |
| `condizionale.typ` | Condizionale Semplice (1 page) |
| `futuro.typ` | Futuro Semplice (1 page) |
| `imperativo.typ` | Imperativo Tu & Voi (1 page) |
| `parole.typ` | Function words — adverbs, conjunctions, place words, evaluation (1 page) |
| `preposizioni.typ` | Preposizioni Articolate + usage (1 page) |
| `pronuncia.typ` | Pronunciation rules (1 page) |
| `letteratura.typ` | Literature & reading vocabulary (3 pages) |
| `arte.typ`, `casa.typ`, `cucina.typ`, `numeri.typ`, `orientierung.typ`, `politica.typ`, `vino.typ` | Thematic vocabularies |

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

### cheatsheet.typ (2 pages)

#### Page 1: Vocabolario Comune — Verbi Frequenti

Two-column `#vocab-group` calls (same groups as verbi.typ). Ends with a reflexive verb footnote via `#ann`.

#### Page 2: I Tempi Verbali — Regole d'Uso — Presente

`#tense-block` for Presente, followed by Gerundio & Progressivo section (formation table + stare + gerundio usage).

### verbi.typ (1 page)

#### Page 1: Verbi Frequenti — Vocabolario Comune

Standalone version of the verb vocabulary. Two-column `#vocab-group` calls. Same groups as cheatsheet.typ page 1, with additional entries: `togliere` in Handlungen, `toccare` in Handlungen, `tradurre` in Kennen & Lehren.

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

### cheatsheet.typ / verbi.typ — Vocabolario Comune

verbi.typ has additional entries marked with *. Both files share the same group structure.

| Group label | Verbs (count) |
|---|---|
| Kommunikation | ascoltare, leggere, guardare, capire, rispondere, chiedere, chiamare, incontrare (8) |
| Bewegung | entrare, tornare, arrivare, partire, camminare, passeggiare, correre, portare, prendere (9) |
| Alltag | mangiare, dormire, lavorare, studiare, comprare, aprire, chiudere, cucinare (8) |
| Denken & Fühlen | pensare, credere, ricordare, dimenticare, sperare, preferire, amare, piacere (8) |
| Handlungen | trovare, perdere, mettere, lasciare, usare, provare, aiutare, aspettare, *togliere, *toccare (8+2) |
| Küche & Zubereitung | preparare, tagliare, aggiungere, versare, mescolare (5) |
| Kennen & Lehren | vedere, conoscere, imparare, insegnare, spiegare, mostrare, ricevere, ripetere, seguire, *tradurre (9+1) |
| Alltag & Freizeit | vivere, abitare, pagare, cambiare, passare, cantare, ballare, viaggiare, suonare (9) |
| Zustand & Veränderung | diventare, sembrare, restare, cominciare, continuare, smettere, succedere, riuscire, vendere, giocare, convivere (11) |
| Verbi Riflessivi | chiamarsi, svegliarsi, alzarsi, lavarsi, vestirsi, sedersi, addormentarsi, sentirsi, trovarsi, innamorarsi, divertirsi, arrabbiarsi, annoiarsi, interessarsi, preoccuparsi, sbagliarsi, laurearsi (17) |

### parole.typ — Parole Utili

| Group label | Entries (count) |
|---|---|
| Frequenz | sempre, spesso, a volte, di solito, raramente, mai (6) |
| Zeit | ora/adesso, poi, dopo, prima, già, ancora, subito, presto, tardi, fa, scorso, prossimo (12) |
| Größe & Form | grande, piccolo, lungo, corto, largo, stretto, alto, basso, pieno, vuoto (10) |
| Quantität & Indefinita | tutto, molto, poco, abbastanza, troppo, qualcosa, niente, qualcuno, nessuno, ogni (10) |
| Konjunktionen | e, ma, o, però, quindi, perché, quando, se, mentre, durante, anche, allora, che (13) |
| Ort & Richtung | qui/qua, lì/là, dentro, fuori, sopra, sotto, vicino, lontano, ovunque (9) |
| Fragewörter | chi, che cosa/cosa, dove, quando, perché, come, quanto, quale/quali (8) |
| Bewertung | giusto, sbagliato, corretto, falso, vero, esatto (6) |

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
