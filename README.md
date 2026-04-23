# Italienisch-Cheatsheet

Druckbare A4-PDFs für deutschsprachige Lernende der italienischen Sprache.

| PDF | Topic | Inhalt |
|---|---|---|
| [cheatsheet.pdf](cheatsheet.pdf) | Grammatik & Verben | Vocabolario Comune — Verbi Frequenti |
| [presente.pdf](presente.pdf) | Grammatik & Verben | Verbi Italiani — Coniugazione — Presente |
| [condizionale.pdf](condizionale.pdf) | Grammatik | Condizionale Semplice — Formazione · Desinenze · Eccezioni |
| [futuro.pdf](futuro.pdf) | Grammatik | Futuro Semplice — Formazione · Verbi Radicali · Uso |
| [imperativo.pdf](imperativo.pdf) | Grammatik | Imperativo — Tu & Voi |
| [imperfetto.pdf](imperfetto.pdf) | Grammatik | Imperfetto — Formazione · Desinenze · Irregolari · Uso |
| [passato.pdf](passato.pdf) | Grammatik | Passato Prossimo — Formazione · Participio · Uso |
| [preposizioni.pdf](preposizioni.pdf) | Grammatik | Preposizioni Articolate — Preposizione · Articolo Determinativo |
| [parole.pdf](parole.pdf) | Vokabular | Parole Utili — Avverbi · Congiunzioni · Indefiniti · Luogo |
| [arte.pdf](arte.pdf) | Thematisch | Arte — Museo · Opere · Stili |
| [casa.pdf](casa.pdf) | Thematisch | La Casa — Edifici · Case · Mobili · Arredamento |
| [cucina.pdf](cucina.pdf) | Thematisch | In Cucina — Cucina · Cucinare · Preparazione |
| [letteratura.pdf](letteratura.pdf) | Thematisch | Il Libro — Libri · Giornali · Letteratura |
| [numeri.pdf](numeri.pdf) | Thematisch | I Numeri — Numeri Cardinali · Numeri Ordinali |
| [orientierung.pdf](orientierung.pdf) | Thematisch | Orientarsi — Strade · Indicazioni · Luoghi |
| [pronuncia.pdf](pronuncia.pdf) | Thematisch | Pronuncia — Regole Di Pronuncia — Consonanti · Vocali · Accento |

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

Das Repository enthält ein `review-cheatsheet.sh` Script für den iterativen Review-Prozess.

1. **Typst-Datei erstellen** (z.B. `nuovo.typ`):
   ```typst
   #import "shared.typ": *
   #show: cheatsheet

   #page-title[Titolo][SOTTOTITOLO · MIT · MIDDOT]

   #columns(2, gutter: 0.9cm)[
     // Inhalt hier
   ]
   ```

2. **Review-Script ausführen**:
   ```bash
   ./review-cheatsheet.sh nuovo
   ```

   Dies:
   - Kompiliert `nuovo.typ` zu `nuovo.pdf` (via Typst)
   - Erstellt das Swamp-Model
   - Aktualisiert die README-Tabelle
   - Zeigt Review-Instruktionen an

3. **Review durchführen**:
   - PDF prüfen: `open nuovo.pdf`
   - README-Änderungen prüfen: `git diff README.md`

4. **Entscheidung treffen**:

   **✅ Genehmigen und committen (auto-generierte Message)**:
   ```bash
   ./review-cheatsheet.sh nuovo --approve
   ```
   → Commit-Message: "Update cheatsheet nuovo"

   **✅ Genehmigen und committen (custom Message)**:
   ```bash
   ./review-cheatsheet.sh nuovo "Add nuovo cheatsheet"
   ```

   **🔄 Änderungen anfordern**:
   - `nuovo.typ` manuell bearbeiten
   - Script erneut ausführen:
     ```bash
     ./review-cheatsheet.sh nuovo
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
- **Scripts**:
  - `review-cheatsheet.sh`: Iterativer Review-Zyklus mit Git-Commit
- **Workflows**:
  - `compile-on-schedule`: Batch-Kompilierung aller Cheatsheets
