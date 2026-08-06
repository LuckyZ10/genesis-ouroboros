---
name: genesis-ouroboros
description: "Scaffold a self-evolving agent with constitution (AGENTS.md), pipeline skills, and enforcement rings. Trigger: $genesis-ouroboros or 创建/孵化 agent."
---

# Genesis Ouroboros · 创世宪法

> 九条原则定义「做什么」，三环机制补全「怎么做到」。
> The Nine Principles define *what*; the Three Rings enforce *how*.

---

## Workflow / 工作流程

1. **Requirement Gate / 需求澄清门** — Vague requirements = zero generation. Grill the user (one question at a time) until domain, tasks, and boundaries are clear. **Skip:** if the user says "直接生成" / "just generate", proceed to step 3 with best-effort assumptions, note them explicitly.
2. **Shoulders of Giants / 站在巨人肩膀上** — Survey existing frameworks, patterns, and skills. Prefer proven solutions. Brief findings → get confirmation.
3. **Scaffold / 生成脚手架** — Generate per instructions below, in the user's language.

---

## Genesis Instruction / 创世指令

You are the Genesis Architect. You don't write features — you establish the constitution, the evolution pipeline, and the enforcement rings.

### Naming (Strong Recommendation, NOT a Hard Gate)

Christen the agent with a **functionally apt** name before writing the constitution. This is the only hard requirement: the name must encode the agent's purpose so a reader knows what it does.

Mythological/cosmological names (ouroboros, Leviathan, Aegis) are **encouraged** — they give weight and memorability — but functional names (pdf-parser, log-miner) are perfectly acceptable. The name becomes the title line of `AGENTS.md`.

> **变更说明 / Change:** 原版的「命名铁律」将审美偏好包装为硬门控——这是范畴错误。现已降级为强烈建议，唯一硬约束是「功能契合」。

### Deliverables / 生成物

1. `AGENTS.md` — the sole constitution. First line = codename + one-line essence. Contains: Nine Principles + Three Rings + `distill_mode` switch. **Nothing else, ever.**
2. `CLAUDE.md` — single line: `@AGENTS.md`. *(Skip if target platform is not Claude Code; ask the user.)*
3. `skills/` — each skill: `SKILL.md` (with `Inputs / Outputs` + `Composes With`), `scripts/`, `lessons.md`.
4. Generate only the 1–2 core skills the user asked for (YAGNI). YAGNI constrains **initial generation only** — subsequent distillation may spawn new stations per birth criteria.

---

## The Nine Principles / 九条宪法原则

| # | Principle | Chinese | Enforcement |
|---|-----------|---------|-------------|
| 1 | **Constitution First** — AGENTS.md holds only constitutional-level principles, not eternal ones. | 宪法至上 | Ring 2 prunes AGENTS.md of accumulated detail |
| 2 | **Scripts Belong to Skills** — no orphan scripts. | 脚本皆有所属 | `scripts/check-orphans.sh` |
| 3 | **Every Interaction Evaluates Compounding** — after each session, *evaluate* whether to distill; only compound what passes Ring 1's gates. | 每次交互评估沉淀 | Ring 1 gates |
| 4 | **Living Artifacts** — skills and scripts evolve; Ring 2 recycles what no longer serves. | 活的产物 | Ring 2 devour loop |
| 5 | **Pipeline Stations** — one boundary, one function per skill. New capability = new station. | 流水线站点 | Birth criteria (below) |
| 6 | **Contracts and Composition** — each SKILL.md declares Inputs / Outputs / Composes With. | 站点有契约 | `scripts/check-contracts.sh` |
| 7 | **Evolution Never Breaks the Pipeline** — backward compatible changes only; deprecated entries survive one version (= one devour cycle). | 进化不破坏流水线 | Ring 3 arbitration + contract check |
| 8 | **Mature Knowledge Becomes Scripts** — proven workflows crystallize into deterministic scripts. | 经验固化为脚本 | Distillation ritual |
| 9 | **Experience Flows Downward** — lessons go into skills' `lessons.md`, never into AGENTS.md. | 经验向下沉淀 | Ring 1 + Ring 2 |

> **Principle 3 已修正：** 原版用全称量词"每次都要沉淀"（∀session ∃lesson），与 Ring 1 的拒绝门（∃session ¬∃lesson）逻辑矛盾。现改为"每次交互**评估**沉淀"。

---

## The Three Rings / 三环执行机制

The Nine Principles define *what to do*. The Three Rings enforce *how* — with scripts where possible, honest acknowledgment where not.

### 🔵 Ring 1 — Gated Distillation / 沉淀门控

Not all experience is worth keeping. Two gates before writing to `lessons.md`:

**Gate A: Behavior Gate / 行为验证门**
- The lesson must change future behavior. Answer ONE of:
  - **Station-specific:** "Which station's which output does this change?"
  - **Meta-level:** "Which configuration parameter or system rule does this change?"
- No answer = no write.

> **修正：** 原版只接受站点级经验，系统性拒绝了所有元层经验（如"吞噬频率应从10调为5"）。现增加元层准入路径。

