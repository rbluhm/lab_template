# Status Overview

Single entry point to the project's working memory. Every agent updates this
file at the end of a work session: add a one-line entry for any note created or
changed, and move items between **Open** and **Resolved** as their status
changes. Keep newest at the top of each list.

Each linked note lives in `notes/` as its own Markdown file. Naming convention:
`YYYY-MM-DD_short-slug.md`.

---

## Current state

> One short paragraph describing where the project stands right now. Update this
> whenever the high-level picture changes.

_Nothing yet — project just initialized._

---

## Open

Questions, tasks, and threads that are still in progress or unresolved.

| Note | Topic | Owner | Opened |
|------|-------|-------|--------|
| _none yet_ | | | |

---

## Resolved

Closed-out work. Keep the link so the reasoning stays discoverable.

| Note | Topic | Resolved |
|------|-------|----------|
| _none yet_ | | |

---

## How to add a note

1. Create `notes/YYYY-MM-DD_short-slug.md`.
2. Start it with a one-line summary, then the detail.
3. Add a row to **Open** here linking to it: `[short-slug](YYYY-MM-DD_short-slug.md)`.
4. When the thread is closed, move the row to **Resolved**.
