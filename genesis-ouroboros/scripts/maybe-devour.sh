#!/usr/bin/env bash
# maybe-devour.sh — Ring 2 trigger
# Checks .ouroboros/state.json and triggers devour loop if threshold reached.
# SAFE VERSION: uses jq + stdin (no variable interpolation into Python), 
# validates state.json schema, handles spaces in paths.
set -euo pipefail

STATE_DIR="${AGENT_HOME:-.}/.ouroboros"
STATE_FILE="$STATE_DIR/state.json"
N_DEFAULT=10
LESSONS_HARD_LIMIT=20

# Initialize state if missing (restrictive permissions)
if [ ! -f "$STATE_FILE" ]; then
  mkdir -p "$STATE_DIR"
  ( umask 077; cat > "$STATE_FILE" << 'EOF'
{
  "distill_count": 0,
  "last_devour_at": null,
  "devour_n": 10
}
EOF
  )
  echo "[devour] Initialized $STATE_FILE"
fi

# Read state values via jq (no Python interpolation — SEC-01/02 fix)
# Validate schema: distill_count must be integer 0..999999
DISTILL_COUNT=$(jq -r '.distill_count | if type == "number" and . >= 0 and . < 1000000 then . else "INVALID" end' "$STATE_FILE")
DEVOUR_N=$(jq -r '.devour_n | if type == "number" and . >= 1 and . < 1000 then . else '"$N_DEFAULT"' end' "$STATE_FILE")

if [ "$DISTILL_COUNT" = "INVALID" ] || ! [[ "$DISTILL_COUNT" =~ ^[0-9]+$ ]]; then
  echo "[devour] ERROR: corrupt state.json — distill_count is not a valid integer. Resetting."
  DISTILL_COUNT=0
fi
if ! [[ "$DEVOUR_N" =~ ^[0-9]+$ ]]; then
  DEVOUR_N=$N_DEFAULT
fi

NEW_COUNT=$((DISTILL_COUNT + 1))

# Check content-driven trigger: any lessons.md exceeds hard limit?
# Fix SEC-03: use -print0 + while read -d '' to handle spaces in paths
OVERFLOW=0
while IFS= read -r -d '' lf; do
  # Count lesson headers (lines starting with ###)
  COUNT=$(grep -c "^### " "$lf" 2>/dev/null || echo 0)
  if [ "$COUNT" -gt "$LESSONS_HARD_LIMIT" ]; then
    echo "[devour] WARNING: $lf has $COUNT entries (limit: $LESSONS_HARD_LIMIT)"
    OVERFLOW=1
  fi
done < <(find . -name "lessons.md" -not -path "./.git/*" -not -path "./.ouroboros/*" -print0 2>/dev/null)

# Decide whether to trigger
NEEDS_DEVOUR=0
REASON=""

if [ "$NEW_COUNT" -ge "$DEVOUR_N" ]; then
  NEEDS_DEVOUR=1
  REASON="distill_count reached N=$DEVOUR_N"
elif [ "$OVERFLOW" -eq 1 ]; then
  NEEDS_DEVOUR=1
  REASON="one or more lessons.md exceeded $LESSONS_HARD_LIMIT entries"
fi

# Update state via jq (no variable interpolation — SEC-01/02 fix)
jq --argjson count "$NEW_COUNT" '.distill_count = $count' "$STATE_FILE" > "$STATE_FILE.tmp" && mv "$STATE_FILE.tmp" "$STATE_FILE"

if [ "$NEEDS_DEVOUR" -eq 1 ]; then
  echo "[devour] TRIGGER: $REASON"
  echo "[devour] Run the devour checklist:"
  echo "[devour]   1. Merge duplicate lessons within each lessons.md"
  echo "[devour]   2. Prune SKILL.md rules superseded by lessons.md"
  echo "[devour]   3. Run check-contracts.sh"
  echo "[devour]   4. Run check-orphans.sh"

  # Reset counter + record date
  TODAY=$(date +%Y-%m-%d)
  jq --argjson count 0 --arg date "$TODAY" '.distill_count = $count | .last_devour_at = $date' "$STATE_FILE" > "$STATE_FILE.tmp" && mv "$STATE_FILE.tmp" "$STATE_FILE"
  echo "[devour] Counter reset. State updated."
else
  echo "[devour] No trigger. distill_count=$NEW_COUNT/$DEVOUR_N"
fi
