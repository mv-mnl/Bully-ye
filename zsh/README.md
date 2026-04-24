# Zsh Configuration Dashboard

Este documento detalla los alias y funciones configurados en este entorno para mejorar la productividad y el flujo de trabajo en la terminal.

## 🚀 Git (Aliados de Productividad)

### Alias Principales
| Alias | Comando Git | Descripción |
| :--- | :--- | :--- |
| `gs` | `git status -sb` | Estado resumido y rama actual. |
| `gc` | `git add -A && git commit -m` | Añade todo y crea un commit con mensaje. |
| `gp` | `git push origin [rama]` | Sube los cambios a la rama actual en el origin. |
| `gd` | `git diff --color-words...` | Muestra diferencias por palabras con estadísticas. |
| `gcm`| `git switch` | Cambia de rama. |
| `gcr`| `git switch -c` | Crea y cambia a una nueva rama. |
| `gca`| `git commit --amend` | Corrige el último commit realizado. |
| `gpf`| `git push --force-with-lease` | Push forzado de forma segura. |
| `gb` | `git branch -vv...` | Lista ramas ordenadas por actividad reciente. |
| `gr` | `git_resumen` | Resumen completo: ramas, últimos cambios y estado. |

### Funciones Interactivas (Requieren `fzf`)
| Función | Descripción |
| :--- | :--- |
| `gaf` | **Git Add Fuzzy**: Selecciona archivos para el stage interactivamente con vista previa. |
| `gcf` | **Git Checkout Fuzzy**: Cambia de rama seleccionándola de una lista visual. |
| `glf` | **Git Log Fuzzy**: Explorador de commits interactivo con vista previa de cambios. |
| `gco` | **Git Checkout Object**: Recupera versiones de archivos modificados interactivamente. |
| `gl`  | **Git Log Pro**: Histórico visual detallado con grafos y colores. |

---

## 🛠️ Sistema y Utilidades

### Navegación y Archivos
*   `..`, `...`, `....`: Navegación rápida hacia directorios superiores.
*   `ls`, `ll`, `la`: Listado de archivos potenciado con `eza` (iconos y colores).
*   `tree`, `treel`: Visualización de directorios en forma de árbol.
*   `cat`: Visualización de archivos con sintaxis resaltada (`bat`).
*   `c`: Limpia la pantalla (`clear`).
*   `x`: Cierra la terminal (`exit`).
*   `md [dir]`: Crea directorios de forma recursiva (`mkdir -p`).
*   `mk [dir]`: Crea un directorio y entra en él automáticamente.

### Operaciones Seguras
*   `cp`, `mv`, `rm`: Piden confirmación antes de sobreescribir o borrar archivos (`-i`).

### Gestión de Paquetes (Arch/Yay)
*   `update`: Actualiza el sistema (`pacman -Syu`).
*   `install [pkg]`: Instala paquetes usando `yay`.
*   `remove [pkg]`: Elimina paquetes y sus dependencias no usadas.
*   `search [query]`: Busca paquetes en los repositorios.
*   `orphan`: Limpia paquetes huérfanos del sistema.

---

## 🐍 Desarrollo (Python)
*   `py` / `pip`: Atajos para `python3` y `pip3`.
*   `venv`: Crea un entorno virtual.
*   `venv-on` / `venv-off`: Activa o desactiva el entorno virtual (usando carpetas estándar).

---

## 🌐 Redes y Hardware
*   `ports`: Muestra puertos abiertos y procesos asociados.
*   `df`: Uso de disco en formato legible.
*   `free`: Estado de la memoria RAM en MB.
*   `update-grub`: Actualiza la configuración del cargador de arranque Grub.
