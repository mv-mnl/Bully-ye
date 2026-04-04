# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt append_history         # Append history list to the history file
setopt share_history          # Share history between all sessions
setopt hist_ignore_all_dups   # Ignore duplicates
setopt hist_reduce_blanks     # Remove superfluous blanks
