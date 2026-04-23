# Italienisch-Cheatsheet

Druckbare A4-PDFs für deutschsprachige Lernende der italienischen Sprache.

| PDF | Inhalt |
|---|---|
| [cheatsheet.pdf](cheatsheet.pdf) | Vocabolario Comune — Verbi frequenti |
| [presente.pdf](presente.pdf) | Verbi Italiani — Coniugazione — Presente |
| [condizionale.pdf](condizionale.pdf) | Condizionale Semplice — Bildung · Endungen · Ausnahmen |
| [futuro.pdf](futuro.pdf) | Futuro Semplice — Bildung · Stammverben · Verwendung |
| [imperativo.pdf](imperativo.pdf) | Imperativo — Befehlsform — tu & voi |
| [imperfetto.pdf](imperfetto.pdf) | Imperfetto — Bildung · Endungen · Unregelmässige · Verwendung |
| [passato.pdf](passato.pdf) | Passato Prossimo — Bildung · Partizip · Verwendung |
| [parole.pdf](parole.pdf) | Parole Utili — Avverbi · Congiunzioni · Indefiniti · Luogo |
| [letteratura.pdf](letteratura.pdf) | Il Libro — Bücher · Zeitungen · Literatur |
| [arte.pdf](arte.pdf) | Arte — Museo · Opere · Stili |
| [cucina.pdf](cucina.pdf) | In Cucina — Küche · Kochen · Zubereitung |
| [numeri.pdf](numeri.pdf) | I Numeri — Kardinalzahlen · Ordinalzahlen |
| [orientierung.pdf](orientierung.pdf) | Orientarsi — Strade · Indicazioni · Luoghi |
| [preposizioni.pdf](preposizioni.pdf) | Preposizioni Articolate — Präposition + bestimmter artikel |
| [pronuncia.pdf](pronuncia.pdf) | Pronuncia — Ausspracheregeln — konsonanten · Vokale · Betonung |

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

1. **Typst-Datei erstellen** (z.B. `nuovo.typ`):
   ```typst
   #import "shared.typ": *
   #show: cheatsheet

   #page-title[Titolo][SOTTOTITOLO]

   #columns(2, gutter: 0.9cm)[
     // Inhalt hier
   ]
   ```

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

   Dies scannt automatisch alle Cheatsheet-Models und generiert die Tabelle in dieser README.

4. **PDF kompilieren**:
   ```bash
   swamp workflow run compile-on-schedule
   ```

   Oder direkt via Make:
   ```bash
   make
   ```

### Architektur

- **Extension Model**: `@justjoheinz/cheatsheet` (in `extensions/models/cheatsheet/`)
  - Wraps Typst compilation
  - Generiert README-Tabelle aus Model-Metadaten
- **Models**: Ein Model pro Cheatsheet in `models/@justjoheinz/cheatsheet/`
- **Workflow**: `compile-on-schedule` orchestriert Kompilierung + README-Update
