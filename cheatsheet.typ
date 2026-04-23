#import "shared.typ": *
#show: cheatsheet

// ── vocabulary page ───────────────────────────────────────────────────────────

#page-title[Vocabolario Comune][VERBI FREQUENTI]

#columns(2, gutter: 0.9cm)[

#vocab-group("Kommunikation", (
  ("ascoltare",  "zuhören"),
  ("leggere",    "lesen"),
  ("guardare",   "schauen / ansehen"),
  ("capire",     "verstehen"),
  ("rispondere", "antworten"),
  ("chiedere",   "fragen / bitten"),
  ("chiamare",   "anrufen"),
  ("incontrare", "treffen"),
))

#vocab-group("Bewegung", (
  ("entrare",    "eintreten"),
  ("tornare",    "zurückkehren"),
  ("arrivare",   "ankommen"),
  ("partire",    "abreisen / abfahren"),
  ("camminare",  "gehen / laufen",  "auch funktional: la macchina cammina bene (das Auto läuft gut)"),
  ("passeggiare","spazieren gehen"),
  ("correre",    "rennen / laufen"),
  ("portare",    "tragen / bringen"),
  ("prendere",   "nehmen / mitnehmen"),
))

#vocab-group("Alltag", (
  ("mangiare",   "essen"),
  ("dormire",    "schlafen"),
  ("lavorare",   "arbeiten"),
  ("studiare",   "studieren / lernen"),
  ("comprare",   "kaufen"),
  ("aprire",     "öffnen"),
  ("chiudere",   "schließen"),
  ("cucinare",   "kochen"),
))

#vocab-group("Denken & Fühlen", (
  ("pensare",    "denken / nachdenken"),
  ("credere",    "glauben / meinen"),
  ("ricordare",  "erinnern"),
  ("dimenticare","vergessen"),
  ("sperare",    "hoffen"),
  ("preferire",  "bevorzugen"),
  ("amare",      "lieben"),
  ("piacere",    "gefallen"),
))

#vocab-group("Handlungen", (
  ("trovare",    "finden"),
  ("perdere",    "verlieren"),
  ("mettere",    "legen / stellen"),
  ("lasciare",   "lassen / verlassen",  "lasciarsi (riflessivo) = sich trennen: ci siamo lasciati"),
  ("usare",      "benutzen"),
  ("provare",    "versuchen / ausprobieren"),
  ("aiutare",    "helfen"),
  ("aspettare",  "warten"),
))

#vocab-group("Küche & Zubereitung", (
  ("preparare",  "vorbereiten / zubereiten"),
  ("tagliare",   "schneiden"),
  ("aggiungere", "hinzufügen / dazugeben"),
  ("versare",    "eingießen / schütten"),
  ("mescolare",  "mischen / rühren"),
))

#vocab-group("Kennen & Lehren", (
  ("vedere",    "sehen"),
  ("conoscere", "kennen"),
  ("imparare",  "lernen"),
  ("insegnare", "lehren / unterrichten"),
  ("spiegare",  "erklären"),
  ("mostrare",  "zeigen"),
  ("ricevere",  "erhalten / bekommen"),
  ("ripetere",  "wiederholen"),
  ("seguire",   "folgen / verfolgen"),
))

#vocab-group("Alltag & Freizeit", (
  ("vivere",    "leben"),
  ("abitare",   "wohnen"),
  ("pagare",    "bezahlen"),
  ("cambiare",  "ändern / wechseln"),
  ("passare",   "vorbeigehen / verbringen"),
  ("cantare",   "singen"),
  ("ballare",   "tanzen"),
  ("viaggiare", "reisen"),
  ("suonare",   "spielen (Instrument)"),
))

#vocab-group("Zustand & Veränderung", (
  ("diventare",  "werden"),
  ("sembrare",   "wirken / scheinen"),
  ("restare",    "bleiben"),
  ("cominciare", "anfangen / beginnen"),
  ("continuare", "weitermachen"),
  ("smettere",   "aufhören"),
  ("succedere",  "passieren / geschehen"),
  ("riuscire",   "schaffen / gelingen"),
  ("vendere",    "verkaufen"),
  ("giocare",    "spielen"),
  ("convivere",  "zusammenleben"),
))

