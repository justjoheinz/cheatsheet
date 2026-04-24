import { z } from "npm:zod@4";
import * as fs from "node:fs/promises";
import * as path from "node:path";

// ── Schemas ───────────────────────────────────────────────────────────────────

const EntryResultSchema = z.object({
  group: z.string().describe("Vocab group label from #vocab-group"),
  italian: z.string().describe("Italian word as written in the cheatsheet"),
  german: z.string().describe("German translation as written in the cheatsheet"),
  status: z
    .enum(["ok", "mismatch", "not_found", "error", "accepted"])
    .describe("Verification result; 'accepted' = mismatch consciously approved"),
  leoTranslations: z
    .array(z.string())
    .describe("All German translations returned by Leo for this word"),
  detail: z.string().optional().describe("Additional context for mismatch or error"),
  acceptedAt: z.iso.datetime().optional().describe("Timestamp when this entry was accepted"),
});

const VerifyResultSchema = z.object({
  checkedAt: z.iso.datetime(),
  files: z.array(z.string()).describe("Typ files that were scanned"),
  totalChecked: z.number().int(),
  ok: z.number().int(),
  mismatches: z.number().int(),
  notFound: z.number().int(),
  errors: z.number().int(),
  accepted: z.number().int().default(0),
  entries: z.array(EntryResultSchema),
});

// ── Parsing ───────────────────────────────────────────────────────────────────

type VocabEntry = { file: string; group: string; italian: string; german: string };

