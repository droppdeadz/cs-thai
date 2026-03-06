#!/usr/bin/env bash

CATEGORY="${1:-task-complete}"

# Resolve plugin root
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
CONFIG_FILE="$PLUGIN_ROOT/config.json"
SOUNDS_DIR="$PLUGIN_ROOT/sounds/$CATEGORY"

# Read config via Python3
read_config() {
  local key="$1"
  python3 -c "
import json, sys
try:
    with open('$CONFIG_FILE') as f:
        c = json.load(f)
    print(c.get('$key', ''))
except:
    pass
" 2>/dev/null
}

read_event_enabled() {
  local event="$1"
  python3 -c "
import json, sys
try:
    with open('$CONFIG_FILE') as f:
        c = json.load(f)
    enabled = c.get('enabled_events', {}).get('$event', True)
    print('true' if enabled else 'false')
except:
    print('true')
" 2>/dev/null
}

# Check if event is enabled
ENABLED=$(read_event_enabled "$CATEGORY")
if [ "$ENABLED" = "false" ]; then
  exit 0
fi

# Check sounds directory exists
if [ ! -d "$SOUNDS_DIR" ]; then
  exit 0
fi

# Collect sound files (bash 3 compatible)
SOUNDS=()
while IFS= read -r line; do
  SOUNDS+=("$line")
done < <(find "$SOUNDS_DIR" -maxdepth 1 -type f \( -name "*.mp3" -o -name "*.wav" -o -name "*.ogg" \) 2>/dev/null | sort)

if [ ${#SOUNDS[@]} -eq 0 ]; then
  exit 0
fi

# Avoid repeating last played sound
LAST_FILE="/tmp/cs-thai-last-${CATEGORY}"
LAST_SOUND=""
if [ -f "$LAST_FILE" ]; then
  LAST_SOUND=$(cat "$LAST_FILE")
fi

# Pick a random sound (avoid last if multiple)
if [ ${#SOUNDS[@]} -gt 1 ]; then
  CANDIDATES=()
  for s in "${SOUNDS[@]}"; do
    [ "$s" != "$LAST_SOUND" ] && CANDIDATES+=("$s")
  done
  SOUND="${CANDIDATES[$RANDOM % ${#CANDIDATES[@]}]}"
else
  SOUND="${SOUNDS[0]}"
fi

echo "$SOUND" > "$LAST_FILE"

# Read volume
VOLUME=$(read_config "volume")
VOLUME="${VOLUME:-0.5}"

# Play sound (cross-platform, non-blocking)
if command -v afplay &>/dev/null; then
  afplay -v "$VOLUME" "$SOUND" &
elif command -v paplay &>/dev/null; then
  paplay "$SOUND" &
elif command -v pw-play &>/dev/null; then
  VOL_PCT=$(python3 -c "print(int(float('$VOLUME') * 100))" 2>/dev/null || echo 50)
  pw-play --volume "$VOL_PCT" "$SOUND" &
elif command -v ffplay &>/dev/null; then
  VOL_PCT=$(python3 -c "print(int(float('$VOLUME') * 100))" 2>/dev/null || echo 50)
  ffplay -nodisp -autoexit -volume "$VOL_PCT" "$SOUND" &>/dev/null &
fi
