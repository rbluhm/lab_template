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
├── .obsidian/                             # NOT tracked — fully git-ignored
├── literature/
│   ├── notes/<citekey>.md                 # Zotero Integration output
│   ├── fulltexts/<citekey>.md             # markersync output
│   └── templates/paper_note.md            # Nunjucks template
└── .gitignore
```

## Required tools

- **Zotero 7** with **Better BibTeX** (citekey format: `[auth:lower][year]`, e.g. `acemoglu2001`)
- **Obsidian** with the **Zotero Integration** plugin (mgmeyers)
- **R** with the [**markersync**](https://github.com/rbluhm/markersync) package — syncs Zotero-managed PDFs to markdown via a self-hosted Marker server
- Access to the **Marker server** at `https://server.ivr.uni-stuttgart.de/marker/upload` (campus network or VPN; running `marker-pdf[api]`)

## One-time setup

### Zotero

1. Better BibTeX → set citekey format to `[auth:lower][year]`, enable "On item change" auto-pin.
2. Settings → Advanced → Files & Folders → Linked Attachment Base Directory: `~/research/_pdfs/`
3. Configure Better BibTeX to rename attachments to `<citekey>.pdf` on import.

### Obsidian

1. Open the project repo root as an Obsidian vault.
2. Install Zotero Integration plugin and configure Import Format settings:
   - Template File Path: `literature/templates/paper_note.md`
   - Output Path: `literature/notes`
   - Output File Name: `{{citekey}}`
   - Image Output Path: leave **empty** (do not extract annotation images)

   Obsidian config (`.obsidian/`) is **not** tracked, so each collaborator sets this up once per clone.

### markersync

Install the package and point it at this project:

```r
# install once
remotes::install_github("rbluhm/markersync")
```

Configure the Marker server URL and the global PDF directory (`~/research/_pdfs/`)
as described in the package README. `markersync` reads PDFs from Zotero storage
and writes markdown to `literature/fulltexts/<citekey>.md`.

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

3. **Generate the full-text rendering** (only for papers you'll engage with deeply). In R:
   ```r
   markersync::sync_fulltext()
   ```
   This finds notes that lack a full-text version, locates each PDF in Zotero
   storage, sends it to the Marker server, and writes the converted markdown (plus
   extracted images) to `literature/fulltexts/<citekey>.md`. Use `force_ocr = TRUE`
   for scanned documents and the page-range options for long papers. The structured
   note's `[[<citekey>]]` link resolves to this file.

4. **Write your thoughts** in the `## Persistent notes` section of the structured note. These survive re-imports.

## What's in git

**Tracked:**
- `literature/notes/`, `literature/fulltexts/`, `literature/templates/`

**Ignored:**
- `.obsidian/` — all Obsidian config and workspace state
- PDFs (they live outside the repo in `~/research/_pdfs/`)
- `.env`

## Notes for collaborators

- The Marker server is restricted to campus IPs / VPN. If `markersync::sync_fulltext()` times out, check your VPN connection.
- Citekeys must be consistent across collaborators. Everyone uses Better BibTeX with the same citekey format, so the same paper resolves to the same filename in every clone.
- `markersync` is the supported path for full-text rendering: it has no Obsidian-plugin-version dependencies and works identically on every machine.
- PDFs are not in the repo by design. Each collaborator maintains their own Zotero library and PDF store; the repo contains only the *artifacts about* papers (notes, full-text renderings, templates).
