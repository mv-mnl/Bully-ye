# --- Auto-Completion ---
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select # Use an interactive menu for completions
setopt always_to_end               # Move cursor to end if word had one match
