import { z } from "npm:zod@4";
import * as fs from "node:fs/promises";
import * as path from "node:path";

// ── Schemas ───────────────────────────────────────────────────────────────────

const EntryResultSchema = z.object({
  group: z.string().describe("Vocab group label from #vocab-group"),
  italian: z.string().describe("Italian word as written in the cheatsheet"),
  german: z.string().describe("German translation as written in the cheatsheet"),
  status: z
    .enum(["ok", "mismatch", "not_found", "error"])
    .describe("Verification result"),
  leoTranslations: z
    .array(z.string())
    .describe("All German translations returned by Leo for this word"),
  detail: z.string().optional().describe("Additional context for mismatch or error"),
});

const VerifyResultSchema = z.object({
  checkedAt: z.iso.datetime(),
  files: z.array(z.string()).describe("Typ files that were scanned"),
  totalChecked: z.number().int(),
  ok: z.number().int(),
  mismatches: z.number().int(),
  notFound: z.number().int(),
  errors: z.number().int(),
  entries: z.array(EntryResultSchema),
});

// ── Parsing ───────────────────────────────────────────────────────────────────

type VocabEntry = { file: string; group: string; italian: string; german: string };

function normalizeQueryWord(word: string): string {
  return word
    // Strip space-separated articles: "il romanzo" → "romanzo"
    .replace(/^(il|la|lo|i|gli|le|un|una|uno)\s+/i, "")
    // Strip apostrophe articles (no trailing space): "l'ebook" → "ebook"
    .replace(/^(l'|un')/i, "")
    // Strip gender alternation suffixes: "piccolo/a" → "piccolo", "alcuni/e" → "alcuni"
    .replace(/\/[aeiou]$/i, "")
    .trim();
}

