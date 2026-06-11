# Replication files for ...

## Folder structure

This diagram shows the full directory structure after calling setup.sh on Linux or setup_win.bat on Windows so far, some folders (data, tmp and sandbox) are not synced on GitHub, see invisible .gitignore file: 

    .
    ├── code
    │   ├── analyze
    │   ├── build
    │   ├── process
    │   └── put_master_here
    ├── data
    │   ├── final
    │   │   └── restricted
    │   └── intermediate
    │       └── restricted
    ├── literature
    │   ├── fulltext
    │   └── notes
    ├── notes
    │   └── STATUS_OVERVIEW.md
    ├── output
    │   ├── figures
    │   │   └── appendix
    │   └── tables
    │       └── appendix
    ├── sandbox            (git-ignored)
    ├── README.md
    ├── setup.sh
    ├── setup_win.bat
    └── tmp
        └── restricted

All the input data should be in the Dropbox or shared folder under `/../data/input` and should be separated by  `/../data/input/restricted` and `/../data/input/public`.

### Data folders

The whole `data/` tree is git-ignored — none of it is synced to GitHub. The three
stages differ in where they live and what they hold:

- **`data/input`** — the *raw* inputs. These live **outside the repo** (Dropbox /
  shared folder), separated into `data/input/restricted` and
  `data/input/public`. Treat them as read-only.
- **`data/intermediate`** — lives **inside the repo but is not tracked**. Holds
  every non-temporary file created along the way (cleaned, merged, reshaped
  data). Genuinely throwaway files belong in `tmp/`, not here.
- **`data/final`** — lives **inside the repo but is not tracked**. Holds the
  analysis-ready datasets — i.e. exactly the data that the `code/analyze/`
  scripts read from.

### Restricted data

Each data stage (and `tmp/`) has a `restricted/` subfolder:
`data/input/restricted`, `data/intermediate/restricted`,
`data/final/restricted`, and `tmp/restricted`. Anything that is **not freely
shareable** goes there — confidential, licensed, or otherwise access-controlled
inputs (signed-DUA microdata, personally identifiable information, proprietary
vendor data) and **any intermediate or final file derived from them**. The plain
(non-`restricted`) folders hold only public / shareable data.

Rules of thumb:

- If an input arrived under `data/input/restricted`, every product built from it
  stays in a `restricted/` folder through `intermediate` and `final`. Don't let
  restricted data leak into a public folder.
- When in doubt, treat it as restricted.
- The whole `data/` tree is git-ignored regardless, but keeping restricted
  material in its own subfolder makes it easy to share the public subset and to
  apply different access controls on the shared/Dropbox copy.

## Working with agents

This template is set up for a workflow where AI agents do exploratory work and
humans decide what becomes part of the project. Three folders carry that logic.

### `sandbox/` — scratch space (git-ignored)

Agents work here freely: throwaway scripts, intermediate dumps, draft figures,
notes-to-self. Nothing in `sandbox/` is tracked by git. A file only leaves the
sandbox when a **human says "promote it"** — at which point it is moved and
cleaned up into its real home:

- reusable build/cleaning code  → `code/build/`
- processing / transformation   → `code/process/`
- analysis & results code       → `code/analyze/`
- a written-up finding or memo   → `notes/`

The rule of thumb: if it isn't promoted, it doesn't count. Don't keep anything
in `sandbox/` that you care about.

Agents may also work freely in `tmp/` (also git-ignored) for genuinely
temporary, throwaway files — the difference is intent: `sandbox/` is for work
that might be worth promoting, `tmp/` is for files you never expect to keep.

### `notes/` — working memory (tracked)

Whenever an agent finishes a piece of work, it **summarizes that work as a note**
here (one Markdown file per topic, named `YYYY-MM-DD_short-slug.md`).
[`notes/STATUS_OVERVIEW.md`](notes/STATUS_OVERVIEW.md) is the index: it describes
the current state of the project and links every note, categorized into **Open**
and **Resolved**. Agents update the overview every session.

### `literature/` — the reading layer (tracked)

The Zotero / Obsidian / `markersync` pipeline that gives agents the actual text
of the papers:

- `literature/notes/` — one note per paper, generated automatically by the
  **Obsidian + Zotero** integration when a paper is pulled into the library
  (metadata + a Zotero link to the PDF).
- `literature/fulltext/` — Markdown full text + extracted images of each paper.
  The R package [`markersync`](https://github.com/rbluhm/markersync) syncs
  Zotero-managed PDFs to Markdown via a self-hosted Marker server: running
  `sync_fulltext()` finds notes lacking full text, grabs the PDF from Zotero
  storage, and writes the converted Markdown here.

See [`literature/README.md`](literature/README.md) for the full loop.
