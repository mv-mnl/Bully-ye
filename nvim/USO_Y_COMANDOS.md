# 📖 Guía Detallada de Uso y Atajos de Neovim

Este documento explica a fondo cómo utilizar tu configuración personalizada de Neovim, cubriendo desde los movimientos básicos hasta los comandos específicos de los plugins instalados.

## ⌨️ Conceptos Básicos

*   **Tecla Líder (`<Leader>`)**: Es la **Barra Espaciadora**. La mayoría de los atajos personalizados empiezan con ella.
*   **Modos**:
    *   `Normal`: Para moverte y ejecutar comandos (presiona `Esc` para volver aquí).
    *   `Insertar`: Para escribir texto (presiona `i`).
    *   `Visual`: Para seleccionar texto (presiona `v`).

---

## 🚀 Atajos Generales (Core)

Estos atajos están definidos en `lua/core/keymaps.lua`.

| Atajo | Acción | Descripción |
| :--- | :--- | :--- |
| `<Space> + w` | Guardar | Escribe los cambios en el archivo actual. |
| `<Space> + q` | Salir | Cierra la ventana o el archivo actual. |
| `<Esc>` | Limpiar | Quita el resaltado de las búsquedas anteriores. |
| `<Ctrl> + h` | Ventana Izq. | Mueve el cursor a la ventana de la izquierda. |
| `<Ctrl> + j` | Ventana Abajo | Mueve el cursor a la ventana de abajo. |
| `<Ctrl> + k` | Ventana Arriba | Mueve el cursor a la ventana de arriba. |
| `<Ctrl> + l` | Ventana Der. | Mueve el cursor a la ventana de la derecha. |

---

## 🔍 Navegación y Búsqueda (Telescope)

Telescope es el buscador difuso (fuzzy finder) ultra rápido.

| Atajo | Comando | Descripción |
| :--- | :--- | :--- |
| `<Space> + ff` | `find_files` | Busca archivos por nombre en todo el proyecto. |
| `<Space> + fw` | `live_grep` | Busca texto dentro de todos los archivos del proyecto. |
| `<Space> + fb` | `buffers` | Lista los archivos que tienes abiertos actualmente. |
| `<Space> + fh` | `help_tags` | Busca en la ayuda oficial de Neovim. |

---

## 🌳 Explorador de Archivos (Nvim-Tree)

Para gestionar tus archivos visualmente.

| Atajo | Acción | Descripción |
| :--- | :--- | :--- |
| `<Space> + e` | Toggle | Abre o cierra el panel lateral del explorador. |
| `<Space> + ef` | Find File | Abre el explorador y resalta el archivo que estás editando. |

**Dentro del explorador:**
*   `Enter`: Abre el archivo o carpeta.
*   `a`: Crear nuevo archivo.
*   `d`: Borrar archivo/carpeta.
*   `r`: Renombrar.
*   `q`: Cerrar el explorador.

---

## 📝 Obsidian y Notas Markdown

Optimizado para gestionar tu cerebro digital.

| Atajo | Acción | Descripción |
| :--- | :--- | :--- |
| `gf` | Go to File | Sigue un enlace de Obsidian o crea la nota si no existe. |
| `<Space> + ch` | Checkbox | Alterna el estado de una casilla `[ ]` ↔ `[x]`. |
| `<Space> + os` | Search | Busca específicamente dentro de tus notas de Obsidian. |
| `<Space> + od` | Today | Abre (o crea) tu nota diaria de hoy. |
| `:MarkdownPreview` | Preview | Abre una previsualización en tiempo real en tu navegador. |

---

## ⚡ Autocompletado (nvim-cmp)

Aparece automáticamente mientras escribes.

| Atajo | Acción | Descripción |
| :--- | :--- | :--- |
| `<Ctrl> + j` | Siguiente | Baja en la lista de sugerencias. |
| `<Ctrl> + k` | Anterior | Sube en la lista de sugerencias. |
| `<Ctrl> + Space` | Forzar | Obliga a que aparezca el menú de sugerencias. |
| `<Enter>` | Confirmar | Acepta la sugerencia seleccionada. |
| `<Ctrl> + e` | Cancelar | Cierra el menú de autocompletado. |

---

## 🛠️ Gestión de Plugins y LSP

Comandos para mantener tu sistema al día.

*   `:Lazy`: Abre el panel de control de plugins (Instalar, Actualizar, Borrar).
*   `:Mason`: Abre el gestor de servidores LSP, linters y formateadores.
*   `:LspInfo`: Muestra qué servidores de lenguaje están activos en el archivo actual.
*   `:checkhealth`: Ejecuta un diagnóstico general de tu configuración.

---

> **Tip:** Puedes ver una lista de todos tus atajos escribiendo `:Telescope keymaps`.
