-- lua/core/options.lua
local opt = vim.opt

-- Opciones de interfaz
opt.number = true             -- Activar números de línea
opt.relativenumber = true     -- Números de línea relativos
opt.mouse = "a"               -- Activar soporte para mouse
opt.cursorline = true         -- Resaltar línea actual
opt.scrolloff = 8             -- Dejar 8 líneas arriba/abajo al hacer scroll

-- Portapapeles
opt.clipboard = "unnamedplus" -- Compartir portapapeles con el sistema

-- Indentación y búsqueda
opt.expandtab = true          -- Usar espacios en lugar de tabs
opt.shiftwidth = 2
opt.tabstop = 2
opt.ignorecase = true         -- Búsqueda insensible a mayúsculas...
opt.smartcase = true          -- ...salvo que escribas en mayúscula
opt.updatetime = 250          -- Actualización más rápida para mejor experiencia
opt.termguicolors = true      -- Activar colores verdaderos
opt.signcolumn = "yes"        -- Mostrar siempre columna para iconos/git
