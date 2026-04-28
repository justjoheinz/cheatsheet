import { z } from "npm:zod@4";
import * as path from "node:path";
import * as fs from "node:fs/promises";

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
        "Regenerate the README.md PDF table from all compiled cheatsheets. " +
        "Reads cheatsheet metadata from the 'cheatsheets' global argument (wired via " +
        "data.findByTag on the aggregator instance), sorts by topic then name, and " +
        "rewrites the table block in README.md.",
      arguments: z.object({}),
      execute: async (
        _args: Record<string, never>,
        context: {
          globalArgs: {
            repoDir: string;
            cheatsheets?: Array<{ name: string; title: string; subtitle: string; topic: string }>;
          };
          logger: { info: (msg: string) => void; error: (msg: string) => void };
        }
      ) => {
        const { repoDir, cheatsheets } = context.globalArgs;

        if (!cheatsheets?.length) {
          throw new Error(
            "No cheatsheet data available. Wire the 'cheatsheets' global argument via CEL: " +
            "data.findByTag('specName', 'cheatsheet').map(r, r.attributes)"
          );
        }

        context.logger.info(`Building README table for ${cheatsheets.length} cheatsheet(s)…`);

        const entries = cheatsheets
          .map((c) => ({
            name: c.name,
            title: c.title,
            subtitle: c.subtitle,
            topic: (c.topic as Topic) ?? "Thematisch",
          }))
          .sort((a, b) => {
            const topicDiff = (TOPIC_ORDER[a.topic] ?? 3) - (TOPIC_ORDER[b.topic] ?? 3);
            return topicDiff !== 0 ? topicDiff : a.name.localeCompare(b.name);
          });

        const rows = entries.map(
          (e) =>
            `| [${e.name}.pdf](output/${e.name}.pdf) | ${e.topic} | ${e.title} — ${toTitleCase(e.subtitle)} |`
        );
        const newTable = `| PDF | Topic | Inhalt |\n|---|---|---|\n` + rows.join("\n") + "\n";

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
