#import "shared.typ": *
#show: cheatsheet

// ── page 1 ───────────────────────────────────────────────────────────────────

#page-title[Verbi Italiani — Coniugazione][PRESENTE]

// ── two-column body ──────────────────────────────────────────────────────────

#columns(2, gutter: 0.9cm)[

// ── parlare ──────────────────────────────────────────────────────────────────
#verb-section(
  "parlare", "sprechen", "verbi in -are",
  (
    ("io",      "parlo"),
    ("tu",      "parli"),
    ("lui/lei", "parla"),
    ("noi",     "parliamo"),
    ("voi",     "parlate"),
    ("loro",    "parlano"),
  ),
  (
    ("tense": "Presente", "text": "Ogni giorno parlo con mia madre."),
  ),
)

// ── ripetere ──────────────────────────────────────────────────────────────────
#verb-section(
  "ripetere", "wiederholen", "verbi in -ere",
  (
    ("io",      "ripeto"),
    ("tu",      "ripeti"),
    ("lui/lei", "ripete"),
    ("noi",     "ripetiamo"),
    ("voi",     "ripetete"),
    ("loro",    "ripetono"),
  ),
  (
    ("tense": "Presente", "text": "Ripeto la domanda per chi non ha sentito."),
  ),
)

// ── sentire ──────────────────────────────────────────────────────────────────
#verb-section(
  "sentire", "hören/fühlen", "verbi in -ire (tipo I)",
  (
    ("io",      "sento"),
    ("tu",      "senti"),
    ("lui/lei", "sente"),
    ("noi",     "sentiamo"),
    ("voi",     "sentite"),
    ("loro",    "sentono"),
  ),
  (
    ("tense": "Presente", "text": "Sento la musica dalla finestra."),
  ),
)

// ── finire ───────────────────────────────────────────────────────────────────
#verb-section(
  "finire", "beenden", "verbi in -ire (tipo II, -isc-)",
  (
    ("io",      [finisco #text(fill: ink-sec, size: 7pt)[†]]),
    ("tu",      [finisci #text(fill: ink-sec, size: 7pt)[†]]),
    ("lui/lei", [finisce #text(fill: ink-sec, size: 7pt)[†]]),
    ("noi",     "finiamo"),
    ("voi",     "finite"),
    ("loro",    [finiscono #text(fill: ink-sec, size: 7pt)[†]]),
  ),
  (
    ("tense": "Presente", "text": "Finisco il lavoro alle cinque."),
  ),
)

#ann[† infisso -isc- in io/tu/lui/loro al Presente; assente in noi/voi. Stessa struttura: capire, preferire, costruire.]

#v(5pt)

// ── essere ───────────────────────────────────────────────────────────────────
#verb-section(
  "essere", "sein", "ausiliare",
  (
    ("io",      "sono"),
    ("tu",      "sei"),
    ("lui/lei", [è]),
    ("noi",     "siamo"),
    ("voi",     "siete"),
    ("loro",    "sono"),
  ),
  (
    ("tense": "Presente", "text": "Sono stanco dopo il lavoro."),
  ),
)

#ann[Participio: stato · stata · stati · state. Con essere il participio concorda con il soggetto.]

#v(5pt)

// ── avere ────────────────────────────────────────────────────────────────────
#verb-section(
  "avere", "haben", "ausiliare",
  (
    ("io",      "ho"),
    ("tu",      "hai"),
    ("lui/lei", "ha"),
    ("noi",     "abbiamo"),
    ("voi",     "avete"),
    ("loro",    "hanno"),
  ),
  (
    ("tense": "Presente", "text": "Ho molti libri a casa."),
  ),
)

// ── fare ─────────────────────────────────────────────────────────────────────
#verb-section(
  "fare", "machen/tun", "irregolare",
  (
    ("io",      "faccio"),
    ("tu",      "fai"),
    ("lui/lei", "fa"),
    ("noi",     "facciamo"),
    ("voi",     "fate"),
    ("loro",    "fanno"),
  ),
  (
    ("tense": "Presente", "text": "Faccio colazione alle sette."),
  ),
)

// ── volere ───────────────────────────────────────────────────────────────────
#verb-section(
  "volere", "wollen", "modale",
  (
    ("io",      "voglio"),
    ("tu",      "vuoi"),
    ("lui/lei", "vuole"),
    ("noi",     "vogliamo"),
    ("voi",     "volete"),
    ("loro",    "vogliono"),
  ),
  (
    ("tense": "Presente", "text": "Voglio un caffè, per favore."),
  ),
)

// ── potere ───────────────────────────────────────────────────────────────────
#verb-section(
  "potere", "können/dürfen", "modale",
  (
    ("io",      "posso"),
    ("tu",      "puoi"),
    ("lui/lei", [può]),
    ("noi",     "possiamo"),
    ("voi",     "potete"),
    ("loro",    "possono"),
  ),
  (
    ("tense": "Presente", "text": "Posso aprire la finestra?"),
  ),
)

// ── dovere ───────────────────────────────────────────────────────────────────
#verb-section(
  "dovere", "müssen/sollen", "modale",
  (
    ("io",      "devo"),
    ("tu",      "devi"),
    ("lui/lei", "deve"),
    ("noi",     "dobbiamo"),
    ("voi",     "dovete"),
    ("loro",    "devono"),
  ),
  (
    ("tense": "Presente", "text": "Devo studiare per l'esame."),
  ),
)

// ── dire ─────────────────────────────────────────────────────────────────────
#verb-section(
  "dire", "sagen", "irregolare",
  (
    ("io",      "dico"),
    ("tu",      "dici"),
    ("lui/lei", "dice"),
    ("noi",     "diciamo"),
    ("voi",     "dite"),
    ("loro",    "dicono"),
  ),
  (
    ("tense": "Presente", "text": "Dico sempre la verità."),
  ),
)

// ── andare · venire · uscire · stare ─────────────────────────────────────────
#verb-compare(
  "irregolare (essere)",
  (
    ("andare", "gehen"),
    ("venire", "kommen"),
    ("uscire", "ausgehen"),
    ("stare",  "sich befinden"),
  ),
  (
    ("io",      "vado",    "vengo",    "esco",    "sto"),
    ("tu",      "vai",     "vieni",    "esci",    "stai"),
    ("lui/lei", [va],      "viene",    "esce",    "sta"),
    ("noi",     "andiamo", "veniamo",  "usciamo", "stiamo"),
    ("voi",     "andate",  "venite",   "uscite",  "state"),
    ("loro",    "vanno",   "vengono",  "escono",  "stanno"),
  ),
)

// ── dare · sapere · bere · vedere ────────────────────────────────────────────
#verb-compare(
  "irregolare (avere)",
  (
    ("dare",   "geben"),
    ("sapere", "wissen"),
    ("bere",   "trinken"),
    ("vedere", "sehen"),
  ),
  (
    ("io",      [do],      "so",       "bevo",    "vedo"),
    ("tu",      "dai",     "sai",      "bevi",    "vedi"),
    ("lui/lei", [dà],      "sa",       "beve",    "vede"),
    ("noi",     "diamo",   "sappiamo", "beviamo", "vediamo"),
    ("voi",     "date",    "sapete",   "bevete",  "vedete"),
    ("loro",    "danno",   "sanno",    "bevono",  "vedono"),
  ),
)

] // end columns
