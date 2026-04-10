#!/usr/bin/env bash
# Toggle between light (day) and dark (night) mode
# Stores current state in /tmp/waybar-darkmode

STATE_FILE="/tmp/waybar-darkmode"
LOG_FILE="/tmp/darkmode.log"
FIREFOX_CHROME="/home/manuelmv/.mozilla/firefox/gmi5y4ec.default-release/chrome"
# Matugen generates these processed files (with real hex colors, not {{}} placeholders)
FIREFOX_DARK_CSS="$FIREFOX_CHROME/userChrome-dark.css"
FIREFOX_LIGHT_CSS="$FIREFOX_CHROME/userChrome-light.css"

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

    # KDE/Qt Theme sync: apply Matugen generated kdeglobals
    if [ -f ~/.config/kdeglobals-light ]; then
        cp ~/.config/kdeglobals-light ~/.config/kdeglobals
        echo "KDE: applied light theme to ~/.config/kdeglobals"
    fi

    # Matugen: regenerate with light scheme
    WALLPAPER=$(cat /tmp/current-wallpaper 2>/dev/null)
    if [ -n "$WALLPAPER" ] && command -v matugen &>/dev/null; then
        echo "Regenerating Matugen (light)"
        matugen image "$WALLPAPER" --type scheme-tonal-spot -m light --source-color-index 0 &>/dev/null
        bash /home/manuelmv/Bully-ye/wallpaper-carousel/matugen_reload.sh &
    fi

    # Firefox: apply light userChrome.css (needs Firefox restart to take effect)
    # Note: Matugen must have run at least once with a wallpaper to generate this file
    if [ -f "$FIREFOX_LIGHT_CSS" ]; then
        cp "$FIREFOX_LIGHT_CSS" "$FIREFOX_CHROME/userChrome.css"
        echo "Firefox: applied light theme to $FIREFOX_CHROME/userChrome.css"
    else
        echo "Firefox: light CSS not yet generated (set a wallpaper first)"
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

    # KDE/Qt Theme sync: apply Matugen generated kdeglobals
    if [ -f ~/.config/kdeglobals-dark ]; then
        cp ~/.config/kdeglobals-dark ~/.config/kdeglobals
        echo "KDE: applied dark theme to ~/.config/kdeglobals"
    fi

    # Matugen: regenerate with dark scheme
    WALLPAPER=$(cat /tmp/current-wallpaper 2>/dev/null)
    if [ -n "$WALLPAPER" ] && command -v matugen &>/dev/null; then
        echo "Regenerating Matugen (dark)"
        matugen image "$WALLPAPER" --type scheme-tonal-spot -m dark --source-color-index 0 &>/dev/null
        bash /home/manuelmv/Bully-ye/wallpaper-carousel/matugen_reload.sh &
    fi

    # Firefox: apply dark userChrome.css (needs Firefox restart to take effect)
    # Note: Matugen must have run at least once with a wallpaper to generate this file
    if [ -f "$FIREFOX_DARK_CSS" ]; then
        cp "$FIREFOX_DARK_CSS" "$FIREFOX_CHROME/userChrome.css"
        echo "Firefox: applied dark theme to $FIREFOX_CHROME/userChrome.css"
    else
        echo "Firefox: dark CSS not yet generated (set a wallpaper first)"
    fi
fi

echo "$NEW_STATE" > "$STATE_FILE"
echo "New state: $NEW_STATE"

# Signal waybar to refresh the custom module
pkill -RTMIN+8 waybar
echo "Signaled waybar"
