# --- Plugins & Tools ---

# Zsh System Plugins (Instalados via pacman)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Zoxide (Navegación inteligente)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# FZF (Fuzzy Finder - Búsqueda mágica con Ctrl+R etc)
if command -v fzf &> /dev/null; then
    source <(fzf --zsh)
fi

# Fastfetch (Opcional, comentalo o descomentalo)
# fastfetch
