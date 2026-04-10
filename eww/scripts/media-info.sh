#!/bin/bash
STATUS=$(playerctl status 2>/dev/null)
if [ -z "$STATUS" ] || [ "$STATUS" = "Stopped" ]; then
    jq -n '{title: "No media playing", artist: "Unknown artist", artUrl: "", status: "Stopped", position: 0, length: 0, posStr: "0:00", lenStr: "0:00", progress: 0}'
    exit 0
fi

TITLE=$(playerctl metadata title 2>/dev/null)
ARTIST=$(playerctl metadata artist 2>/dev/null)
RAW_ART=$(playerctl metadata mpris:artUrl 2>/dev/null)

# If it's a local file, strip the file:// prefix; otherwise download it
if [[ "$RAW_ART" == file://* ]]; then
    ART_PATH="${RAW_ART#file://}"
elif [[ "$RAW_ART" == http* ]]; then
    ART_PATH="/tmp/eww-media-art.jpg"
    curl -sL --max-time 3 "$RAW_ART" -o "$ART_PATH" 2>/dev/null || ART_PATH=""
else
    ART_PATH=""
fi

POS=$(playerctl position 2>/dev/null | awk '{print int($1)}')
LEN_US=$(playerctl metadata mpris:length 2>/dev/null)

[ -z "$POS" ] && POS=0
if [ -z "$LEN_US" ] || [ "$LEN_US" -eq 0 ]; then
    LEN=0
    PROGRESS=0
else
    LEN=$((LEN_US / 1000000))
    PROGRESS=$(awk -v pos="$POS" -v len="$LEN" 'BEGIN { printf "%.2f", (pos / len) * 100 }')
fi

format_time() {
    local seconds="$1"
    [ -z "$seconds" ] && seconds=0
    printf "%d:%02d" $((seconds / 60)) $((seconds % 60))
}

POS_STR=$(format_time "$POS")
LEN_STR=$(format_time "$LEN")

jq -n \
  --arg title "$TITLE" \
  --arg artist "$ARTIST" \
  --arg artUrl "${ART_PATH:-}" \
  --arg status "$STATUS" \
  --argjson position "$POS" \
  --argjson length "$LEN" \
  --arg posStr "$POS_STR" \
  --arg lenStr "$LEN_STR" \
  --argjson progress "${PROGRESS:-0}" \
  '{title: $title, artist: $artist, artUrl: $artUrl, status: $status, position: $position, length: $length, posStr: $posStr, lenStr: $lenStr, progress: $progress}'
