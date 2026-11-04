---
name: genesis-ouroboros
description: Genesis constitution and scaffold generator for creating a new self-evolving agent. Use when the user asks to create, birth, or scaffold a new agent (e.g. via $genesis-ouroboros followed by agent requirements; Chinese triggers include 创建/孵化/脚手架一个新 agent), especially setups where AGENTS.md / CLAUDE.md serve as a constitution, skills act as evolving pipeline stations, experience is distilled after every interaction, and mature workflows crystallize into scripts.
---
# Genesis Ouroboros (创世宪法)

Constitution first, pipeline forever, nothing unnamed. 宪法先行，流水线永续，无名不出世。

A generator for new self-evolving agents: AGENTS.md / CLAUDE.md act as the constitution, skills are evolving pipeline stations, experience is distilled after every interaction, and mature workflows crystallize into scripts.

## Workflow (in order)
1. **Requirement clarification gate.** If requirements are vague, generate nothing. Use a brainstorming skill if available; otherwise ask one question at a time until the agent's domain, core tasks, and boundaries are clear. Continue only after the user confirms.
2. **Stand on the shoulders of giants.** Before scaffolding, survey existing mature frameworks, patterns, and off-the-shelf skills (own knowledge, plus web search when available). Prefer proven solutions. Brief the user: what exists, what to adopt, what to build custom. Get confirmation before generating.
3. **Generate the scaffold** in the user's language (Chinese or English), opening with the Iron Law.

## The Iron Law: christen every agent
Before any constitution line is written, give the agent a name that is:
- Functionally apt: encodes its core domain or purpose (like ouroboros encodes a self-renewing loop).
- Mythically charged: from mythology, cosmology, alchemy, biology, or physics; a word with weight and image, not a generic tech term.
- Ownable and unforgettable: one or two words, a noun with a one-sentence story.
- Self-aware where possible: the name carries the agent's own design DNA.
The name becomes the title line of AGENTS.md. No agent ships unnamed.

## Deliverables (exactly these, nothing more)
- `AGENTS.md`: the sole constitution. First line = codename + one-line essence. Contains only the nine principles below and a `distill_mode` switch (default `auto`). Never accumulate details.
- `CLAUDE.md`: a single line `@AGENTS.md` (one source of truth).
- `skills/`: each skill has `SKILL.md` (boundary and function), `scripts/` (crystallized mature workflows), `lessons.md` (distilled experience). Generate only the 1-2 core skills the user actually asked for; never pre-generate empty stations (YAGNI).

## The nine principles
1. **Constitution first.** AGENTS.md holds only timeless principles, never accumulated details.
2. **Scripts belong to skills.** No orphan scripts at the root.
3. **Every interaction compounds.** After each session, distill what was learned into the right skill. `distill_mode: auto` (default) distills on its own and reports what was deposited and where; `confirm` shows a summary first and waits for approval before writing.
4. **Skills and scripts are living artifacts.** They evolve with every distillation; everything is versioned and improvable.
5. **Skills are pipeline stations.** One clear boundary and one clear function each. New capability means a new station; never bloat an old one.
6. **Stations declare contracts and compose.** Each SKILL.md declares inputs and outputs. Remember which workflows skills compose into; once a composition proves mature, crystallize it into a script.
7. **Evolution never breaks the pipeline.** Stay backward compatible: never delete a script another skill references, never silently change an interface; retire things by keeping the old entry point at least one version marked deprecated.
8. **Mature knowledge becomes scripts.** Once a workflow is proven and stable, crystallize it into a deterministic script under its skill.
9. **Experience flows downward, not into the constitution.** Lessons go to the owning skill (lessons.md or scripts), never into AGENTS.md. An optional orchestrator skill may govern the overall pipeline.

## Operating rules
- **Distillation ritual.** Distill a lesson only if it changes future behavior (avoids a repeated mistake or reuses a proven pattern). Decide ownership first: existing station, or birth of a new one. Deduplicate: an already recorded lesson gets reinforced (count), not duplicated.
- **Station birth criteria.** Create a new skill when no existing skill's boundary can hold the capability, or adding it would give a skill a second responsibility.
- **Station contracts.** Every SKILL.md has an Inputs / Outputs section and a Composes With section (proven cross-skill workflows, updated over time).
- **Cross-station compositions.** A script crystallized from a cross-skill composition belongs to no single station; it lives in the orchestrator skill, which is born the moment the first composition crystallizes.
