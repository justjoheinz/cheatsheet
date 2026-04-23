# Italienisch-Cheatsheet

Druckbare A4-PDFs für deutschsprachige Lernende der italienischen Sprache.

| PDF | Topic | Inhalt |
|---|---|---|
| [cheatsheet.pdf](cheatsheet.pdf) | Grammatik & Verben | Vocabolario Comune — Verbi Frequenti |
| [presente.pdf](presente.pdf) | Grammatik & Verben | Verbi Italiani — Coniugazione — Presente |
| [condizionale.pdf](condizionale.pdf) | Grammatik | Condizionale Semplice — Bildung · Endungen · Ausnahmen |
| [futuro.pdf](futuro.pdf) | Grammatik | Futuro Semplice — Bildung · Stammverben · Verwendung |
| [imperativo.pdf](imperativo.pdf) | Grammatik | Imperativo — Befehlsform — Tu & Voi |
| [imperfetto.pdf](imperfetto.pdf) | Grammatik | Imperfetto — Bildung · Endungen · Unregelmässige · Verwendung |
| [passato.pdf](passato.pdf) | Grammatik | Passato Prossimo — Bildung · Partizip · Verwendung |
| [parole.pdf](parole.pdf) | Vokabular | Parole Utili — Avverbi · Congiunzioni · Indefiniti · Luogo |
| [letteratura.pdf](letteratura.pdf) | Literatur | Il Libro — Bücher · Zeitungen · Literatur |
| [arte.pdf](arte.pdf) | Thematisch | Arte — Museo · Opere · Stili |
| [casa.pdf](casa.pdf) | Thematisch | La Casa — Gebäude · Häuser · Möbel · Inneneinrichtung |
| [cucina.pdf](cucina.pdf) | Thematisch | In Cucina — Küche · Kochen · Zubereitung |
| [numeri.pdf](numeri.pdf) | Thematisch | I Numeri — Kardinalzahlen · Ordinalzahlen |
| [orientierung.pdf](orientierung.pdf) | Thematisch | Orientarsi — Strade · Indicazioni · Luoghi |
| [preposizioni.pdf](preposizioni.pdf) | Thematisch | Preposizioni Articolate — Präposition · Bestimmter Artikel |
| [pronuncia.pdf](pronuncia.pdf) | Thematisch | Pronuncia — Ausspracheregeln — Konsonanten · Vokale · Betonung |

## Inhalt — cheatsheet.pdf

- **Verbkonjugationen** — Presente für regelmäßige und unregelmäßige Verben
- **Vocabolario** — thematisch gruppierter Wortschatz (Kommunikation, Bewegung, Alltag, Gefühle u.v.m.) sowie Reflexivverben
- **Parole utili** — Adverbien, Konjunktionen, Fragewörter und Ortsangaben
- **Präpositionen** — artikulierte Präpositionen (Kontraktion) und deren Verwendung
- **Tempi verbali** — Gebrauchsregeln zum Presente, Gerundio, Imperativo

## Kompilieren

Erfordert [Typst](https://typst.app) 0.14+:

```bash
make
```

## Development

Dieses Repository verwendet [swamp](https://github.com/systeminit/swamp) zur Automatisierung der PDF-Kompilierung und README-Verwaltung.

### Setup nach Checkout

1. **Swamp installieren** (falls noch nicht vorhanden):
   ```bash
   curl -fsSL https://install.swamp.dev | bash
   ```

2. **Repository initialisieren**:
   ```bash
   swamp init
   ```

   Dies erstellt die `.swamp/` Verzeichnisstruktur und lädt die konfigurierten Extension Models.

3. **Models überprüfen**:
   ```bash
   swamp model search
   ```

   Sollte 15+ Cheatsheet-Models und das `compile-cheatsheets` Model anzeigen.

### Neues Cheatsheet hinzufügen

#### Empfohlener Workflow mit Review-Zyklus

1. **Typst-Datei erstellen** (z.B. `nuovo.typ`):
   ```typst
   #import "shared.typ": *
   #show: cheatsheet

   #page-title[Titolo][SOTTOTITOLO · MIT · MIDDOT]

   #columns(2, gutter: 0.9cm)[
     // Inhalt hier
   ]
   ```

2. **Review-Workflow starten**:
   ```bash
   swamp workflow run cheatsheet-review --set name=nuovo --set action=create
   ```

   Dies kompiliert das PDF, erstellt das Swamp-Model und aktualisiert die README-Tabelle.

3. **Review durchführen**:
   - PDF prüfen: `open nuovo.pdf`
   - README-Änderungen prüfen: `git diff README.md`

4. **Entscheidung treffen**:

   **✅ Genehmigen und committen**:
   ```bash
   swamp workflow run cheatsheet-review \
     --set name=nuovo \
     --set action=approve \
     --set commitMessage="Add nuovo cheatsheet"
   ```

   **🔄 Änderungen anfordern**:
   - `nuovo.typ` manuell bearbeiten
   - Workflow erneut ausführen:
     ```bash
     swamp workflow run cheatsheet-review --set name=nuovo --set action=create
     ```

   **❌ Verwerfen**:
   ```bash
   git restore nuovo.typ nuovo.pdf README.md
   swamp model delete nuovo
   ```

#### Manueller Workflow (ohne Review)

Für schnelle Updates ohne Git-Commit:

1. **Typst-Datei erstellen/bearbeiten**

2. **Cheatsheet-Model erstellen**:
   ```bash
   swamp model create @justjoheinz/cheatsheet \
     --name nuovo \
     --set repoDir=.
   ```

3. **README aktualisieren**:
   ```bash
   swamp model method run cheatsheet update-readme
   ```

4. **PDF kompilieren**:
   ```bash
   make
   # oder: swamp workflow run compile-on-schedule
   ```

### Architektur

- **Extension Model**: `@justjoheinz/cheatsheet` (in `extensions/models/cheatsheet/`)
  - Wraps Typst compilation
  - Generiert README-Tabelle aus Model-Metadaten
- **Models**: Ein Model pro Cheatsheet in `models/@justjoheinz/cheatsheet/`
- **Workflows**:
  - `cheatsheet-review`: Iterativer Review-Zyklus mit Git-Commit
  - `compile-on-schedule`: Batch-Kompilierung aller Cheatsheets
