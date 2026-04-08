#!/bin/bash

# Fetch current song information
TITLE=$(playerctl metadata title 2>/dev/null)
ARTIST=$(playerctl metadata artist 2>/dev/null)
ALBUM=$(playerctl metadata album 2>/dev/null)
STATUS=$(playerctl status 2>/dev/null)

if [ -z "$TITLE" ]; then
    rofi -e "No music is currently playing." -theme-str 'window {width: 400px;}' 
    exit 0
fi

# Define options
if [ "$STATUS" = "Playing" ]; then
    PLAY_PAUSE="⏸  Pausar"
else
    PLAY_PAUSE="▶  Reproducir"
fi

NEXT="⏭  Siguiente"
PREV="⏮  Anterior"
STOP="⏹  Detener"

# Show rofi menu with song details
CHOICE=$(echo -e "$PLAY_PAUSE\n$NEXT\n$PREV\n$STOP" | rofi -dmenu \
    -p "Media Control" \
    -mesg "🎵 <b>Título:</b> $TITLE\n🎤 <b>Artista:</b> $ARTIST\n💿 <b>Álbum:</b> $ALBUM" \
    -lines 4 -width 30)

# Execute action based on choice
case "$CHOICE" in
    "$PLAY_PAUSE") playerctl play-pause ;;
    "$NEXT") playerctl next ;;
    "$PREV") playerctl previous ;;
    "$STOP") playerctl stop ;;
esac
