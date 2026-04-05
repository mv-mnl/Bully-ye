#!/bin/bash
DIR="$HOME/Bully-ye/wallpaper-carousel"

# Create cache dirs if not existing
mkdir -p "$HOME/.cache/wallpaper_picker/thumbs"

# Clean up any previously hung quickshell instances related to the carousel to avoid overlaps
for pid in $(pgrep -f "quickshell.*shell.qml"); do
    kill -9 $pid 2>/dev/null || true
done

# Run the carousel
quickshell -p "$DIR/shell.qml" &
