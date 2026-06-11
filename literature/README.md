# literature/

The project's literature layer — the Zotero / Obsidian / `markersync` pipeline.
This is what lets agents read and cite the actual papers, not just their titles.

## Subfolders

- **`notes/`** — one Markdown note per paper. These are generated automatically
  by the **Obsidian + Zotero integration** when a paper is pulled into the
  library. Each note carries the citation metadata and a Zotero link to the PDF.
- **`fulltext/`** — Markdown full text (plus extracted images) of each paper.

## How it fills up

1. **Pull a paper in via Obsidian/Zotero.** The integration creates a note in
   `literature/notes/` containing the metadata and a link to the Zotero-stored
   PDF.
2. **Extract the full text with `markersync`.** The R package
   ([github.com/rbluhm/markersync](https://github.com/rbluhm/markersync)) syncs
   Zotero-managed PDFs to Markdown via a self-hosted Marker server. Running
   `sync_fulltext()` finds notes that lack a full-text version, locates the PDF
   in local Zotero storage, sends it to the Marker server, and writes the
   converted Markdown + images into `literature/fulltext/`.

That's the whole loop: a note appears automatically when the paper enters the
library, and `markersync` backfills the machine-readable full text on demand
(with OCR and page-range options for scanned or long documents).

## For agents

When you need to ground a claim in a specific paper, read its full text from
`literature/fulltext/` rather than guessing from the title. If the full text is
missing, note it — a human can run `sync_fulltext()` to fetch it.
