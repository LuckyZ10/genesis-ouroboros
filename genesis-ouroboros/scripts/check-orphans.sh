#!/usr/bin/env bash
# check-orphans.sh — Principle 2 enforcement
# Scans all scripts/ directories and finds scripts not referenced by any SKILL.md.
set -euo pipefail

echo "=== Orphan Script Check ==="
echo ""

ORPHANS_FOUND=0

for script_dir in $(find . -type d -name "scripts" -not -path "./.git/*" 2>/dev/null); do
  for script in "$script_dir"/*; do
    [ -f "$script" ] || continue
    script_name=$(basename "$script")

    # Search for this script name in all SKILL.md files
    refs=$(grep -rl "$script_name" --include="SKILL.md" . 2>/dev/null | wc -l)

    if [ "$refs" -eq 0 ]; then
      echo "  ⚠️  ORPHAN: $script (not referenced by any SKILL.md)"
      ORPHANS_FOUND=$((ORPHANS_FOUND + 1))
    else
      echo "  ✅ $script_name — referenced in $refs SKILL.md(s)"
    fi
  done
done

echo ""
if [ "$ORPHANS_FOUND" -gt 0 ]; then
  echo "❌ Found $ORPHANS_FOUND orphan script(s). Mark deprecated or assign to a skill."
  exit 1
else
  echo "✅ All scripts belong to a skill."
  exit 0
fi
