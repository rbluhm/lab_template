# Literature Workflow: Zotero → Obsidian → Marker

## Overview

Per-project research pipeline for managing academic literature. Three artifacts per paper, linked by a stable citekey:

1. **PDF + metadata** — managed in Zotero
2. **Structured note** — generated from Zotero highlights and metadata, with persistent thought sections
3. **Full-text rendering** — markdown conversion of the PDF for full-text search and LLM context

The project repository *is* the Obsidian vault. Each project has its own vault with project-specific notes; PDFs live in one global location shared across projects.

## Architecture

```
~/research/_pdfs/                          # Global PDF store, outside any project
    <citekey>.pdf                          # Renamed by Better BibTeX

<repo-root>/                               # Project repo = Obsidian vault
├── .obsidian/
│   ├── app.json                           # tracked
│   ├── community-plugins.json             # tracked
│   └── plugins/
│       └── obsidian-zotero-desktop-connector/
│           └── data.json                  # tracked (no secrets)
├── literature/
│   ├── notes/<citekey>.md                 # Zotero Integration output
│   ├── fulltexts/<citekey>.md             # Marker output
│   └── templates/lit-note.md              # Nunjucks template
├── scripts/
│   └── marker-convert.sh                  # Marker API client
└── .gitignore
```

## Required tools

- **Zotero 7** with **Better BibTeX** (citekey format: `[auth:lower][year]`, e.g. `acemoglu2001`)
- **Obsidian** with the **Zotero Integration** plugin (mgmeyers)
- Access to the **Marker API** at `https://server.ivr.uni-stuttgart.de/marker/upload` (campus network or VPN; running `marker-pdf[api]`)

## One-time setup

### Zotero

1. Better BibTeX → set citekey format to `[auth:lower][year]`, enable "On item change" auto-pin.
2. Settings → Advanced → Files & Folders → Linked Attachment Base Directory: `~/research/_pdfs/`
3. Configure Better BibTeX to rename attachments to `<citekey>.pdf` on import.

### Obsidian

1. Open the project repo root as an Obsidian vault.
2. Install Zotero Integration plugin; the import format and template path are already configured in the tracked `data.json`.
3. Verify Import Format settings:
   - Template File Path: `literature/templates/lit-note.md`
   - Output Path: `literature/notes`
   - Output File Name: `{{citekey}}`
   - Image Output Path: `literature/notes/assets`

### Marker script

`scripts/marker-convert.sh` is checked in. Make it executable on first checkout:

```bash
chmod +x scripts/marker-convert.sh
```

The script reads PDFs from `~/research/_pdfs/<citekey>.pdf` and writes markdown to `literature/fulltexts/<citekey>.md`. Configure the global PDF directory at the top of the script if your local path differs.

## Per-paper workflow

1. **Read and annotate** the PDF in Zotero, using color-coded highlights:
   - Orange = Definitions
   - Magenta = Research question
   - Green = Design / Method
   - Red = Results
   - Purple = Mechanism
   - Blue = Contribution
   - Gray = Further literature

2. **Generate the structured note**: Obsidian → Command Palette → *Zotero Integration: Import* → select paper. Output appears at `literature/notes/<citekey>.md`. Re-running the import on the same paper refreshes highlights while preserving `{% persist %}` blocks (your own thoughts).

3. **Generate the full-text rendering** (only for papers you'll engage with deeply):
   ```bash
   ./scripts/marker-convert.sh <citekey>
   ```
   Output at `literature/fulltexts/<citekey>.md`. The structured note's `[[<citekey>]]` link resolves to this file.

4. **Write your thoughts** in the `## Persistent notes` section of the structured note. These survive re-imports.

## What's in git

**Tracked:**
- `.obsidian/` (excluding workspace state)
- `literature/notes/`, `literature/fulltexts/`, `literature/templates/`
- `scripts/`

**Ignored:**
- `.obsidian/workspace.json`, `workspace-mobile.json`, `cache/`
- PDFs (they live outside the repo in `~/research/_pdfs/`)
- `.env`

## Notes for collaborators

- The Marker API is restricted to campus IPs / VPN. If `scripts/marker-convert.sh` times out, check VPN connection.
- Citekeys must be consistent across collaborators. Everyone uses Better BibTeX with the same citekey format, so the same paper resolves to the same filename in every clone.
- The pipeline does not require the Obsidian Marker plugin. The shell script is the supported path because it has no plugin-version dependencies and works identically on every machine.
- PDFs are not in the repo by design. Each collaborator maintains their own Zotero library and PDF store; the repo contains only the *artifacts about* papers (notes, full-text renderings, templates).
