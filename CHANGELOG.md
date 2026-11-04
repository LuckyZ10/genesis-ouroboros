# Changelog

All notable changes to genesis-ouroboros. Format: [Keep a Changelog](https://keepachangelog.com/), [SemVer](https://semver.org/).

## [4.0.0] — 2026-11-04

### Changed
- Reverted the skill to the original simple version (nine principles, Iron Law, deliverables, operating rules). v3.1.0 remains available in git history.

## [3.1.0] — 2026-08-06

### Security
- Fixed RCE via Python string interpolation in maybe-devour.sh (path with quote → code injection)
- Fixed state.json value injection into bash arithmetic (no schema validation)
- Fixed all scripts: `find` output now space-safe via `-print0` + `while read -d ''`
- Added Safety Gate: generated AGENTS.md is scanned for injection patterns before output
- Added Intent Purity Check: lessons.md entries must be descriptive, not imperative (anti prompt-injection)
- state.json now created with `umask 077` (restrictive permissions)
- Removed dead code in maybe-devour.sh (undefined variable reference)

### Prompt Engineering
- Deleted 7 `> 修正:` meta-annotation blocks — they contaminated the instruction stream
- Moved high-frequency operations (distillation ritual, devour trigger, contract flow) to TOP of SKILL.md
- Converted 9-row table to numbered list (LLM list-following > table-following)
- Gate B: changed from "read full lessons.md" to "scan headers, full-read only for matches" (token cost fix)
- `distill_mode: auto` no longer requires reporting rejected lessons (reduces over-rejection bias)
- Core directives use imperative + STOP markers for higher LLM compliance
- SKILL.md reduced from 10K to ~7K chars (within attention budget)

### Governance
- Added CONTRIBUTING.md
- Added CHANGELOG.md (this file)
- Added CODE_OF_CONDUCT.md (Contributor Covenant 2.1)
- Added .github/workflows/ci.yml (dogfooding: runs check-contracts.sh + check-orphans.sh on PR)
- Added version field to SKILL.md frontmatter
- Added Status: Experimental badge to README
- Added Related Projects section (distinguishes from eLafo/ouroboros)
- Made scripts executable (chmod +x) — previously 644, enforcement was broken on fresh clone
- Synced openai.yaml with SKILL.md frontmatter

## [3.0.0] — 2026-08-06

### Added — Three Rings enforcement mechanism
- Ring 1: Gated Distillation (Behavior Gate + Show-Comparison Gate)
- Ring 2: Devour Loop (merge/prune/repair/sweep)
- Ring 3: Conflict Arbitration (pipeline integrity > backward compat > distillation > new features)
- Three enforcement scripts: maybe-devour.sh, check-orphans.sh, check-contracts.sh
- `.ouroboros/state.json` for devour loop counting

### Changed
- Principle 3: "Every Interaction Compounds" → "Every Interaction Evaluates Compounding" (resolved logical contradiction with Ring 1 gates)
- Principle 1: "timeless" → "constitutional-level" (Ring 2 can prune, nothing is truly timeless)
- Naming Iron Law: demoted from hard gate to strong recommendation (was a category error — aesthetic criteria can't be hard gates)

## [2.0.0] — 2026-08-06

### Added
- Three Rings section (initial draft, appended to existing Nine Principles)
- Bilingual consistency pass (README + SKILL.md)

## [1.0.0] — 2026-08-06

### Initial release
- Nine Constitutional Principles
- Three-Step Genesis Ritual
- Naming Iron Law
- Bilingual (中/EN) SKILL.md
- Codex + Claude Code compatible