function parseVocabGroups(source: string, file: string): VocabEntry[] {
  const entries: VocabEntry[] = [];
  let pos = 0;

  while (true) {
    const groupStart = source.indexOf("#vocab-group(", pos);
    if (groupStart === -1) break;

    const labelMatch = source.slice(groupStart).match(/#vocab-group\("([^"]+)",\s*\(/);
    if (!labelMatch) {
      pos = groupStart + 1;
      continue;
    }

    const group = labelMatch[1];
    // entriesStart points to the char after the opening '(' of the array
    const entriesStart = groupStart + labelMatch[0].length;

    // Scan for the matching closing ')' of the entries array
    let depth = 1;
    let i = entriesStart;
    while (i < source.length && depth > 0) {
      if (source[i] === "(") depth++;
      else if (source[i] === ")") depth--;
      i++;
    }
    const content = source.slice(entriesStart, i - 1);

    // Extract 2- or 3-element string tuples: ("italian", "german") or ("italian", "german", "note")
    const entryRe = /\("([^"]+)",\s*"([^"]+)"(?:,\s*"[^"]*")?\)/g;
    let m;
    while ((m = entryRe.exec(content)) !== null) {
      entries.push({ file, group, italian: m[1], german: m[2] });
    }

    pos = i;
  }

  return entries;
}

// ── Leo lookup ────────────────────────────────────────────────────────────────

// Leo embeds an XML blob in the page HTML:
//   <xml leorendertarget="1" ...>...<section sctName="verb">...</xml>
// Each <entry> has two <side> children: lang="it" and lang="de".
// We extract all DE <word> values from all sections.

function extractLeoXml(html: string): string | null {
  const m = html.match(/<xml\s[^>]*leorendertarget="1"[\s\S]*?<\/xml>/);
  return m ? m[0] : null;
}

// Minimal XML parser — only used for Leo's well-structured output.
// Returns an array of { it: string[], de: string[] } per entry.
function parseLeoEntries(xml: string): Array<{ it: string[]; de: string[] }> {
  const entries: Array<{ it: string[]; de: string[] }> = [];

  // Split on <entry ...> boundaries
  const entryRe = /<entry\b[^>]*>([\s\S]*?)<\/entry>/g;
  let em;
  while ((em = entryRe.exec(xml)) !== null) {
    const entryXml = em[1];

    const getSideWords = (lang: string): string[] => {
      const sideRe = new RegExp(
        `<side\\b[^>]*\\blang="${lang}"[^>]*>([\\s\\S]*?)</side>`,
        "g"
      );
      const words: string[] = [];
      let sm;
      while ((sm = sideRe.exec(entryXml)) !== null) {
        const wordRe = /<word>([\s\S]*?)<\/word>/g;
        let wm;
        while ((wm = wordRe.exec(sm[1])) !== null) {
          words.push(wm[1].trim());
        }
      }
      return words;
    };

    const it = getSideWords("it");
    const de = getSideWords("de");
    if (it.length && de.length) {
      entries.push({ it, de });
    }
  }

  return entries;
}

async function queryLeo(word: string): Promise<string[]> {
  const encoded = encodeURIComponent(word);
  const url = `https://dict.leo.org/italienisch-deutsch/${encoded}`;

  const res = await fetch(url, {
    headers: {
      "User-Agent":
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36",
      Accept: "text/html",
    },
  });

  if (!res.ok) {
    throw new Error(`Leo HTTP ${res.status} for "${word}"`);
  }

  const html = await res.text();
  const xml = extractLeoXml(html);
  if (!xml) {
    throw new Error(`Leo returned no XML blob for "${word}"`);
  }

  const allEntries = parseLeoEntries(xml);
  return allEntries.flatMap((e) => e.de);
}

// ── Comparison ────────────────────────────────────────────────────────────────

// Normalize a German word for loose matching:
// lowercase, strip common articles and punctuation
const DE_ARTICLES = /^(der|die|das|den|dem|des|ein|eine|einen|einem|einer|eines)\s+/i;

function normalizeDE(s: string): string {
  return s
    .toLowerCase()
    .replace(DE_ARTICLES, "")
    .replace(/[().,!?;:]/g, "")
    .trim();
}

// Split a cheatsheet German value into individual terms.
// e.g. "lassen / verlassen" → ["lassen", "verlassen"]
//      "können/dürfen"       → ["können", "dürfen"]
//      "stehen · sich befinden" → ["stehen", "sich befinden"]
function splitCheatsheetDE(german: string): string[] {
  return german
    .split(/\s*[/·]\s*/)
    .map((s) => s.trim())
    .filter(Boolean);
}

function translationMatches(cheatsheetDE: string, leoDE: string[]): boolean {
  const terms = splitCheatsheetDE(cheatsheetDE).map(normalizeDE);
  const leoNorm = leoDE.map(normalizeDE);

  return terms.some((term) =>
    leoNorm.some(
      (leo) =>
        leo === term ||
        leo.includes(term) ||
        term.includes(leo)
    )
  );
}

// ── Helpers ───────────────────────────────────────────────────────────────────

type EntryResult = z.infer<typeof EntryResultSchema>;

/** Cache key for deduplicating across runs: italian + german pair. */
function cacheKey(italian: string, german: string): string {
  return `${italian}|||${german}`;
}

/** Query Leo for a single entry and return the result. */
async function checkEntry(
  entry: VocabEntry
): Promise<{ status: EntryResult["status"]; leoTranslations: string[]; detail?: string }> {
  const queryWord = normalizeQueryWord(entry.italian);
  let leoTranslations: string[] = [];
  let status: EntryResult["status"];
  let detail: string | undefined;

  try {
    leoTranslations = await queryLeo(queryWord);
    if (leoTranslations.length === 0) {
      status = "not_found";
      detail = `No translations found on Leo for "${queryWord}"`;
    } else if (translationMatches(entry.german, leoTranslations)) {
      status = "ok";
    } else {
      status = "mismatch";
      detail =
        `Cheatsheet: "${entry.german}" — ` +
        `Leo top results: ${leoTranslations.slice(0, 5).join(", ")}`;
    }
  } catch (err) {
    status = "error";
    detail = err instanceof Error ? err.message : String(err);
  }

  return { status, leoTranslations: leoTranslations.slice(0, 10), detail };
}

// ── Model ─────────────────────────────────────────────────────────────────────

export const model = {
  type: "@justjoheinz/leo-vocab-verifier",
  version: "2026.04.24.2",

  upgrades: [
    {
      fromVersion: "2026.04.24.1",
      toVersion: "2026.04.24.2",
      description: "verify now skips cached ok/mismatch entries; recheck covers not_found too",
      upgradeAttributes: (old: unknown) => old,
    },
  ],

  resources: {
    result: {
      description: "Vocabulary verification results against Leo dictionary",
      schema: VerifyResultSchema,
      lifetime: "infinite",
      garbageCollection: 10,
    },
  },

  methods: {
    verify: {
      description:
        "Parse #vocab-group entries from .typ cheatsheet files and verify each " +
        "Italian → German pair against dict.leo.org/italienisch-deutsch. " +
        "Entries with a cached 'ok' or 'mismatch' result are skipped; " +
        "new entries and those with 'error' or 'not_found' status are re-queried.",
      arguments: z.object({
        files: z
          .array(z.string())
          .default(["cheatsheet.typ", "letteratura.typ"])
          .describe(
            "Typ file names relative to the repository root to scan. " +
              "Defaults to cheatsheet.typ and letteratura.typ."
          ),
        delayMs: z
          .number()
          .int()
          .min(0)
          .default(600)
          .describe(
            "Milliseconds to wait between Leo requests to avoid rate-limiting."
          ),
      }),
      execute: async (args, context) => {
        const repoDir = context.repoDir;
        const { files, delayMs } = args;

        // 1. Parse all vocab entries from the requested files
        const allEntries: VocabEntry[] = [];
        for (const file of files) {
          const fullPath = path.join(repoDir, file);
          let source: string;
          try {
            source = await fs.readFile(fullPath, "utf-8");
          } catch {
            throw new Error(`File not found: ${fullPath}`);
          }
          const parsed = parseVocabGroups(source, file);
          context.logger.info(`${file}: found ${parsed.length} vocab entries`);
          allEntries.push(...parsed);
        }

        if (allEntries.length === 0) {
          throw new Error(
            "No #vocab-group entries found in the specified files."
          );
        }

        // 2. Load cached results from previous run (if any)
        const cachedMap = new Map<string, EntryResult>();
        try {
          const prev = await context.readResource!("main") as z.infer<typeof VerifyResultSchema>;
          if (prev?.entries) {
            for (const e of prev.entries) {
              cachedMap.set(cacheKey(e.italian, e.german), e);
            }
            context.logger.info(
              `Loaded ${cachedMap.size} cached results from previous run`
            );
          }
        } catch {
          // No previous result — first run, proceed without cache
        }

        // 3. Partition entries: skip ok/mismatch, query the rest
        const toQuery: VocabEntry[] = [];
        for (const entry of allEntries) {
          const hit = cachedMap.get(cacheKey(entry.italian, entry.german));
          if (hit && (hit.status === "ok" || hit.status === "mismatch")) {
            // carry over — no Leo request needed
          } else {
            toQuery.push(entry);
          }
        }

        const skipped = allEntries.length - toQuery.length;
        if (skipped > 0) {
          context.logger.info(
            `Skipping ${skipped} already-verified entries (ok/mismatch)`
          );
        }

        // 4. Query Leo for entries that need checking
        const freshResults = new Map<string, EntryResult>();
        let ok = 0, mismatches = 0, notFound = 0, errors = 0;

        for (let qi = 0; qi < toQuery.length; qi++) {
          const entry = toQuery[qi];
          const queryWord = normalizeQueryWord(entry.italian);

          context.logger.info(
            `[${qi + 1}/${toQuery.length}] ${queryWord} (${entry.group})`
          );

          const { status, leoTranslations, detail } = await checkEntry(entry);

          if (status === "ok") ok++;
          else if (status === "mismatch") mismatches++;
          else if (status === "not_found") notFound++;
          else errors++;

          freshResults.set(cacheKey(entry.italian, entry.german), {
            group: entry.group,
            italian: entry.italian,
            german: entry.german,
            status,
            leoTranslations,
            ...(detail !== undefined ? { detail } : {}),
          });

          if (qi < toQuery.length - 1 && delayMs > 0) {
            await new Promise((r) => setTimeout(r, delayMs));
          }
        }

        // 5. Rebuild full result list in original order, merging cache + fresh
        const finalEntries: EntryResult[] = allEntries.map((entry) => {
          const key = cacheKey(entry.italian, entry.german);
          const fresh = freshResults.get(key);
          if (fresh) return fresh;
          const cached = cachedMap.get(key)!;
          if (cached.status === "ok") ok++;
          else if (cached.status === "mismatch") mismatches++;
          return cached;
        });

        context.logger.info(
          `Done — ok: ${ok}, mismatches: ${mismatches}, not_found: ${notFound}, errors: ${errors}` +
          (skipped > 0 ? ` (${skipped} skipped from cache)` : "")
        );

        const handle = await context.writeResource("result", "main", {
          checkedAt: new Date().toISOString(),
          files,
          totalChecked: allEntries.length,
          ok,
          mismatches,
          notFound,
          errors,
          entries: finalEntries,
        });

        return { dataHandles: [handle] };
      },
    },

    recheck: {
      description:
        "Re-query Leo only for entries that had status 'error' or 'not_found' in the last stored result. " +
        "Merges the new results back into the stored data and overwrites the 'main' resource.",
      arguments: z.object({
        delayMs: z
          .number()
          .int()
          .min(0)
          .default(600)
          .describe("Milliseconds to wait between Leo requests."),
      }),
      execute: async (args, context) => {
        const { delayMs } = args;

        // Load previous result
        const prev = await context.readResource!("main") as z.infer<typeof VerifyResultSchema>;
        if (!prev) {
          throw new Error("No stored result found. Run 'verify' first.");
        }

        const toRecheck = prev.entries.filter(
          (e) => e.status === "error" || e.status === "not_found"
        );
        if (toRecheck.length === 0) {
          context.logger.info("No error/not_found entries to recheck.");
          const handle = await context.writeResource("result", "main", prev);
          return { dataHandles: [handle] };
        }

        context.logger.info(`Rechecking ${toRecheck.length} error/not_found entries…`);

        // Build a mutable copy of entries, keyed by italian word for fast lookup
        const updatedEntries = prev.entries.map((e) => ({ ...e }));
        const indexByKey = new Map(
          updatedEntries.map((e, i) => [cacheKey(e.italian, e.german), i])
        );

        let okDelta = 0, mismatchDelta = 0, notFoundDelta = 0, errorDelta = 0;

        for (let idx = 0; idx < toRecheck.length; idx++) {
          const entry = toRecheck[idx];
          const queryWord = normalizeQueryWord(entry.italian);

          context.logger.info(
            `[${idx + 1}/${toRecheck.length}] ${queryWord} (${entry.group})`
          );

          const { status, leoTranslations, detail } = await checkEntry({
            file: "",
            group: entry.group,
            italian: entry.italian,
            german: entry.german,
          });

          if (status === "ok") okDelta++;
          else if (status === "mismatch") mismatchDelta++;
          else if (status === "not_found") notFoundDelta++;
          else errorDelta++;

          const i = indexByKey.get(cacheKey(entry.italian, entry.german));
          if (i !== undefined) {
            updatedEntries[i] = {
              ...updatedEntries[i],
              status,
              leoTranslations,
              ...(detail !== undefined ? { detail } : { detail: undefined }),
            };
          }

          if (idx < toRecheck.length - 1 && delayMs > 0) {
            await new Promise((r) => setTimeout(r, delayMs));
          }
        }

        const prevErrors = prev.entries.filter((e) => e.status === "error").length;
        const prevNotFound = prev.entries.filter((e) => e.status === "not_found").length;

        context.logger.info(
          `Recheck done — ok: +${okDelta}, mismatches: +${mismatchDelta}, ` +
          `not_found: +${notFoundDelta}, still error: ${errorDelta}`
        );

        const merged: z.infer<typeof VerifyResultSchema> = {
          ...prev,
          checkedAt: new Date().toISOString(),
          ok: prev.ok + okDelta,
          mismatches: prev.mismatches + mismatchDelta,
          notFound: prev.notFound - prevNotFound + notFoundDelta,
          errors: prev.errors - prevErrors + errorDelta,
          entries: updatedEntries,
        };

        const handle = await context.writeResource("result", "main", merged);
        return { dataHandles: [handle] };
      },
    },
  },
};
