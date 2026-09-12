---
name: skills-sync
description: >
  Multi-agent skill-library sync (N-way, hub-and-spoke). Trigger when the user
  says "sync skills" / "同步技能库" / "同步skills", after you create or modify any
  SKILL.md or its companion files in one agent, at session start, or when the
  user suspects a skill is missing or stale on another agent. Keeps every
  installed AI agent's skill library consistent without manual copying, and
  wires a freshly installed agent into the sync network.
---

# skills-sync · N-way skill-library sync

## Model (v2, 2026-09-12 — any number of agents)

```
            canonical / hub (edit here by default)
           /              \
       leg1                leg2                leg3 ... (any count)
```

Two interchangeable tools ship in this repo:

| Tool | When to use |
|---|---|
| **`skill_sync` Python CLI** (this package) | full workflow: `discover` → `status` → `sync`; persistent registry at `~/.skill-sync/registry.json`; any number of libraries |
| **`legacy/sync_skills.ps1`** (PowerShell) | zero-Python Windows setups; legs configured in `scripts/sync_skills.json` next to the script; defaults to the three-library topology when the config is absent |

## Editing workflow

1. Edit a skill in ONE place only (your canonical/hub library).
2. Run the sync:

```bash
# Python CLI (after `skill-sync discover` once):
skill-sync sync --dry-run && skill-sync sync

# PowerShell legacy (Windows):
powershell -NoProfile -ExecutionPolicy Bypass -File "$env:USERPROFILE\scripts\sync_skills.ps1"
```

3. **Acceptance**: the run ends with `all libraries consistent` (CLI) or
   `CONFLICT CHECK: all ends consistent OK` (PowerShell).

## Reading the output (v2 semantics)

- `OVERWRITTEN -- both ends were edited; newer mtime won`
  The same skill file existed on two ends with different content and the
  newer mtime silently replaced the older edit (this is the Owner-confirmed
  rule). v1 ran this silently — v2 prints exactly which file on which end
  lost, so nothing disappears without a trace. Recover from backups if the
  older edit mattered, or pick a side explicitly with `sync --from <id>`.
- `CONFLICTS -- not overwritten, resolve by hand`
  Same mtime but different bytes (or deep-hash mismatch): the tool refuses to
  guess. Files are left untouched; resolve manually, then re-run.
- `status` before syncing shows the drift report (consistent / partial /
  divergent) without touching anything.

## Wiring in a new agent (the v2 point)

- Python CLI: `skill-sync add <path> --name "My Agent"` (or re-run
  `skill-sync discover`). Then optionally sync hub-style:
  `skill-sync sync --hub <id>` — the hub pairs with every other library,
  N-1 pairs instead of N*(N-1)/2.
- PowerShell: add one line to `scripts/sync_skills.json`:

```json
{
  "canonical": "~/.workbuddy/skills",
  "legs": ["~/.dsh/skills", "~/.codebuddy/skills", "~/.newagent/skills"],
  "autoDiscover": false
}
```

  `~` expands to the home directory; relative paths resolve against the
  script's folder. First sync never deletes: the new library's own skills are
  kept and merged by newer-mtime-wins.

## Sync rules (both tools)

- **Newer mtime wins**, bidirectional incremental (no content merging).
- **Never delete**: a skill that exists on only one end stays there (and
  propagates). There is deliberately no `--mirror`.
- **Never guess on ambiguity**: equal mtime + different bytes → reported,
  files untouched.
- **Client-managed metadata is skipped** (`*.bundled-hash`, `_user_meta.json`,
  `_bm_skillid_migration.json*`, `.DS_Store`, `__pycache__`), so each client
  keeps its own enable/disable state.
- **Junctions/symlinks are skipped** — agents sometimes junction their skill
  dirs at each other; following them duplicates writes.

## When to trigger

1. You created/modified/deleted any skill file in one agent — sync before
   finishing the turn.
2. The user says "sync skills" / "同步技能库".
3. A new agent was just installed and should join the sync network.
4. A skill seems missing or stale on one agent.
