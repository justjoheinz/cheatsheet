import { z } from "npm:zod@4";
import * as path from "node:path";
import * as fs from "node:fs/promises";
import { execFile } from "node:child_process";
import { promisify } from "node:util";

const execFileAsync = promisify(execFile);

// ── Schemas ───────────────────────────────────────────────────────────────────

const GlobalArgsSchema = z.object({
  repoDir: z
    .string()
    .describe("Absolute path to the cheatsheet repository root"),
});

const CheatsheetSchema = z.object({
  name: z.string().describe("Stem of the .typ file, e.g. 'condizionale'"),
  title: z.string().describe("L1 page title extracted from first #page-title"),
  subtitle: z
    .string()
    .describe("L1 subtitle extracted from first #page-title (use middot · as separator; Italian language only)"),
  topic: z
    .enum([
      "Grammatik",
      "Vokabular",
      "Literatur",
      "Thematisch",
      "Grammatik & Verben",
    ])
    .describe("Content domain classification"),
  pageCount: z
    .number()
    .int()
    .positive()
    .describe("Number of pages (count of #page-title calls)"),
  typFile: z.string().describe("Absolute path to the .typ source file"),
  pdfFile: z.string().describe("Absolute path to the compiled .pdf file"),
  pdfSizeBytes: z
    .number()
    .int()
    .nonnegative()
    .describe("Size of compiled PDF in bytes"),
  compiledAt: z.iso.datetime().describe("Timestamp of successful compilation"),
});

// ── Helpers ───────────────────────────────────────────────────────────────────

function extractPageTitle(
  source: string
): { title: string; subtitle: string } | null {
  // Match: #page-title[...][...]
  // Convention: subtitle uses middot (·) as separator, not plus (+)
  const match = source.match(/#page-title\[([^\]]*)\]\[([^\]]*)\]/);
  if (!match) return null;
  return { title: match[1].trim(), subtitle: match[2].trim() };
}

function countPages(source: string): number {
  const matches = source.match(/#page-title\[/g);
  return matches ? matches.length : 1;
}

function classifyTopic(
  name: string,
  title: string
): z.infer<typeof CheatsheetSchema>["topic"] {
  if (name === "cheatsheet") return "Grammatik & Verben";
  const lower = title.toLowerCase();
  if (lower.includes("verbali") || lower.includes("verbi")) return "Grammatik & Verben";
  if (
    lower.includes("condizionale") ||
    lower.includes("futuro") ||
    lower.includes("congiuntivo") ||
    lower.includes("tempi") ||
    lower.includes("passato") ||
    lower.includes("imperfetto") ||
    lower.includes("presente") ||
    lower.includes("gerundio") ||
    lower.includes("imperativo")
  )
    return "Grammatik";
  if (
    lower.includes("libro") ||
    lower.includes("letteratura") ||
    lower.includes("racconto") ||
    lower.includes("contenuto") ||
    lower.includes("lesepraxis") ||
    lower.includes("media")
  )
    return "Literatur";
  if (lower.includes("parole") || lower.includes("vocabolario"))
    return "Vokabular";
  // Thematic: orientarsi, arte, musica, pittura, architettura, etc.
  return "Thematisch";
}

// ── Model ─────────────────────────────────────────────────────────────────────

export const model = {
  type: "@justjoheinz/cheatsheet",
  version: "2026.04.22.1",

  globalArguments: GlobalArgsSchema,

  resources: {
    cheatsheet: {
      description:
        "Compiled cheatsheet metadata: title, subtitle, topic, page count, PDF size",
      schema: CheatsheetSchema,
      lifetime: "infinite",
      garbageCollection: 20,
    },
  },

  methods: {
    compile: {
      description:
        "Compile a .typ cheatsheet to PDF and record its metadata. " +
        "Pass the file stem as 'name' (e.g. 'condizionale', not 'condizionale.typ').",
      arguments: z.object({
        name: z
          .string()
          .min(1)
          .describe("Stem of the .typ file to compile, without extension"),
      }),
      execute: async (
        args: { name: string },
        context: {
          globalArgs: { repoDir: string };
          writeResource: (
            spec: string,
            instance: string,
            data: unknown
          ) => Promise<unknown>;
          logger: { info: (msg: string) => void; error: (msg: string) => void };
        }
      ) => {
        const { name } = args;
        const repoDir = context.globalArgs.repoDir;
        const typFile = path.join(repoDir, `${name}.typ`);
        const pdfFile = path.join(repoDir, `${name}.pdf`);

        // Verify source exists
        try {
          await fs.access(typFile);
        } catch {
          throw new Error(
            `Source file not found: ${typFile}. ` +
              `Available files: run 'ls *.typ' in the repo root.`
          );
        }

        // Read source to extract metadata before compilation
        const source = await fs.readFile(typFile, "utf-8");
        const pageTitleData = extractPageTitle(source);
        if (!pageTitleData) {
          throw new Error(
            `No #page-title found in ${typFile}. ` +
              `Every cheatsheet must start with #page-title[Title][SUBTITLE].`
          );
        }

        const pageCount = countPages(source);
        const topic = classifyTopic(name, pageTitleData.title);

        context.logger.info(`Compiling ${name}.typ (${pageCount} page(s))…`);

        // Compile with typst
        try {
          await execFileAsync("typst", ["compile", typFile], {
            cwd: repoDir,
          });
        } catch (err: unknown) {
          const msg =
            err instanceof Error ? err.message : String(err);
          throw new Error(`typst compile failed for ${name}.typ: ${msg}`);
        }

        // Read PDF size post-compilation
        const pdfStat = await fs.stat(pdfFile);
        const compiledAt = new Date().toISOString();

        context.logger.info(
          `Compiled ${name}.pdf (${pdfStat.size} bytes, ${pageCount} page(s))`
        );

        const handle = await context.writeResource("cheatsheet", name, {
          name,
          title: pageTitleData.title,
          subtitle: pageTitleData.subtitle,
          topic,
          pageCount,
          typFile,
          pdfFile,
          pdfSizeBytes: pdfStat.size,
          compiledAt,
        });

        return { dataHandles: [handle] };
      },
    },
  },
};

