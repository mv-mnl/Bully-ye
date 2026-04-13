# --- Auto-Completion ---
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select # Use an interactive menu for completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive completion
setopt always_to_end               # Move cursor to end if word had one match
