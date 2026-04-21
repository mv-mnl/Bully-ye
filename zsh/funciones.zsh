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