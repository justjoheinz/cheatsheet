import { z } from "npm:zod@4";
import * as path from "node:path";
import * as fs from "node:fs/promises";
import { execFile } from "node:child_process";
import { promisify } from "node:util";

const execFileAsync = promisify(execFile);

// ── Schemas ───────────────────────────────────────────────────────────────────

const ReviewSchema = z.object({
  status: z.enum(["draft", "approved", "discarded"]),
  createdAt: z.iso.datetime(),
  message: z.string().optional(),
  committedAt: z.iso.datetime().optional(),
});

const TOPIC_VALUES = ["Grammatik", "Vokabular", "Thematisch", "Grammatik & Verben"] as const;

// ── Scaffold template ─────────────────────────────────────────────────────────

function scaffoldTyp(name: string, topic: string): string {
  const title = name.charAt(0).toUpperCase() + name.slice(1);
  const subtitle = topic.toUpperCase();
  return `#import "shared.typ": *
#show: cheatsheet

#page-title[${title}][${subtitle}]

#columns(2, gutter: 0.9cm)[

// content here

] // end columns
`;
}

// ── Extension ─────────────────────────────────────────────────────────────────

export const extension = {
  type: "@justjoheinz/cheatsheet",
  methods: [
    {
      create: {
        description:
          "Start a review process for a cheatsheet. " +
          "For new cheatsheets (no .typ file yet): scaffolds the .typ template and creates the model instance — topic is required. " +
          "For existing cheatsheets: opens a new review cycle without touching the file. " +
          "Run on the aggregator instance (cheatsheet).",
        arguments: z.object({
          name: z.string().min(1).describe("Stem of the cheatsheet, e.g. 'sports'"),
          topic: z
            .enum(TOPIC_VALUES)
            .optional()
            .describe("Required for new cheatsheets; ignored for existing ones"),
        }),
        execute: async (
          args: { name: string; topic?: string },
          context: {
            globalArgs: { repoDir: string };
            writeResource: (spec: string, instance: string, data: unknown) => Promise<unknown>;
            logger: { info: (msg: string) => void; error: (msg: string) => void };
          }
        ) => {
          const { name, topic } = args;
          const { repoDir } = context.globalArgs;
          const typFile = path.join(repoDir, `${name}.typ`);

          const exists = await fs.access(typFile).then(() => true).catch(() => false);

          if (!exists) {
            if (!topic) {
              throw new Error(
                `'topic' is required when creating a new cheatsheet. ` +
                `Pass --input topic=<${TOPIC_VALUES.join("|")}>.`
              );
            }
            await fs.writeFile(typFile, scaffoldTyp(name, topic), "utf-8");
            context.logger.info(`Scaffolded ${name}.typ`);

            await execFileAsync(
              "swamp",
              [
                "model", "create",
                "@justjoheinz/cheatsheet", name,
                "--global-arg", `topic=${topic}`,
                "--global-arg", "repoDir=.",
              ],
              { cwd: repoDir }
            );
            context.logger.info(`Model instance '${name}' created`);
          }

          await context.writeResource("review", name, {
            status: "draft",
            createdAt: new Date().toISOString(),
          });

          const next = `swamp model method run ${name} approve --input name=${name} --input message="..."`;
          context.logger.info(
            exists
              ? `Review process started for ${name} — edit the file; it will compile automatically. When ready: ${next}`
              : `Draft created — edit ${name}.typ; it will compile automatically. When ready: ${next}`
          );

          return {};
        },
      },
    },
    {
      approve: {
        description:
          "Commit an approved cheatsheet to git. " +
          "Updates README, stages .typ + PDF + README + model config, and commits. " +
          "Requires output/<name>.pdf to exist (compiled by compile-on-schedule).",
        arguments: z.object({
          name: z.string().min(1).describe("Stem of the cheatsheet, e.g. 'sports'"),
          message: z.string().min(1).describe("Git commit message"),
        }),
        execute: async (
          args: { name: string; message: string },
          context: {
            globalArgs: { repoDir: string };
            writeResource: (spec: string, instance: string, data: unknown) => Promise<unknown>;
            logger: { info: (msg: string) => void; error: (msg: string) => void };
          }
        ) => {
          const { name, message } = args;
          const { repoDir } = context.globalArgs;
          const pdfFile = path.join(repoDir, "output", `${name}.pdf`);

          const pdfExists = await fs.access(pdfFile).then(() => true).catch(() => false);
          if (!pdfExists) {
            throw new Error(
              `output/${name}.pdf not found. The cheatsheet has not been compiled yet. ` +
              `Wait for compile-on-schedule or run: swamp model method run ${name} compile --input name=${name}`
            );
          }

          context.logger.info("Updating README…");
          await execFileAsync(
            "swamp",
            ["model", "method", "run", "cheatsheet", "update-readme"],
            { cwd: repoDir }
          );

          context.logger.info(`Staging and committing ${name}…`);
          await execFileAsync(
            "git",
            ["add", `${name}.typ`, `output/${name}.pdf`, "README.md", "models/@justjoheinz/cheatsheet/"],
            { cwd: repoDir }
          );
          await execFileAsync("git", ["commit", "-m", message], { cwd: repoDir });

          const committedAt = new Date().toISOString();
          await context.writeResource("review", name, {
            status: "approved",
            createdAt: committedAt,
            message,
            committedAt,
          });

          context.logger.info(`Approved and committed: ${name}`);
          return {};
        },
      },
    },
    {
      discard: {
        description:
          "Discard changes to a cheatsheet. " +
          "For git-tracked files: restores .typ, PDF, and README to HEAD. " +
          "For new (untracked) files: deletes them.",
        arguments: z.object({
          name: z.string().min(1).describe("Stem of the cheatsheet to discard"),
        }),
        execute: async (
          args: { name: string },
          context: {
            globalArgs: { repoDir: string };
            writeResource: (spec: string, instance: string, data: unknown) => Promise<unknown>;
            logger: { info: (msg: string) => void; error: (msg: string) => void };
          }
        ) => {
          const { name } = args;
          const { repoDir } = context.globalArgs;
          const typFile = path.join(repoDir, `${name}.typ`);
          const pdfFile = path.join(repoDir, "output", `${name}.pdf`);

          // Is the .typ file tracked by git?
          const tracked = await execFileAsync(
            "git", ["ls-files", "--error-unmatch", `${name}.typ`],
            { cwd: repoDir }
          ).then(() => true).catch(() => false);

          if (tracked) {
            await execFileAsync("git", ["restore", `${name}.typ`], { cwd: repoDir });
            context.logger.info(`Restored ${name}.typ`);

            const pdfTracked = await execFileAsync(
              "git", ["ls-files", "--error-unmatch", `output/${name}.pdf`],
              { cwd: repoDir }
            ).then(() => true).catch(() => false);
            if (pdfTracked) {
              await execFileAsync("git", ["restore", `output/${name}.pdf`], { cwd: repoDir });
              context.logger.info(`Restored output/${name}.pdf`);
            } else {
              const pdfExists = await fs.access(pdfFile).then(() => true).catch(() => false);
              if (pdfExists) await fs.rm(pdfFile);
            }

            await execFileAsync("git", ["restore", "README.md"], { cwd: repoDir });
            context.logger.info("Restored README.md");
          } else {
            // New file — delete it
            await fs.rm(typFile, { force: true });
            context.logger.info(`Deleted ${name}.typ`);
            await fs.rm(pdfFile, { force: true });
          }

          await context.writeResource("review", name, {
            status: "discarded",
            createdAt: new Date().toISOString(),
          });

          context.logger.info(`Discarded changes for ${name}`);
          return {};
        },
      },
    },
  ],

  resources: {
    review: {
      description: "Review lifecycle state for a cheatsheet: draft → approved or discarded",
      schema: ReviewSchema,
      lifetime: "infinite",
      garbageCollection: 5,
    },
  },
};
