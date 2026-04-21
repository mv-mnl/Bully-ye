#!/bin/bash
CMD=$1

case $CMD in
  status)
    state=$(bluetoothctl show | grep "Powered: yes")
    if [ -z "$state" ]; then
      echo '{"icon": "󰂲", "name": "Bluetooth Apagado", "status": "disabled"}'
    else
      connected_device=$(bluetoothctl info 2>/dev/null | grep "Name:" | sed 's/.*Name: //')
      if [ -z "$connected_device" ]; then
        echo '{"icon": "", "name": "Desconectado", "status": "disconnected"}'
      else
        echo "{\"icon\": \"󰂱\", \"name\": \"$connected_device\", \"status\": \"connected\"}"
      fi
    fi
    ;;

  toggle)
    state=$(bluetoothctl show | grep "Powered: yes")
    if [ -z "$state" ]; then
      bluetoothctl power on
    else
      bluetoothctl power off
    fi
    ;;

  scan)
    # Start discovery briefly then list devices
    bluetoothctl scan on &
    SCAN_PID=$!
    sleep 4
    kill $SCAN_PID 2>/dev/null
    bluetoothctl scan off 2>/dev/null

    # List paired + discovered devices
    {
      # Paired/known devices
      bluetoothctl devices 2>/dev/null
      # Devices found in scan
      bluetoothctl devices Paired 2>/dev/null
    } | sort -u | grep "^Device" | while read -r _ mac name; do
      name=$(echo "$name" | sed 's/"/\\"/g')
      connected="false"
      icon=""
      if bluetoothctl info "$mac" 2>/dev/null | grep -q "Connected: yes"; then
        connected="true"
        icon="󰂱"
      fi
      paired="false"
      bluetoothctl info "$mac" 2>/dev/null | grep -q "Paired: yes" && paired="true"
      echo "{\"mac\": \"$mac\", \"name\": \"$name\", \"icon\": \"$icon\", \"connected\": $connected, \"paired\": $paired}"
    done | jq -s '.'
    ;;

  connect)
    MAC="$2"
    if bluetoothctl info "$MAC" 2>/dev/null | grep -q "Paired: yes"; then
      bluetoothctl connect "$MAC"
    else
      bluetoothctl pair "$MAC" && bluetoothctl connect "$MAC"
    fi
    ;;

  disconnect)
    MAC="$2"
    if [ -z "$MAC" ]; then
      # Disconnect currently connected device
      MAC=$(bluetoothctl devices Connected 2>/dev/null | head -1 | awk '{print $2}')
    fi
    [ -n "$MAC" ] && bluetoothctl disconnect "$MAC"
    ;;

  remove)
    MAC="$2"
    [ -n "$MAC" ] && bluetoothctl remove "$MAC"
    ;;
esac
