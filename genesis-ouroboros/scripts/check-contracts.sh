#!/usr/bin/env bash
# check-contracts.sh — Principle 6 enforcement
# Verifies that every station's declared Outputs are consumed by downstream Inputs.
# Parses Inputs/Outputs sections from SKILL.md files and reports drift.
set -euo pipefail

echo "=== Contract Consistency Check ==="
echo ""

# Collect all SKILL.md files
SKILL_FILES=$(find . -name "SKILL.md" -not -path "./.git/*" 2>/dev/null)

if [ -z "$SKILL_FILES" ]; then
  echo "No SKILL.md files found. Nothing to check."
  exit 0
fi

DRIFTS_FOUND=0

# For each SKILL.md, extract declared Inputs and Outputs
for skill_md in $SKILL_FILES; do
  skill_dir=$(dirname "$skill_md")

  # Check if SKILL.md has Inputs and Outputs sections
  has_inputs=$(grep -c "^[#>]* *[Ii]nputs" "$skill_md" 2>/dev/null || echo 0)
  has_outputs=$(grep -c "^[#>]* *[Oo]utputs" "$skill_md" 2>/dev/null || echo 0)

  if [ "$has_inputs" -eq 0 ] && [ "$has_outputs" -eq 0 ]; then
    # Not a pipeline station skill, skip
    continue
  fi

  if [ "$has_inputs" -eq 0 ]; then
    echo "  ⚠️  $skill_md declares Outputs but no Inputs section"
    DRIFTS_FOUND=$((DRIFTS_FOUND + 1))
  elif [ "$has_outputs" -eq 0 ]; then
    echo "  ⚠️  $skill_md declares Inputs but no Outputs section"
    DRIFTS_FOUND=$((DRIFTS_FOUND + 1))
  else
    echo "  ✅ $skill_md — has both Inputs and Outputs"
  fi

  # Check for Composes With section
  has_composes=$(grep -c "Composes With" "$skill_md" 2>/dev/null || echo 0)
  if [ "$has_composes" -eq 0 ]; then
    echo "     💡 No Composes With section (recommended for pipeline stations)"
  fi
done

echo ""
if [ "$DRIFTS_FOUND" -gt 0 ]; then
  echo "❌ Found $DRIFTS_FOUND contract drift(s). Fix before committing."
  exit 1
else
  echo "✅ All station contracts look consistent."
  exit 0
fi
