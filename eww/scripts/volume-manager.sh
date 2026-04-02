#!/usr/bin/env bash

# This script manages volume interactions and toggling the eww popup

action=$1

get_volume() {
    # Extract volume percentage using wpctl (WirePlumber/PipeWire)
    # the output is like "Volume: 0.50 [MUTED]" so we need to parse it
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
    if [ -z "$vol" ]; then
        echo "0"
    else
        echo "$vol"
    fi
}

set_volume() {
    val=$1
    # Convert percentage back to 0.xx format for wpctl
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "${val}%"
}

toggle_popup() {
    # Check if eww window is open
    status=$(eww -c /home/manuelmv/Bully-ye/eww active-windows | grep "volume_popup")
    
    if [ -z "$status" ]; then
        eww -c /home/manuelmv/Bully-ye/eww open volume_popup
        # Auto-close after 4 seconds (Optional feature, you can remove sleep to keep it toggle only)
        sleep 4 && eww -c /home/manuelmv/Bully-ye/eww close volume_popup &
    else
        eww -c /home/manuelmv/Bully-ye/eww close volume_popup
    fi
}

case $action in
    "get")
        get_volume
        ;;
    "set")
        set_volume "$2"
        ;;
    "toggle")
        toggle_popup
        ;;
    *)
        echo "Usage: $0 {get|set|toggle}"
        exit 1
        ;;
esac
