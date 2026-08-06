#!/usr/bin/env bash
# check-orphans.sh — Principle 2 enforcement
# Scans all scripts/ dirs, finds scripts not referenced by any SKILL.md.
# SAFE VERSION: uses -print0 to handle spaces in paths (SEC-03 fix).
set -euo pipefail

echo "=== Orphan Script Check ==="
echo ""

ORPHANS_FOUND=0

# Fix SEC-03: use -print0 + while read -d '' for space-safe iteration
while IFS= read -r -d '' script_dir; do
  for script in "$script_dir"/*; do
    [ -f "$script" ] || continue
    script_name=$(basename "$script")

    # Search for this script name in all SKILL.md files (also space-safe)
    refs=$(grep -rl --include="SKILL.md" -F "$script_name" . 2>/dev/null | wc -l)

    if [ "$refs" -eq 0 ]; then
      echo "  ⚠️  ORPHAN: $script (not referenced by any SKILL.md)"
      ORPHANS_FOUND=$((ORPHANS_FOUND + 1))
    else
      echo "  ✅ $script_name — referenced in $refs SKILL.md(s)"
    fi
  done
done < <(find . -type d -name "scripts" -not -path "./.git/*" -print0 2>/dev/null)

echo ""
if [ "$ORPHANS_FOUND" -gt 0 ]; then
  echo "❌ Found $ORPHANS_FOUND orphan script(s). Assign to a skill or mark deprecated."
  exit 1
else
  echo "✅ All scripts belong to a skill."
  exit 0
fi
