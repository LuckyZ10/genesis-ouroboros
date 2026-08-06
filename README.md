# genesis-ouroboros

> A skill that births self-evolving agents — with a constitution, a pipeline, and the teeth to enforce both.
> 一个会下蛋的 skill：它不生成功能，它生下会自我进化的 agent。

> 🐍 https://github.com/LuckyZ10/genesis-ouroboros  ·  `git clone https://github.com/LuckyZ10/genesis-ouroboros.git`

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

**genesis-ouroboros** distills these lessons into **Nine Principles** (what to do) and **Three Rings** (how to enforce it) — so every new agent is born with structure instead of chaos.

---

## How It Works

### Three-Step Ritual

1. **Requirement Gate** — Vague requirements, zero generation.
2. **Shoulders of Giants** — Survey proven solutions before inventing.
3. **Scaffold** — Generate `AGENTS.md` + `skills/` with a function-fitting name.

### Nine Principles → Three Rings

| Ring | Name | Enforces |
|------|------|----------|
| 🔵 | **Gated Distillation** | Lessons pass behavior + comparison gates before writing |
| 🟠 | **Devour Loop** | Periodically merge duplicates, prune stale rules, sweep orphans |
| 🔴 | **Conflict Arbitration** | Pipeline integrity > backward compat > distillation > new features |

> **进化不是无限堆积，是有能力丢弃。**
> *Evolution isn't infinite accumulation — it's the capacity to discard.*

Full details: [SKILL.md](./genesis-ouroboros/SKILL.md)

---

## Origin Story

This skill was born from a handwritten list of hard-earned lessons. The name **ouroboros** — the serpent devouring and regenerating itself — captures the soul: every interaction feeds the agent's evolution, and the devour loop recycles what no longer serves it.

---

## Repository Layout

```
genesis-ouroboros/
├── README.md
├── LICENSE                         # MIT
├── assets/                         # README illustrations
└── genesis-ouroboros/              # The installable skill
    ├── SKILL.md                    # Constitution + rings + operating rules
    ├── agents/openai.yaml          # Codex UI metadata
    └── scripts/                    # Enforcement teeth
        ├── maybe-devour.sh         # Ring 2 trigger
        ├── check-orphans.sh        # Principle 2 enforcement
        └── check-contracts.sh      # Principle 6 enforcement
```

## License

MIT
