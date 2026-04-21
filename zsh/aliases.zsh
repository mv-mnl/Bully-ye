# --- Aliases ---
# Sistema base

alias update='sudo pacman -Syu'    
alias shutdown='shutdown now'
alias grep='grep --color=auto'

# Reemplazos Potenciados (Modern CLI Tools)
if command -v eza &> /dev/null; then
    alias ls='eza --color=always --icons=always --group-directories-first'
    alias ll='eza -lh --color=always --icons=always --group-directories-first'
    alias la='eza -lah --color=always --icons=always --group-directories-first'
else
    alias ls='ls --color=auto'
    alias ll='ls -lah'
    alias la='ls -A'
fi

if command -v bat &> /dev/null; then
    alias cat='bat --theme=Coldark-Dark'
fi

# Git Commands
alias gc='git add -A && git commit -m'
alias gp='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gs="git status -sb"
alias gd="git --no-pager diff --color-words --patch-with-stat"
alias gcm='git switch'
alias gcr='git switch -c'
alias gca='git commit --amend'
alias gpf='git push --force-with-lease'
alias gb='git branch -vv --sort=-committerdate'

# --- Utilidades y Navegación Rápidas ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias md='mkdir -p'
alias vault='cd ~/Documentos/manuelmv/manuelmv/'
alias x='exit'

# --- Operaciones Seguras (Piden confirmación antes de destruir o sobreescribir) ---
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'

# --- Gestor de Paquetes (Yay/Pacman) ---
alias install='yay -S'
alias remove='yay -Rns'
alias search='yay -Ss'
alias orphan='yay -Qtdq | yay -Rns -' # Limpiar paquetes huérfanos sin uso


# --- Redes, Servidores y Disco ---
alias ping='ping -c 5'
alias ports='sudo netstat -tulanp'
alias df='df -h'      # Uso de disco legible
alias free='free -m'  # RAM libre en megabytes

# --- Eza Avanzado (Árboles de carpetas visuales) ---
if command -v eza &> /dev/null; then
    alias tree='eza --tree --level=2 --icons=always'
    alias treel='eza --tree --level=3 --icons=always'
fi



alias monitor="~/Bully-ye/hypr/scripts/detect_machine.sh"

#Python
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv'
alias venv-on='source bin/activate'
alias venv-off='deactivate'

