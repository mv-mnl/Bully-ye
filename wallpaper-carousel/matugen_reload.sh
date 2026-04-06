#!/usr/bin/env bash

# Reload Kitty instances
killall -USR1 .kitty-wrapped


# Reload CAVA
if pgrep -x "cava" > /dev/null; then
    # Rebuild the final config file from the base and newly generated colors
    cat ~/.config/cava/config_base ~/.config/cava/colors > ~/.config/cava/config 2>/dev/null
    # Tell CAVA to reload the config
    killall -USR1 cava
fi

# Reload SwayNC CSS styling dynamically without killing the daemon
if command -v swaync-client &> /dev/null; then
    swaync-client -rs
fi

# Restarting swayosd.service is currently the ONLY way to reload its CSS.
# WARNING: This is what causes the sound problems. Because swayosd-server 
# forcefully reconnects to an audio server on boot, restarting it causes audio drops/pops.
if systemctl --user is-active --quiet swayosd.service; then
    systemctl --user restart swayosd.service &
fi

wait

# Firefox: sync userChrome.css from whichever mode is currently active
FIREFOX_CHROME="/home/manuelmv/.mozilla/firefox/gmi5y4ec.default-release/chrome"
DARKMODE_STATE=$(cat /tmp/waybar-darkmode 2>/dev/null || echo "dark")
if [ "$DARKMODE_STATE" = "dark" ] && [ -f "$FIREFOX_CHROME/userChrome-dark.css" ]; then
    cp "$FIREFOX_CHROME/userChrome-dark.css" "$FIREFOX_CHROME/userChrome.css"
elif [ "$DARKMODE_STATE" = "light" ] && [ -f "$FIREFOX_CHROME/userChrome-light.css" ]; then
    cp "$FIREFOX_CHROME/userChrome-light.css" "$FIREFOX_CHROME/userChrome.css"
fi
