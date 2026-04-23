import { z } from "npm:zod@4";
import * as path from "node:path";
import * as fs from "node:fs/promises";
import { execFile } from "node:child_process";
import { promisify } from "node:util";

const execFileAsync = promisify(execFile);

// ── Shared helpers (duplicated from cheatsheet.ts to keep files self-contained) ─

function extractPageTitle(
  source: string
): { title: string; subtitle: string } | null {
  const match = source.match(/#page-title\[([^\]]*)\]\[([^\]]*)\]/);
  if (!match) return null;
  return { title: match[1].trim(), subtitle: match[2].trim() };
}

type Topic = "Grammatik & Verben" | "Grammatik" | "Vokabular" | "Thematisch";

const TOPIC_ORDER: Record<Topic, number> = {
  "Grammatik & Verben": 0,
  "Grammatik": 1,
  "Vokabular": 2,
  "Thematisch": 3,
};

function toTitleCase(subtitle: string): string {
  return subtitle
    .split(" · ")
    .map((part) => 
      part.split(/\s+/)
        .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
        .join(" ")
    )
    .join(" · ");
}

// ── Extension ─────────────────────────────────────────────────────────────────

export const extension = {
  type: "@justjoheinz/cheatsheet",
  methods: [{
    "update-readme": {
      description:
        "Regenerate the README.md PDF table from all compiled cheatsheets in the repo. " +
        "Scans for .typ files (excluding shared.typ) that have a matching .pdf, extracts " +
        "their title and subtitle, sorts by topic then name, and rewrites the table block.",
      arguments: z.object({}),
      execute: async (
        _args: Record<string, never>,
        context: {
          globalArgs: { repoDir: string };
          logger: { info: (msg: string) => void; error: (msg: string) => void };
        }
      ) => {
        const { repoDir } = context.globalArgs;

        // Collect metadata from every .typ / .pdf pair
        const allFiles = await fs.readdir(repoDir);
        const typStems = allFiles
          .filter((f) => f.endsWith(".typ") && f !== "shared.typ")
          .map((f) => f.replace(/\.typ$/, ""));

        type Entry = { name: string; title: string; subtitle: string; topic: Topic };
        const entries: Entry[] = [];

        for (const stem of typStems) {
          const pdfPath = path.join(repoDir, `${stem}.pdf`);
          try {
            await fs.access(pdfPath);
          } catch {
            context.logger.info(`Skipping ${stem} — no PDF found`);
            continue;
          }

          const source = await fs.readFile(
            path.join(repoDir, `${stem}.typ`),
            "utf-8"
          );
          const pageTitle = extractPageTitle(source);
          if (!pageTitle) {
            context.logger.info(`Skipping ${stem} — no #page-title found`);
            continue;
          }

          // Get topic from swamp model
          let topic: Topic = "Thematisch";
          try {
            const { stdout } = await execFileAsync("swamp", [
              "model",
              "get",
              stem,
              "--json",
            ]);
            const modelData = JSON.parse(stdout);
            topic = modelData.globalArguments?.topic || "Thematisch";
          } catch {
            context.logger.info(`Could not read topic for ${stem}, using default: Thematisch`);
          }

          entries.push({
            name: stem,
            title: pageTitle.title,
            subtitle: pageTitle.subtitle,
            topic,
          });
        }

        // Sort: topic order first, then alphabetically by name
        entries.sort((a, b) => {
          const topicDiff = TOPIC_ORDER[a.topic] - TOPIC_ORDER[b.topic];
          return topicDiff !== 0 ? topicDiff : a.name.localeCompare(b.name);
        });

        context.logger.info(
          `Building README table for ${entries.length} cheatsheet(s)…`
        );

        // Build the markdown table
        const rows = entries.map(
          (e) =>
            `| [${e.name}.pdf](${e.name}.pdf) | ${e.topic} | ${e.title} — ${toTitleCase(e.subtitle)} |`
        );
        const newTable = `| PDF | Topic | Inhalt |\n|---|---|---|\n` + rows.join("\n") + "\n";

        // Replace the existing table block in README.md
        const readmePath = path.join(repoDir, "README.md");
        const readme = await fs.readFile(readmePath, "utf-8");

        const tableRegex = /\| PDF \| (?:Topic \| )?Inhalt \|\n\|---\|(?:---\|)?---\|\n(?:\|[^\n]*\|\n)*/;
        if (!tableRegex.test(readme)) {
          throw new Error(
            "Could not locate the PDF table in README.md. " +
              "Expected a block starting with '| PDF | Inhalt |' or '| PDF | Topic | Inhalt |'."
          );
        }

        const updated = readme.replace(tableRegex, newTable);
        await fs.writeFile(readmePath, updated, "utf-8");

        context.logger.info(`README.md updated — ${entries.length} row(s) written.`);

        return {};
      },
    },
  }],
};
