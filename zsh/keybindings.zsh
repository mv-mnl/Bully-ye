# --- Keybindings ---
bindkey -e                         # Emacs keybindings

# Configurar los atajos de teclado home e end
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Configurar la tecla Delete para borrar el carácter siguiente
function delete-char-selection() {
  if (( REGION_ACTIVE )); then
    zle kill-region
  else
    zle delete-char
  fi
}
zle -N delete-char-selection
bindkey '^[[3~' delete-char-selection

# --- Selección de texto con Shift ---
function select-home() {
  zle beginning-of-line
  zle set-mark-command
  zle end-of-line
}
function select-end() {
  zle beginning-of-line
  zle set-mark-command
  zle end-of-line
}
function select-left() {
  (( REGION_ACTIVE )) || zle set-mark-command
  zle backward-char
}
function select-right() {
  (( REGION_ACTIVE )) || zle set-mark-command
  zle forward-char
}

zle -N select-home
zle -N select-end
zle -N select-left
zle -N select-right

# Atajos para Shift + Home/End/Arrows
bindkey '^[[1;2H' select-home
bindkey '^[[1;2F' select-end
bindkey '^[[1;2D' select-left
bindkey '^[[1;2C' select-right

# Permitir borrar selección con Backspace
function backward-delete-selection() {
  if (( REGION_ACTIVE )); then
    zle kill-region
  else
    zle backward-delete-char
  fi
}
zle -N backward-delete-selection
bindkey '^?' backward-delete-selection
