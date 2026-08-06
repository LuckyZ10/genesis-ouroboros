#!/usr/bin/env bash
# check-contracts.sh — Principle 6 enforcement
# Verifies station contracts: Inputs/Outputs/Composes With presence.
# SAFE VERSION: space-safe iteration (SEC-03 fix).
set -euo pipefail

echo "=== Contract Consistency Check ==="
echo ""

DRIFTS_FOUND=0

# Fix SEC-03: use -print0 + while read -d ''
while IFS= read -r -d '' skill_md; do
  # Check for Inputs and Outputs sections
  has_inputs=$(grep -ciE '^[#>]*\s*inputs' "$skill_md" 2>/dev/null || echo 0)
  has_outputs=$(grep -ciE '^[#>]*\s*outputs' "$skill_md" 2>/dev/null || echo 0)

  if [ "$has_inputs" -eq 0 ] && [ "$has_outputs" -eq 0 ]; then
    continue  # Not a pipeline station skill
  fi

  if [ "$has_inputs" -eq 0 ]; then
    echo "  ⚠️  $skill_md declares Outputs but no Inputs section"
    DRIFTS_FOUND=$((DRIFTS_FOUND + 1))
  elif [ "$has_outputs" -eq 0 ]; then
    echo "  ⚠️  $skill_md declares Inputs but no Outputs section"
    DRIFTS_FOUND=$((DRIFTS_FOUND + 1))
  else
    echo "  ✅ $skill_md — has Inputs and Outputs"
  fi

  has_composes=$(grep -c "Composes With" "$skill_md" 2>/dev/null || echo 0)
  if [ "$has_composes" -eq 0 ]; then
    echo "     💡 No Composes With section (recommended)"
  fi
done < <(find . -name "SKILL.md" -not -path "./.git/*" -print0 2>/dev/null)

echo ""
if [ "$DRIFTS_FOUND" -gt 0 ]; then
  echo "❌ Found $DRIFTS_FOUND contract drift(s). Fix before committing."
  exit 1
else
  echo "✅ All station contracts look consistent."
  exit 0
fi