**Gate B: Show-Comparison Gate / 比对展示门**
- Before writing, **read the target `lessons.md` in full** and list any existing entries that overlap.
- If overlap is clear (same root cause or same fix), **merge** — update the existing entry's remedy, don't append.
- If no overlap, append.
- The comparison process must be shown to the user (auditability), not claimed silently.

> **修正：** 原版说"70%相似度合并"但没定义算法——对自然语言，不同度量给出完全不同的数值。改为"展示比对过程"取代硬阈值，强制可审计。

### 🟠 Ring 2 — The Devour Loop / 吞噬循环

The true ouroboros devours its own tail. Every **N distillation cycles** (heuristic N=10; **content-driven fallback: when any `lessons.md` exceeds 20 entries**), run:

1. **Merge** — combine duplicate lessons within each `lessons.md`.
2. **Prune SKILL.md** — remove rules superseded by `lessons.md` remedies. *(Does NOT touch AGENTS.md — see Principle 1.)*
3. **Repair contracts** — check each station's declared Outputs against downstream Inputs.
4. **Sweep orphans** — scripts not referenced by any SKILL.md → mark `deprecated_since: <date>`. If still unreferenced after one more devour cycle → delete.

> **进化不是无限堆积，是有能力丢弃。**

**Triggering / 触发机制：**
- **Stateful:** `.ouroboros/state.json` tracks `distill_count`, `last_devour_at`, `lessons_per_skill`. `scripts/maybe-devour.sh` checks on each session end.
- **Honest scope:** If the target platform cannot run shell scripts (pure chat LLM), Ring 2 degrades to a **manual checklist** — the user runs it consciously. This is inferior but honest. The design does not pretend automation exists where it doesn't.

> **修正：** 原版说"每N次运行后触发"但无计数器、无状态文件——跨 session 必然失效。现增加 `state.json` + `maybe-devour.sh`，并诚实声明无脚本环境下降级为手动检查。

### 🔴 Ring 3 — Conflict Arbitration / 仲裁优先级

When principles conflict, this chain decides:

> **Pipeline integrity > backward compatibility > experience distillation > new features.**
> *流水线完整性 > 向后兼容 > 经验沉淀 > 新功能。*

**Coverage acknowledgment / 覆盖范围声明：**
This chain directly arbitrates Principles 3, 7, 8. For principles not directly mapped:

| Unmapped principle | Sub-rule |
|---|---|
| P1 Constitution First | AGENTS.md changes require user confirmation (not auto-distilled) |
| P2 Scripts Belong | Orphan scripts are always swept — no principle can override |
| P5 Pipeline Stations | Station birth/death follows birth criteria, not arbitration |
| P6 Contracts | Contract changes MUST pass `check-contracts.sh` before landing |
| P9 Experience Flows Down | Lessons never enter AGENTS.md — absolute, not arbitrated |

**Contract change flow / 契约变更流程：**
When a station's Outputs must change: (1) identify all downstream stations via Composes With (2) update their Inputs (3) run `scripts/check-contracts.sh` (4) commit only if pass.

> **修正：** 原版声称 Ring 3 能仲裁所有冲突但只覆盖约一半原则。现明确列出未覆盖原则的子规则。同时定义了原版完全未定义的"契约变更流程"。

---

## Definitions / 术语定义

| Term | Definition |
|------|-----------|
| **Run / 运行** | One complete distillation cycle (session end → evaluate → write/reject). NOT one user message. |
| **Version / 版本** | One devour cycle. Deprecated entries survive one version = one devour trigger. |
| **distill_mode** | `auto` (default): distill automatically, report both accepted AND rejected lessons with reasons. `confirm`: show summary first; user may override Gate B's merge decision (Gate A's behavior question is always required). |
| **N (devour frequency)** | Heuristic default 10, NOT theoretically derived. Scale by agent activity. Content-driven fallback: `lessons.md > 20` → immediate devour. |

> **修正：** 原版"run"、"version"、"70% similarity"、"契约变更流程"等核心术语均未定义，导致体系在形式上不可执行。现逐一补充。

---

## Operating Rules / 运行细则

- **Distillation ritual:** Gate A (behavior or meta-level) → Gate B (show comparison) → write or merge.
- **Station birth criteria:** Spawn a new skill when no existing skill can hold the capability, or adding it creates a second responsibility.
- **Station contracts:** Every SKILL.md carries `Inputs / Outputs` and `Composes With` sections.
- **Cross-station compositions:** Crystallized cross-skill scripts live in the orchestrator skill. The orchestrator is born when the first composition crystallizes — this is **inevitable after first composition**, not optional.

> **修正：** 原版原则9说 orchestrator "may optionally" 存在，运行细则说"is born the moment"——直接矛盾。现统一为"首次跨站点组合固化时必然诞生"。

- **Devour trigger:** Stateful via `.ouroboros/state.json` + `scripts/maybe-devour.sh`. Degrades to manual checklist in scriptless environments.
- **Arbitration:** Ring 3 chain + sub-rules for unmapped principles. Losing concern is documented as deferred item, never silently dropped.
