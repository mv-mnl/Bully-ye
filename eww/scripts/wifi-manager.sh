#!/bin/bash
CMD=$1

case $CMD in
  status)
    if [ "$(nmcli radio wifi)" = "disabled" ]; then
      echo '{"icon": "󰤮", "ssid": "Wi-Fi Apagado", "status": "disabled"}'
    else
      ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
      signal=$(nmcli -t -f active,signal dev wifi | grep '^yes' | cut -d: -f2)
      if [ -z "$ssid" ]; then
        echo '{"icon": "󰤯", "ssid": "Desconectado", "status": "disconnected"}'
      else
        if [ "$signal" -ge 75 ]; then icon="󰤨"
        elif [ "$signal" -ge 50 ]; then icon="󰤥"
        elif [ "$signal" -ge 25 ]; then icon="󰤢"
        else icon="󰤟"; fi
        echo "{\"icon\": \"$icon\", \"ssid\": \"$ssid\", \"status\": \"connected\"}"
      fi
    fi
    ;;

  toggle)
    if [ "$(nmcli radio wifi)" = "enabled" ]; then
      nmcli radio wifi off
    else
      nmcli radio wifi on
    fi
    ;;

  scan)
    # Returns JSON array of available networks
    nmcli dev wifi rescan 2>/dev/null
    nmcli -t -f ssid,signal,security,active dev wifi list 2>/dev/null \
      | grep -v '^:' \
      | sort -t: -k2 -rn \
      | awk -F: '!seen[$1]++ && $1!=""' \
      | head -15 \
      | while IFS=: read -r ssid signal security active; do
          ssid=$(echo "$ssid" | sed 's/"/\\"/g')
          connected="false"
          [ "$active" = "yes" ] && connected="true"
          if [ "$signal" -ge 75 ]; then icon="󰤨"
          elif [ "$signal" -ge 50 ]; then icon="󰤥"
          elif [ "$signal" -ge 25 ]; then icon="󰤢"
          else icon="󰤟"; fi
          lock=""
          [ -n "$security" ] && [ "$security" != "--" ] && lock=" 󰌾"
          echo "{\"ssid\": \"$ssid\", \"signal\": $signal, \"icon\": \"$icon\", \"secured\": \"$lock\", \"connected\": $connected}"
        done \
      | jq -s '.'
    ;;

  connect)
    SSID="$2"
    PASS="$3"
    # Try saved profile first
    if nmcli con up "$SSID" 2>/dev/null; then
      exit 0
    fi
    # Need password
    if [ -n "$PASS" ]; then
      nmcli dev wifi connect "$SSID" password "$PASS"
    else
      # Ask password via rofi
      PASS=$(rofi -dmenu -password -p "Contraseña para $SSID" -theme-str 'window {width: 400px;}')
      if [ -n "$PASS" ]; then
        nmcli dev wifi connect "$SSID" password "$PASS"
      fi
    fi
    ;;

  disconnect)
    nmcli con down "$(nmcli -t -f active,name con show --active | grep '^yes' | head -1 | cut -d: -f2)"
    ;;
esac
