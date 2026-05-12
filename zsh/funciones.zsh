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

# Ver espacio en disco y qué está ocupando almacenamiento (Versión Pro)
espacio() {
  local cyan="\e[1;36m"
  local green="\e[1;32m"
  local yellow="\e[1;33m"
  local red="\e[1;31m"
  local reset="\e[0m"
  local dim="\e[2m"
  local bold="\e[1m"

  echo -e "\n${cyan}╭───────────────────────────────────────────────────────╮${reset}"
  echo -e "${cyan}│${reset} 💽 ${bold}ESTADO DE LOS DISCOS PRINCIPALES${reset}                    ${cyan}│${reset}"
  echo -e "${cyan}╰───────────────────────────────────────────────────────╯${reset}\n"
  
  # Formatea la salida de df para que quede perfectamente alineada y con colores dinámicos
  df -hT -x tmpfs -x devtmpfs -x squashfs 2>/dev/null | awk '
  NR==1 {
    printf "  \033[1;34m%-16s %-10s %-8s %-8s %-8s %s\033[0m\n", "SISTEMA", "TIPO", "TOTAL", "USADO", "LIBRE", "USO%"
    print "  \033[2m------------------------------------------------------------------\033[0m"
  }
  NR>1 {
    color = "\033[1;32m"
    uso = $6 + 0
    if (uso > 75) color = "\033[1;33m"
    if (uso > 90) color = "\033[1;31m"
    
    printf "  %-16s %-10s %-8s %-8s %-8s " color "%-5s\033[0m %s\n", substr($1,1,15), substr($2,1,9), $3, $4, $5, $6, $7
  }'
  
  echo -e "\n${yellow}╭───────────────────────────────────────────────────────╮${reset}"
  echo -e "${yellow}│${reset} 📂 ${bold}TOP 10 MÁS PESADOS EN EL DIRECTORIO ACTUAL${reset}          ${yellow}│${reset}"
  echo -e "${yellow}╰───────────────────────────────────────────────────────╯${reset}"
  echo -e "  📍 ${dim}Ruta: ${green}$PWD${reset}\n"
  
  # Formatea la salida de du para destacar el peso
  du -ah --max-depth=1 2>/dev/null | sort -rh | head -n 11 | awk '
  NR==1 {
    printf "  \033[1;34m%-10s %s\033[0m\n", "TAMAÑO", "ARCHIVO / CARPETA (TOTAL)"
    print "  \033[2m------------------------------------------------------------------\033[0m"
    printf "  \033[1;31m%-10s\033[0m %s\n", $1, $2
  }
  NR>1 {
    printf "  \033[1;33m%-10s\033[0m %s\n", $1, $2
  }'

  echo ""
  
  # Tips inteligentes dependiendo de qué herramientas estén instaladas
  if command -v dust &> /dev/null; then
    echo -e "  🚀 ${green}Tip:${reset} Tienes ${bold}dust${reset} instalado. ¡Escribe 'dust' para una vista de árbol brutal!"
  elif command -v ncdu &> /dev/null; then
    echo -e "  💡 ${yellow}Tip:${reset} Tienes ${bold}ncdu${reset}. Escribe 'ncdu' para navegar interactivamente."
  elif command -v btop &> /dev/null; then
    echo -e "  📊 ${blue}Tip:${reset} Tienes ${bold}btop${reset}. Úsalo y ve a la pestaña 'disks' para más detalles."
  else
    echo -e "  🛠️  ${dim}Tip: Te recomiendo instalar 'ncdu' o 'dust' para un análisis súper interactivo.${reset}"
  fi
  echo ""
}