function normalizeQueryWord(word: string): string {
  return word
    .replace(/^(il|la|lo|i|gli|le|un|una|uno)\s+/i, "")
    .replace(/^(l'|un')/i, "")
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
    const entriesStart = groupStart + labelMatch[0].length;

    let depth = 1;
    let i = entriesStart;
    while (i < source.length && depth > 0) {
      if (source[i] === "(") depth++;
      else if (source[i] === ")") depth--;
      i++;
    }
    const content = source.slice(entriesStart, i - 1);

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

function extractLeoXml(html: string): string | null {
  const m = html.match(/<xml\s[^>]*leorendertarget="1"[\s\S]*?<\/xml>/);
  return m ? m[0] : null;
}

function parseLeoEntries(xml: string): Array<{ it: string[]; de: string[] }> {
  const entries: Array<{ it: string[]; de: string[] }> = [];

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

  if (!res.ok) throw new Error(`Leo HTTP ${res.status} for "${word}"`);

  const html = await res.text();
  const xml = extractLeoXml(html);
  if (!xml) throw new Error(`Leo returned no XML blob for "${word}"`);

  return parseLeoEntries(xml).flatMap((e) => e.de);
}

// ── Comparison ────────────────────────────────────────────────────────────────

const DE_ARTICLES = /^(der|die|das|den|dem|des|ein|eine|einen|einem|einer|eines)\s+/i;

function normalizeDE(s: string): string {
  return s.toLowerCase().replace(DE_ARTICLES, "").replace(/[().,!?;:]/g, "").trim();
}

function splitCheatsheetDE(german: string): string[] {
  return german.split(/\s*[/·]\s*/).map((s) => s.trim()).filter(Boolean);
}

function translationMatches(cheatsheetDE: string, leoDE: string[]): boolean {
  const terms = splitCheatsheetDE(cheatsheetDE).map(normalizeDE);
  const leoNorm = leoDE.map(normalizeDE);
  return terms.some((term) =>
    leoNorm.some((leo) => leo === term || leo.includes(term) || term.includes(leo))
  );
}

// ── Helpers ───────────────────────────────────────────────────────────────────

type EntryResult = z.infer<typeof EntryResultSchema>;

function cacheKey(italian: string, german: string): string {
  return `${italian}|||${german}`;
}

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

function countStatuses(entries: EntryResult[]) {
  let ok = 0, mismatches = 0, notFound = 0, errors = 0, accepted = 0;
  for (const e of entries) {
    if (e.status === "ok") ok++;
    else if (e.status === "mismatch") mismatches++;
    else if (e.status === "not_found") notFound++;
    else if (e.status === "error") errors++;
    else if (e.status === "accepted") accepted++;
  }
  return { ok, mismatches, notFound, errors, accepted };
}

// ── Model ─────────────────────────────────────────────────────────────────────

export const model = {
  type: "@justjoheinz/leo-vocab-verifier",
  version: "2026.04.24.3",

  upgrades: [
    {
      fromVersion: "2026.04.24.1",
      toVersion: "2026.04.24.2",
      description: "verify skips cached ok/mismatch; recheck covers not_found too",
      upgradeAttributes: (old: unknown) => old,
    },
    {
      fromVersion: "2026.04.24.2",
      toVersion: "2026.04.24.3",
      description: "add accepted status; verify now re-queries mismatch entries until explicitly accepted",
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
        "Parse #vocab-group entries from .typ files and verify each Italian → German pair " +
        "against dict.leo.org. Skips entries with status 'ok' or 'accepted'. " +
        "Re-queries 'mismatch', 'error', 'not_found', and new entries.",
      arguments: z.object({
        files: z
          .array(z.string())
          .default(["cheatsheet.typ", "letteratura.typ"])
          .describe("Typ file names relative to the repository root to scan."),
        delayMs: z
          .number().int().min(0).default(600)
          .describe("Milliseconds to wait between Leo requests to avoid rate-limiting."),
      }),
      execute: async (args, context) => {
        const { files, delayMs } = args;

        // 1. Parse all vocab entries
        const allEntries: VocabEntry[] = [];
        for (const file of files) {
          const fullPath = path.join(context.repoDir, file);
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
          throw new Error("No #vocab-group entries found in the specified files.");
        }

        // 2. Load cached results — only ok and accepted are permanent skips
        const cachedMap = new Map<string, EntryResult>();
        try {
          const prev = await context.readResource!("main") as z.infer<typeof VerifyResultSchema>;
          if (prev?.entries) {
            for (const e of prev.entries) {
              cachedMap.set(cacheKey(e.italian, e.german), e);
            }
            context.logger.info(`Loaded ${cachedMap.size} cached results from previous run`);
          }
        } catch {
          // No previous result — first run
        }

        // 3. Partition: skip ok/accepted, query everything else
        const toQuery: VocabEntry[] = [];
        for (const entry of allEntries) {
          const hit = cachedMap.get(cacheKey(entry.italian, entry.german));
          if (hit && (hit.status === "ok" || hit.status === "accepted")) {
            // permanent skip
          } else {
            toQuery.push(entry);
          }
        }

        const skipped = allEntries.length - toQuery.length;
        if (skipped > 0) {
          context.logger.info(`Skipping ${skipped} entries (ok/accepted)`);
        }

        // 4. Query Leo for entries that need checking
        const freshResults = new Map<string, EntryResult>();

        for (let qi = 0; qi < toQuery.length; qi++) {
          const entry = toQuery[qi];
          const queryWord = normalizeQueryWord(entry.italian);
          context.logger.info(`[${qi + 1}/${toQuery.length}] ${queryWord} (${entry.group})`);

          const { status, leoTranslations, detail } = await checkEntry(entry);

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

        // 5. Rebuild in original order
        const finalEntries: EntryResult[] = allEntries.map((entry) => {
          const key = cacheKey(entry.italian, entry.german);
          return freshResults.get(key) ?? cachedMap.get(key)!;
        });

        const counts = countStatuses(finalEntries);
        context.logger.info(
          `Done — ok: ${counts.ok}, accepted: ${counts.accepted}, mismatches: ${counts.mismatches}, ` +
          `not_found: ${counts.notFound}, errors: ${counts.errors}` +
          (skipped > 0 ? ` (${skipped} skipped from cache)` : "")
        );

        const handle = await context.writeResource("result", "main", {
          checkedAt: new Date().toISOString(),
          files,
          totalChecked: allEntries.length,
          ...counts,
          entries: finalEntries,
        });

        return { dataHandles: [handle] };
      },
    },

    accept: {
      description:
        "Mark mismatch entries as consciously accepted. Accepted entries are skipped in " +
        "future verify runs and listed separately. Pass Italian words as written in the " +
        "cheatsheet (with or without article, e.g. 'il leader' or 'leader').",
      arguments: z.object({
        words: z
          .array(z.string()).min(1)
          .describe("Italian words to accept, as written in the cheatsheet."),
      }),
      execute: async (args, context) => {
        const { words } = args;

        const prev = await context.readResource!("main") as z.infer<typeof VerifyResultSchema>;
        if (!prev) {
          throw new Error("No stored result found. Run 'verify' first.");
        }

        // Normalize input words for matching (strip articles)
        const normalizedWords = new Set(words.map((w) => normalizeQueryWord(w).toLowerCase()));

        let acceptedCount = 0;
        const now = new Date().toISOString();

        const updatedEntries = prev.entries.map((e) => {
          const entryNorm = normalizeQueryWord(e.italian).toLowerCase();
          const exactMatch = words.some(
            (w) => w.toLowerCase() === e.italian.toLowerCase()
          );
          const normalizedMatch = normalizedWords.has(entryNorm);

          if ((exactMatch || normalizedMatch) && e.status === "mismatch") {
            acceptedCount++;
            context.logger.info(`Accepted: ${e.italian} (${e.group})`);
            return { ...e, status: "accepted" as const, acceptedAt: now };
          }
          return e;
        });

        if (acceptedCount === 0) {
          const notMismatch = prev.entries.filter((e) =>
            words.some(
              (w) =>
                w.toLowerCase() === e.italian.toLowerCase() ||
                normalizedWords.has(normalizeQueryWord(e.italian).toLowerCase())
            )
          );
          if (notMismatch.length > 0) {
            throw new Error(
              `No mismatch entries found for the given words. ` +
              `Current status: ${notMismatch.map((e) => `${e.italian} → ${e.status}`).join(", ")}`
            );
          }
          throw new Error(`No matching entries found for: ${words.join(", ")}`);
        }

        context.logger.info(`Marked ${acceptedCount} entry/entries as accepted`);

        const counts = countStatuses(updatedEntries);
        const handle = await context.writeResource("result", "main", {
          ...prev,
          checkedAt: new Date().toISOString(),
          ...counts,
          entries: updatedEntries,
        });

        return { dataHandles: [handle] };
      },
    },

    recheck: {
      description:
        "Re-query Leo only for entries with status 'error' or 'not_found'. " +
        "Accepted and ok entries are never re-queried.",
      arguments: z.object({
        delayMs: z
          .number().int().min(0).default(600)
          .describe("Milliseconds to wait between Leo requests."),
      }),
      execute: async (args, context) => {
        const { delayMs } = args;

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

        const updatedEntries = prev.entries.map((e) => ({ ...e }));
        const indexByKey = new Map(
          updatedEntries.map((e, i) => [cacheKey(e.italian, e.german), i])
        );

        for (let idx = 0; idx < toRecheck.length; idx++) {
          const entry = toRecheck[idx];
          const queryWord = normalizeQueryWord(entry.italian);
          context.logger.info(`[${idx + 1}/${toRecheck.length}] ${queryWord} (${entry.group})`);

          const { status, leoTranslations, detail } = await checkEntry({
            file: "",
            group: entry.group,
            italian: entry.italian,
            german: entry.german,
          });

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

        const counts = countStatuses(updatedEntries);
        context.logger.info(
          `Recheck done — ok: ${counts.ok}, accepted: ${counts.accepted}, ` +
          `mismatches: ${counts.mismatches}, not_found: ${counts.notFound}, errors: ${counts.errors}`
        );

        const handle = await context.writeResource("result", "main", {
          ...prev,
          checkedAt: new Date().toISOString(),
          ...counts,
          entries: updatedEntries,
        });

        return { dataHandles: [handle] };
      },
    },
  },
};
