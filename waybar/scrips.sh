#!/bin/bash

# Obtener estado
STATUS=$(playerctl status 2>/dev/null)

if [ -z "$STATUS" ] || [ "$STATUS" = "Stopped" ]; then
    echo '{"text": "", "class": "stopped"}'
    exit 0
fi

TITLE=$(playerctl metadata title 2>/dev/null)
ARTIST=$(playerctl metadata artist 2>/dev/null)
ARTURL=$(playerctl metadata mpris:artUrl 2>/dev/null)
TIME=$(playerctl metadata --format "{{ duration(position) }} / {{ duration(mpris:length) }}" 2>/dev/null)

if [ -z "$TITLE" ]; then
    TITLE=$ARTIST
fi

# Handing album cover download
COVER="/tmp/waybar-cover.jpeg"
URL_FILE="/tmp/waybar-cover-url.txt"

if [ -n "$ARTURL" ]; then
    LAST_URL=$(cat "$URL_FILE" 2>/dev/null)
    if [ "$ARTURL" != "$LAST_URL" ]; then
        if [[ "$ARTURL" == file://* ]]; then
            cp "${ARTURL#file://}" "$COVER"
        else
            curl -s "$ARTURL" -o "$COVER"
        fi
        echo "$ARTURL" > "$URL_FILE"
    fi
else
    rm -f "$COVER" "$URL_FILE"
fi

# Escape text for Pango
TITLE=$(echo "$TITLE" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')
ARTIST=$(echo "$ARTIST" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')

if [ "$STATUS" = "Playing" ]; then
    CLASS="playing"
else
    CLASS="paused"
fi

INFO="$TIME  •  $ARTIST"

# Pango string with newline for two-line layout. Removing the  icon since we have album art now!
TEXT=$(printf "<span font_size='11pt'><b>%s</b></span>\n<span font_size='9pt' color='#a6adc8'>%s</span>" "$TITLE" "$INFO")

jq -n -c \
    --arg text "$TEXT" \
    --arg class "$CLASS" \
    --arg alt "$STATUS" \
    '{"text": $text, "class": $class, "alt": $alt}'