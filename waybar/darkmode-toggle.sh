#!/usr/bin/env bash
# Toggle between light (day) and dark (night) mode
# Stores current state in /tmp/waybar-darkmode

STATE_FILE="/tmp/waybar-darkmode"
LOG_FILE="/tmp/darkmode.log"

exec 1> >(tee -a "$LOG_FILE") 2>&1

echo "--- Run at $(date) ---"

# Read current state (default: dark)
if [ -f "$STATE_FILE" ]; then
    CURRENT=$(cat "$STATE_FILE")
else
    CURRENT="dark"
fi

echo "Current state: $CURRENT"

if [ "$CURRENT" = "dark" ]; then
    # Switch to LIGHT (day)
    NEW_STATE="light"
    echo "Switching to LIGHT"

    # GTK color scheme (triggers xdg-desktop-portal SettingChanged signal automatically)
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
    
    mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
    echo -e "[Settings]\ngtk-application-prefer-dark-theme=0" > ~/.config/gtk-3.0/settings.ini
    echo -e "[Settings]\ngtk-application-prefer-dark-theme=0" > ~/.config/gtk-4.0/settings.ini

    # Emit SettingChanged signal so Firefox/portals pick up the change
    gdbus emit --session --object-path /org/freedesktop/portal/desktop \
        --signal org.freedesktop.portal.Settings.SettingChanged \
        "org.freedesktop.appearance" "color-scheme" "<uint32 2>" 2>/dev/null || true

    # KDE/Qt Theme sync if kdeglobals exists
    if [ -f ~/.config/kdeglobals ]; then
        sed -i 's/ColorScheme=.*/ColorScheme=BreezeLight/' ~/.config/kdeglobals
    fi

    # Matugen: regenerate with light scheme
    WALLPAPER=$(cat /tmp/current-wallpaper 2>/dev/null)
    if [ -n "$WALLPAPER" ] && command -v matugen &>/dev/null; then
        echo "Regenerating Matugen (light)"
        matugen image "$WALLPAPER" --type scheme-tonal-spot -m light &>/dev/null
        bash /home/manuelmv/Bully-ye/wallpaper-carousel/matugen_reload.sh &
    fi
else
    # Switch to DARK (night)
    NEW_STATE="dark"
    echo "Switching to DARK"

    # GTK color scheme (triggers xdg-desktop-portal SettingChanged signal automatically)
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

    mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
    echo -e "[Settings]\ngtk-application-prefer-dark-theme=1" > ~/.config/gtk-3.0/settings.ini
    echo -e "[Settings]\ngtk-application-prefer-dark-theme=1" > ~/.config/gtk-4.0/settings.ini

    # Emit SettingChanged signal so Firefox/portals pick up the change
    gdbus emit --session --object-path /org/freedesktop/portal/desktop \
        --signal org.freedesktop.portal.Settings.SettingChanged \
        "org.freedesktop.appearance" "color-scheme" "<uint32 1>" 2>/dev/null || true

    # KDE/Qt Theme sync if kdeglobals exists
    if [ -f ~/.config/kdeglobals ]; then
        sed -i 's/ColorScheme=.*/ColorScheme=BreezeDark/' ~/.config/kdeglobals
    fi

    # Matugen: regenerate with dark scheme
    WALLPAPER=$(cat /tmp/current-wallpaper 2>/dev/null)
    if [ -n "$WALLPAPER" ] && command -v matugen &>/dev/null; then
        echo "Regenerating Matugen (dark)"
        matugen image "$WALLPAPER" --type scheme-tonal-spot -m dark &>/dev/null
        bash /home/manuelmv/Bully-ye/wallpaper-carousel/matugen_reload.sh &
    fi
fi

echo "$NEW_STATE" > "$STATE_FILE"
echo "New state: $NEW_STATE"

# Signal waybar to refresh the custom module
pkill -RTMIN+8 waybar
echo "Signaled waybar"
