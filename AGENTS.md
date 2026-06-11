# Agent rules

Short version. Full detail in [README.md](README.md).

## Workspace
- Scratch goes in `sandbox/` (git-ignored). Throwaway files go in `tmp/`.
- Nothing leaves `sandbox/` until a human says **"promote it"** → then move it to
  `code/{build,process,analyze}/` or `notes/`.
- Summarize finished work as a note in `notes/`, and update `notes/STATUS_OVERVIEW.md`
  (link it under Open or Resolved).
- Read papers from `literature/fulltext/`; don't guess from titles.

## Data
- `data/input` = raw, read-only, lives outside the repo. `data/intermediate` =
  in-between files. `data/final` = what `code/analyze/` reads. None are tracked.
- Restricted inputs and everything derived from them stay in `restricted/`. When
  in doubt, treat as restricted.

## How to write code
- **Simplest thing that solves the problem.** Nothing speculative — no features,
  flexibility, or config that wasn't asked for.
- **No abstractions or helpers for single-use code.** Generalize only when there
  is a real second caller, not in anticipation of one.
- **Optimize for human readability.** Clear names, obvious control flow; match the
  surrounding style.
- **Surgical changes.** Touch only what the task needs; don't refactor or reformat
  adjacent code that isn't broken.
- **Surface uncertainty.** State assumptions; if something is ambiguous, ask
  instead of silently picking.
