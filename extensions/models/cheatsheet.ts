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
  topic: z
    .enum([
      "Grammatik",
      "Vokabular",
      "Thematisch",
      "Grammatik & Verben",
    ])
    .default("Thematisch")
    .describe("Content domain classification for the cheatsheet"),
  cheatsheets: z
    .array(z.object({
      name: z.string(),
      title: z.string(),
      subtitle: z.string(),
      topic: z.string(),
      pdfFile: z.string().optional(),
      compiledAt: z.string().optional(),
    }).passthrough())
    .optional()
    .describe(
      "All compiled cheatsheet attributes, wired via CEL: " +
      "data.findByTag('specName', 'cheatsheet').map(r, r.attributes). " +
      "Used by update-readme and make on the aggregator instance."
    ),
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

// ── Model ─────────────────────────────────────────────────────────────────────

export const model = {
  type: "@justjoheinz/cheatsheet",
  version: "2026.04.28.4",

  upgrades: [
    {
      fromVersion: "2026.04.22.1",
      toVersion: "2026.04.28.1",
      description: "add scan method that writes manifest of all .typ files with matching .pdf",
      upgradeAttributes: (old: unknown) => old,
    },
    {
      fromVersion: "2026.04.28.1",
      toVersion: "2026.04.28.2",
      description: "remove scan/manifest; add cheatsheets global arg wired via data.findByTag for update-readme",
      upgradeAttributes: (old: unknown) => old,
    },
    {
      fromVersion: "2026.04.28.2",
      toVersion: "2026.04.28.3",
      description: "add make method; replaces Makefile + compile-cheatsheets shell model",
      upgradeAttributes: (old: unknown) => old,
    },
    {
      fromVersion: "2026.04.28.3",
      toVersion: "2026.04.28.4",
      description: "add review extension: create, approve, discard methods with review resource",
      upgradeAttributes: (old: unknown) => old,
    },
  ],

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
    make: {
      description:
        "Compile all stale .typ cheatsheets. Compares each file's mtime against compiledAt " +
        "from model data (via the cheatsheets global argument) and recompiles only what has changed. " +
        "Run on the aggregator instance.",
      arguments: z.object({}),
      execute: async (
        _args: Record<string, never>,
        context: {
          globalArgs: { repoDir: string; cheatsheets?: Array<{ name: string; compiledAt?: string }> };
          logger: { info: (msg: string) => void };
        }
      ) => {
        const { repoDir, cheatsheets } = context.globalArgs;

        if (!cheatsheets?.length) {
          throw new Error(
            "No cheatsheet data available. Run 'compile' on each instance first, " +
            "then 'make' handles incremental updates."
          );
        }

        // Determine stale files: missing PDF, no compiledAt, or .typ newer than compiledAt
        const stale: string[] = [];
        for (const c of cheatsheets) {
          const pdfMissing = !c.pdfFile || await fs.access(c.pdfFile).then(() => false).catch(() => true);
          if (pdfMissing || !c.compiledAt) {
            stale.push(c.name);
            continue;
          }
          const stat = await fs.stat(path.join(repoDir, `${c.name}.typ`));
          if (stat.mtimeMs > new Date(c.compiledAt).getTime()) {
            stale.push(c.name);
          }
        }

        if (stale.length === 0) {
          context.logger.info("All cheatsheets up to date.");
          return { dataHandles: [] };
        }

        context.logger.info(`Compiling ${stale.length} stale cheatsheet(s): ${stale.join(", ")}`);

        await Promise.all(
          stale.map(async (stem) => {
            await execFileAsync(
              "swamp",
              ["model", "method", "run", stem, "compile", "--input", `name=${stem}`],
              { cwd: repoDir }
            );
            context.logger.info(`Compiled ${stem}`);
          })
        );

        return { dataHandles: [] };
      },
    },

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
          globalArgs: { repoDir: string; topic: string };
          writeResource: (
            spec: string,
            instance: string,
            data: unknown
          ) => Promise<unknown>;
          logger: { info: (msg: string) => void; error: (msg: string) => void };
        }
      ) => {
        const { name } = args;
        const { repoDir, topic } = context.globalArgs;
        const typFile = path.join(repoDir, `${name}.typ`);
        const outputDir = path.join(repoDir, "output");
        const pdfFile = path.join(outputDir, `${name}.pdf`);

        await fs.mkdir(outputDir, { recursive: true });

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

        context.logger.info(`Compiling ${name}.typ (${pageCount} page(s))…`);

        // Compile with typst
        try {
          await execFileAsync("typst", ["compile", typFile, pdfFile], {
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
