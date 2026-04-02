# Configuración Modular de Neovim

¡Bienvenido a tu entorno de Neovim personalizado! Esta configuración está construida desde cero, de forma modular y limpia, diseñada para que entiendas y controles cada línea.

## 📂 Estructura de Archivos

La configuración está dividida en submódulos para mantener el orden y para que sea fácil escalar:

```text
nvim/
├── init.lua                   # 🚀 Punto de entrada principal, carga todo lo demás.
└── lua/
    ├── core/                  # ⚙️ Configuraciones base del editor
    │   ├── options.lua        # Opciones visuales, números, indentación y portapapeles.
    │   ├── keymaps.lua        # Definición de atajos de teclado sin plugins.
    │   └── lazy.lua           # Inicialización del gestor de plugins.
    └── plugins/               # 📦 Directorio de plugins individuales.
        └── ui.lua             # Archivo de ejemplo con tu tema y la barra de estado.
```

## ⌨️ Comandos y Atajos Básicos

**Tecla Líder (`<Leader>`)**: Está configurada como la barra espaciadora (`<Space>`). Se utiliza para ejecutar comandos personalizados.

* **Guardar archivo actual**: `<Espacio> + w`
* **Cerrar archivo/ventana**: `<Espacio> + q`
* **Limpiar el resaltado de búsqueda**: `<Esc>`

**Navegación entre ventanas divididas (splits):**
* **Izquierda**: `<Ctrl> + h`
* **Abajo**: `<Ctrl> + j`
* **Arriba**: `<Ctrl> + k`
* **Derecha**: `<Ctrl> + l`

## 📦 Gestor de Paquetes (`lazy.nvim`)

El entorno usa [lazy.nvim](https://github.com/folke/lazy.nvim) como administrador. De manera automática evalúa cualquier archivo dentro de `lua/plugins/`. Si introduces un plugin nuevo en esa carpeta, lo descargará o actualizará automáticamente cuando abras Neovim.

**Comandos útiles de lazy:**
* Para abrir la interfaz gráfica de lazy: `:Lazy`
* Presiona `U` dentro del menú para actualizar los plugins.
* Presiona `X` dentro del menú para limpiar/eliminar plugins que hayas borrado de tu código.
* Usa `q` para salir del menú.

## ➕ ¿Cómo añadir un plugin nuevo?

Es un proceso muy ordenado:
1. Crea un nuevo archivo `.lua` en `lua/plugins/` (por ejemplo, `telescope.lua`).
2. Retorna una tabla con la configuración del repositorio y opciones (como se ve en `lua/plugins/ui.lua`).
3. Guarda el archivo, abre Neovim y deja que `lazy.nvim` haga el resto.

Ejemplo genérico para tu archivo `lua/plugins/mi_plugin.lua`:
```lua
return {
  {
    "usuario-de-github/nombre-del-plugin",
    dependencies = { "alguna/dependencia" }, -- (Opcional) si requiere otro plugin
    config = function()
      -- Aquí va la configuración particular del plugin. Ejemplo:
      -- require("nombre-del-plugin").setup({})
    end
  }
}
```

---
*Entorno minimalista hecho a la medida.*
