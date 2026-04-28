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
});

const ManifestSchema = z.object({
  typFiles: z
    .array(z.string())
    .describe("Relative paths of .typ files that have a matching .pdf, e.g. 'verbi.typ'"),
  scannedAt: z.iso.datetime().describe("Timestamp of the scan"),
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
  version: "2026.04.28.1",

  upgrades: [
    {
      fromVersion: "2026.04.22.1",
      toVersion: "2026.04.28.1",
      description: "add scan method that writes manifest of all .typ files with matching .pdf",
      upgradeAttributes: (old: unknown) => old,
    },
  ],

  globalArguments: GlobalArgsSchema,

  resources: {
    manifest: {
      description: "List of .typ files (relative paths) that have a matching .pdf in repoDir",
      schema: ManifestSchema,
      lifetime: "infinite",
      garbageCollection: 5,
    },
    cheatsheet: {
      description:
        "Compiled cheatsheet metadata: title, subtitle, topic, page count, PDF size",
      schema: CheatsheetSchema,
      lifetime: "infinite",
      garbageCollection: 20,
    },
  },

  methods: {
    scan: {
      description:
        "Scan repoDir for .typ files (excluding shared.typ) that have a matching .pdf " +
        "and write the list as a manifest resource. Other models (e.g. leo-vocab-verifier) " +
        "wire to this manifest via CEL instead of scanning the filesystem themselves.",
      arguments: z.object({}),
      execute: async (
        _args: Record<string, never>,
        context: {
          globalArgs: { repoDir: string };
          writeResource: (spec: string, instance: string, data: unknown) => Promise<unknown>;
          logger: { info: (msg: string) => void };
        }
      ) => {
        const { repoDir } = context.globalArgs;
        const allFiles = await fs.readdir(repoDir);
        const typFiles = allFiles
          .filter((f) => f.endsWith(".typ") && f !== "shared.typ")
          .filter((f) => allFiles.includes(f.replace(/\.typ$/, ".pdf")))
          .sort();

        context.logger.info(`Found ${typFiles.length} .typ files with matching .pdf: ${typFiles.join(", ")}`);

        const handle = await context.writeResource("manifest", "main", {
          typFiles,
          scannedAt: new Date().toISOString(),
        });

        return { dataHandles: [handle] };
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