#vocab-group("Verbi Riflessivi", (
  ("chiamarsi",     "heißen",               "come ti chiami? — wie heißt du?"),
  ("svegliarsi",    "aufwachen"),
  ("alzarsi",       "aufstehen"),
  ("lavarsi",       "sich waschen"),
  ("vestirsi",      "sich anziehen"),
  ("sedersi",       "sich setzen / hinsetzen"),
  ("addormentarsi", "einschlafen"),
  ("sentirsi",      "sich fühlen",           "come ti senti? — wie fühlst du dich?"),
  ("trovarsi",      "sich befinden"),
  ("innamorarsi",   "sich verlieben",        "innamorarsi di qualcuno"),
  ("divertirsi",    "sich amüsieren / Spaß haben"),
  ("arrabbiarsi",   "sich ärgern"),
  ("annoiarsi",     "sich langweilen"),
  ("interessarsi",  "sich interessieren",    "interessarsi di qualcosa"),
  ("preoccuparsi",  "sich sorgen",           "preoccuparsi per qualcuno"),
  ("sbagliarsi",    "sich irren"),
  ("laurearsi",     "einen Hochschulabschluss machen", "mi sono laureato/a in medicina · la laurea = der Abschluss"),
))

#ann[Verbi riflessivi: Hilfsverb immer essere — Partizip kongruiert mit dem Subjekt: mi sono vestito (m.) / vestita (f.), ti sei vestito/a, si è vestito/a… Pronomen: mi · ti · si · ci · vi · si (vor dem Verb).]

#v(4pt)

] // end vocab columns

// ── i tempi verbali page ──────────────────────────────────────────────────────
#pagebreak()

#page-title[I Tempi Verbali][GEBRAUCHSREGELN — PRESENTE]
#v(1pt)

#tense-block("Presente", "Gegenwart / Gewohnheit / nahe Zukunft", (
  ("Gegenwärtiger Zustand oder Handlung",
   "Sono stanco. · Lavoro in ufficio."),
  ("Gewohnheit oder Wiederholung",
   "Ogni mattina bevo un caffè."),
  ("Allgemeine Wahrheit",
   "Il sole sorge a est."),
  ("Nahe Zukunft mit Zeitangabe",
   "Domani vado a Roma."),
  ("Seit-Konstruktion: da + Presente",
   "Studio l'italiano da due anni. (Ich lerne seit zwei Jahren Italienisch — und tue es noch.)"),
))

// ── gerundio & progressivo ────────────────────────────────────────────────────
#v(4pt)
#line(length: 100%, stroke: 0.4pt + border)
#v(5pt)
#text(size: 6.5pt, weight: 500, tracking: 0.1em, fill: accent)[GERUNDIO & PROGRESSIVO]
#v(5pt)

#grid(columns: (1fr, 1fr), gutter: 0.9cm,
  block(breakable: false)[
    #text(size: 7pt, weight: 500)[Bildung: Infinitivstamm + Endung]
    #v(3pt)
    #set text(size: 7.5pt)
    #table(
      columns: (1.5cm, 1.2cm, 1fr),
      align: left,
      inset: (x: 4pt, y: 3pt),
      stroke: (_, y) => (
        top: none, left: none, right: none,
        bottom: if y == 0 { 0.7pt + ink } else { 0.3pt + border },
      ),
      fill: (_, y) => if y == 0 { surface } else { white },
      table.header(
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[TYP],
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[ENDUNG],
        text(size: 6pt, weight: 500, tracking: 0.08em, fill: ink-sec)[BEISPIEL],
      ),
      [-are], text(weight: 600, fill: accent)[-ando], [parlare → parlando],
      [-ere], text(weight: 600, fill: accent)[-endo], [ripetere → ripetendo],
      [-ire], text(weight: 600, fill: accent)[-endo], [sentire → sentendo],
    )
    #v(4pt)
    #text(size: 7pt, fill: ink-sec)[Unregelmäßig: fare → #text(fill: ink)[facendo] · dire → #text(fill: ink)[dicendo] · bere → #text(fill: ink)[bevendo]]
  ],
  block(breakable: false)[
    #text(size: 7pt, weight: 500)[stare + gerundio — laufende Handlung]
    #v(4pt)
    #block(inset: (bottom: 3pt))[
      #text(size: 7pt, weight: 500)[Gegenwart (Progressivo presente)]
      #linebreak()
      #text(size: 7pt, style: "italic", fill: ink-sec)[Sto mangiando. (Ich esse gerade.)]
    ]
    #block(inset: (bottom: 3pt))[
      #text(size: 7pt, weight: 500)[Vergangenheit (Progressivo passato)]
      #linebreak()
      #text(size: 7pt, style: "italic", fill: ink-sec)[Stavo leggendo quando è arrivato Marco.]
      #linebreak()
      #text(size: 7pt, fill: ink-sec)[stavo · stavi · stava · stavamo · stavate · stavano + gerundio]
    ]
    #block[
      #text(size: 7pt, weight: 500)[sto mangiando vs. mangio]
      #linebreak()
      #text(size: 7pt, fill: ink-sec)[Progressivo = gerade jetzt; Presente = generell / gewohnheitsmäßig.]
    ]
  ],
)


