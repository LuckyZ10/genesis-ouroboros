#!/usr/bin/env bash
# maybe-devour.sh — Ring 2 trigger
# Checks .ouroboros/state.json and triggers devour loop if threshold reached.
# Call this at the end of each distillation cycle.
set -euo pipefail

STATE_DIR="${AGENT_HOME:-.}/.ouroboros"
STATE_FILE="$STATE_DIR/state.json"
N_DEFAULT=10
LESSONS_HARD_LIMIT=20

# Initialize state if missing
if [ ! -f "$STATE_FILE" ]; then
  mkdir -p "$STATE_DIR"
  cat > "$STATE_FILE" << 'EOF'
{
  "distill_count": 0,
  "last_devour_at": null,
  "lessons_per_skill": {},
  "devour_n": 10
}
EOF
  echo "[devour] Initialized $STATE_FILE"
fi

# Increment distill count
DISTILL_COUNT=$(python3 -c "import json; print(json.load(open('$STATE_FILE'))['distill_count'])")
DEVOUR_N=$(python3 -c "import json; print(json.load(open('$STATE_FILE')).get('devour_n', $N_DEFAULT))")
NEW_COUNT=$((DISTILL_COUNT + 1))

# Check content-driven trigger: any lessons.md exceeds hard limit?
OVERFLOW=0
for lf in $(find . -name "lessons.md" -not -path "./.ouroboros/*" 2>/dev/null); do
  COUNT=$(grep -c "^### " "$lf" 2>/dev/null || echo 0)
  if [ "$COUNT" -gt "$LESSONS_HARD_LIMIT" ]; then
    echo "[devour] WARNING: $lf has $COUNT entries (limit: $LESSONS_HARD_LIMIT)"
    OVERFLOW=1
  fi
done

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

# Update state
python3 -c "
import json
with open('$STATE_FILE', 'r') as f:
    s = json.load(f)
s['distill_count'] = $NEW_COUNT
with open('$STATE_FILE', 'w') as f:
    json.dump(s, f, indent=2)
"

if [ "$NEEDS_DEVOUR" -eq 1 ]; then
  echo "[devour] TRIGGER: $REASON"
  echo "[devour] Run the devour checklist manually or invoke the devour agent:"
  echo "[devour]   1. Merge duplicate lessons within each lessons.md"
  echo "[devour]   2. Prune SKILL.md rules superseded by lessons.md remedies"
  echo "[devour]   3. Run check-contracts.sh to repair broken contracts"
  echo "[devour]   4. Run check-orphans.sh to sweep orphan scripts"

  # Reset counter after devour
  python3 -c "
import json
with open('$STATE_FILE', 'r') as f:
    s = json.load(f)
s['distill_count'] = 0
s['last_devour_at'] = import_module_name if False else None
import datetime
s['last_devour_at'] = datetime.date.today().isoformat()
with open('$STATE_FILE', 'w') as f:
    json.dump(s, f, indent=2)
"
  echo "[devour] Counter reset. State updated."
else
  echo "[devour] No trigger. distill_count=$NEW_COUNT/$DEVOUR_N"
fi
