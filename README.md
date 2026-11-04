# genesis-ouroboros

> A skill that births self-evolving agents — constitution first, pipeline forever, nothing unnamed.
> 宪法先行，流水线永续，无名不出世。

> 🐍 https://github.com/LuckyZ10/genesis-ouroboros  ·  `git clone https://github.com/LuckyZ10/genesis-ouroboros.git`

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Status: Experimental](https://img.shields.io/badge/Status-Experimental-orange.svg)]()

---

## Quick Start

```bash
# 1. Clone
git clone https://github.com/LuckyZ10/genesis-ouroboros.git

# 2. Copy to your skills directory
cp -r genesis-ouroboros/genesis-ouroboros ~/.codex/skills/      # Codex
# or
cp -r genesis-ouroboros/genesis-ouroboros ~/.claude/skills/     # Claude Code

# 3. Use
$genesis-ouroboros 帮我创建一个数据分析领域的 agent
```

**What you get:** an `AGENTS.md` (constitution), `CLAUDE.md` (pointer), and `skills/` (pipeline stations) — a complete agent scaffold that evolves through use.

---

## What Problem Does This Solve?

After creating many agents, the same failure modes repeat:
- 📜 Constitution files bloat into unreadable graveyards
- 🗂️ Orphan scripts everywhere, nobody remembers what does what
- 💨 Hard-earned experience evaporates at session end
- 💥 New features break old ones

**genesis-ouroboros** distills these lessons into **nine principles** and **operating rules** — so every new agent is born with a constitution instead of chaos.

---

## How It Works

### Three-step ritual

1. **Requirement Clarification Gate** — Vague requirements, zero generation. One question at a time until the agent's domain, core tasks, and boundaries are clear. Continue only after the user confirms.
2. **Stand on the Shoulders of Giants** — Survey proven frameworks, patterns, and off-the-shelf skills before inventing. Brief what exists, what to adopt, and what to build custom. Get confirmation before generating.
3. **Scaffold** — Generate in the user's language, opening with the Iron Law.

### Iron Law of naming

Before any constitution line is written, christen the agent: functionally apt, mythically charged, ownable, and self-aware where possible. The name is the title line of `AGENTS.md`. No agent ships unnamed. 无名不出世。

### Deliverables

Exactly these, nothing more:

- `AGENTS.md` — the sole constitution. First line is the codename plus a one-line essence. Contains only the nine principles and a `distill_mode` switch (default `auto`).
- `CLAUDE.md` — a single line, `@AGENTS.md`.
- `skills/` — only the 1–2 core skills the user asked for. Each has `SKILL.md` (boundary and function), `scripts/` (crystallized workflows), and `lessons.md` (distilled experience).

### Nine principles

1. **Constitution first.** Timeless principles only; never accumulated details.
2. **Scripts belong to skills.** No orphan scripts at the root.
3. **Every interaction compounds.** Distill what was learned into the right skill (`distill_mode`: `auto` or `confirm`).
4. **Skills and scripts are living artifacts.** They evolve with every distillation.
5. **Skills are pipeline stations.** One boundary, one function. New capability means a new station.
6. **Stations declare contracts and compose.** Inputs and outputs; mature compositions crystallize into scripts.
7. **Evolution never breaks the pipeline.** Stay backward compatible.
8. **Mature knowledge becomes scripts.** Proven workflows become deterministic scripts under their skill.
9. **Experience flows downward.** Lessons go to the owning skill, never into `AGENTS.md`.

### Operating rules

- Distill a lesson only if it changes future behavior. Decide ownership first, and reinforce an existing lesson instead of duplicating it.
- Birth a new station when no existing skill's boundary can hold the capability.
- Every `SKILL.md` has Inputs / Outputs and Composes With.
- A script crystallized from a cross-skill composition lives in the orchestrator skill, born when the first composition crystallizes.

Full details: [SKILL.md](./genesis-ouroboros/SKILL.md)

---

## Repository Layout

```
genesis-ouroboros/
├── README.md
├── LICENSE                         # MIT
├── CONTRIBUTING.md                 # How to contribute
├── CHANGELOG.md                    # Version history
├── CODE_OF_CONDUCT.md              # Contributor Covenant 2.1
└── genesis-ouroboros/              # The installable skill
    ├── SKILL.md                    # Nine principles, Iron Law, deliverables, operating rules
    └── agents/openai.yaml          # Codex UI metadata
```

## Status

**Experimental.** Single maintainer, no test suite yet, breaking changes likely. Feedback welcome via Issues.

## Related Projects

- [eLafo/ouroboros](https://github.com/eLafo/ouroboros) — Artifact tooling for Claude Code (skill/command/hook builders). genesis-ouroboros focuses on *constitutional scaffolding* (`AGENTS.md`, `CLAUDE.md`, and pipeline skills), not artifact generation.

## License

MIT — see [LICENSE](./LICENSE)
