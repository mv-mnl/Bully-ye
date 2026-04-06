#!/usr/bin/env bash
# Script for Waybar to get the current dark mode status in JSON format

STATE_FILE="/tmp/waybar-darkmode"

# Read current state (default: dark)
if [ -f "$STATE_FILE" ]; then
    MODE=$(cat "$STATE_FILE")
else
    MODE="dark"
fi

# Output JSON for Waybar
# text: visible text (not used here since we use icons)
# alt: used for format-icons mapping
# class: used for CSS styling
echo "{\"text\":\"${MODE}\",\"alt\":\"${MODE}\",\"class\":\"${MODE}\"}"
