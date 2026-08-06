# Contributing to genesis-ouroboros

Thanks for your interest! This project follows its own constitution — contributions should pass the same enforcement we apply to generated agents.

## Quick Start

1. Fork & clone
2. `chmod +x genesis-ouroboros/scripts/*.sh` (scripts must be executable)
3. Make changes
4. Run checks: `bash genesis-ouroboros/scripts/check-contracts.sh && bash genesis-ouroboros/scripts/check-orphans.sh`
5. Submit PR

## Commit Message Convention

```
feat: <what you added>
fix: <what you fixed>
docs: <what you documented>
```

## SKILL.md Changes

SKILL.md is the constitution. Changes to it require:
1. Explain the rationale in your PR
2. Update `version:` in frontmatter (major for principle changes, minor for ring changes, patch for fixes)
3. Update CHANGELOG.md

## Reporting Issues

- Bugs: include steps to reproduce + expected vs actual
- Design suggestions: explain which principle/ring and why
- Security issues: see SECURITY.md or DM the maintainer
