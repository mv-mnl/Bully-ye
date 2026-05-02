mk() {
  mkdir -p "$1" && cd "$1"
}


git_resumen() {
  echo -e "\n--- RAMAS ---"
  git branch -a
  echo -e "\n--- ÚLTIMOS CAMBIOS ---"
  git log -n 5 --oneline --graph --color
  echo -e "\n--- ESTADO ---"
  git status -s
}
alias gr='git_resumen'

gl() {
  # Si no le pasas número, por defecto muestra 20
  local limite=${1:-100}
  git --no-pager log -n "$limite" --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
}

# --- Funciones Interactivas con FZF ---

# Git Add Fuzzy - Selecciona archivos para hacer stage
gaf() {
  local files
  files=$(git status -s | fzf -m --ansi --preview 'git diff --color=always -- {-1}' | awk '{print $NF}')
  if [[ -n $files ]]; then
    echo "$files" | xargs git add
    git status -s
  fi
}

# Git Checkout Fuzzy - Cambia de rama interactivamente
gcf() {
  local branch
  branch=$(git branch --all | grep -v 'HEAD' | fzf +m --ansi --preview 'git log --oneline --graph --color=always --count=50 {1}')
  if [[ -n $branch ]]; then
    git checkout "${branch//[* ]/}"
  fi
}

# Git Log Fuzzy - Explora commits con vista previa de cambios
glf() {
  git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" | \
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 | \
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF" \
      --preview "grep -o '[a-f0-9]\{7\}' <<< {} | head -1 | xargs git show --color=always"
}

# Git Checkout Object - Recupera versiones de archivos interactivamente
gco() {
  local files
  files=$(git ls-files --modified --others --exclude-standard | fzf -m --ansi --preview 'git diff --color=always -- {}')
  if [[ -n $files ]]; then
    echo "$files" | xargs git checkout
    git status -s
  fi
}


function antigravity() {
    
    nohup ~/app/Antigravity/antigravity "$@" >/dev/null 2>&1 &
    
    
    kill -9 $$
}

# Ver espacio en disco y qué está ocupando almacenamiento
espacio() {
  echo -e "\n\e[1;36m=== ESPACIO TOTAL EN DISCOS ===\e[0m"
  # Muestra los discos reales, excluyendo sistemas de archivos temporales o snaps
  df -hT -x tmpfs -x devtmpfs -x squashfs 2>/dev/null || df -h
  
  echo -e "\n\e[1;36m=== TOP 10 ARCHIVOS/CARPETAS MÁS PESADOS EN: \e[1;32m$(pwd)\e[0m \e[1;36m===\e[0m"
  # Calcula el tamaño del directorio actual y su contenido (1 nivel de profundidad)
  du -ah --max-depth=1 2>/dev/null | sort -rh | head -n 11
  
  echo ""
  # Sugerencia de una herramienta mejor si está instalada
  if command -v ncdu &> /dev/null; then
    echo -e "\e[1;33m💡 Tip: Tienes instalado 'ncdu'. Escribe 'ncdu' para analizar el espacio interactivamente.\e[0m\n"
  else
    echo -e "\e[1;30m💡 Tip: Puedes instalar 'ncdu' para explorar el espacio de forma interactiva.\e[0m\n"
  fi
}