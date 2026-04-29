-- lua/core/keymaps.lua
-- Configurar la tecla líder (Leader Key)
vim.g.mapleader = " "         -- <Space> como Leader Key
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Desactivar búsqueda resaltada con ESC
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Limpiar resalte de búsqueda" })

-- Guardar más rápido
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Guardar archivo" })

-- Quitar archivo actual (Cerrar)
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Cerrar ventana/archivo" })

-- Navegación de ventanas con Ctrl + hjkl
map("n", "<C-h>", "<C-w>h", { desc = "Ir a ventana izquierda" })
map("n", "<C-j>", "<C-w>j", { desc = "Ir a ventana inferior" })
map("n", "<C-k>", "<C-w>k", { desc = "Ir a ventana superior" })
map("n", "<C-l>", "<C-w>l", { desc = "Ir a ventana derecha" })

-- Mapeos estándar (Copiar, Pegar, Seleccionar todo)
-- Usando Ctrl (Preferido por el usuario)
map("n", "<C-a>", "ggVG", { desc = "Seleccionar todo" })
map("v", "<C-a>", "<Esc>ggVG", { desc = "Seleccionar todo" })
map("i", "<C-a>", "<Esc>ggVG", { desc = "Seleccionar todo" })

map("n", "<C-c>", '"+yyi', { desc = "Copiar línea y entrar a inserto" })
map("i", "<C-c>", '<C-o>"+yy', { desc = "Copiar línea sin salir de inserto" })
map("v", "<C-c>", '"+yi', { desc = "Copiar selección y volver a inserto" })
map("v", "<C-x>", '"+c', { desc = "Cortar y entrar en modo inserto" })
map("i", "<C-x>", '<C-o>"+dd', { desc = "Cortar línea sin salir de inserto" })
map("n", "<C-v>", '"+gpi', { desc = "Pegar y entrar en modo inserto" })
map("i", "<C-v>", "<C-r>+", { desc = "Pegar" })
map("v", "<C-v>", '"_c<C-r>+', { desc = "Pegar sobre selección y quedar en modo inserto" })

-- Borrado en modo visual (como un editor estándar)
map("v", "<BS>", '"_c', { desc = "Borrar selección y entrar en modo inserto" })
map("v", "<Del>", '"_c', { desc = "Borrar selección y entrar en modo inserto" })

-- Deshacer / Rehacer
map("n", "<C-z>", "u", { desc = "Deshacer" })
map("i", "<C-z>", "<C-o>u", { desc = "Deshacer en modo inserto" })
map("n", "<C-S-z>", "<C-r>", { desc = "Rehacer" })
map("i", "<C-S-z>", "<C-o><C-r>", { desc = "Rehacer en modo inserto" })

-- Movimiento por palabras con Control + Flechas
map("n", "<C-Left>", "b", { desc = "Palabra atrás" })
map("n", "<C-Right>", "w", { desc = "Palabra adelante" })
map("i", "<C-Left>", "<C-o>b", { desc = "Palabra atrás" })
map("i", "<C-Right>", "<C-o>w", { desc = "Palabra adelante" })
map("v", "<C-Left>", "b", { desc = "Palabra atrás" })
map("v", "<C-Right>", "w", { desc = "Palabra adelante" })

-- Selección con Shift + Flechas
-- En modo normal
map("n", "<S-Up>", "v<Up>", { desc = "Seleccionar arriba" })
map("n", "<S-Down>", "v<Down>", { desc = "Seleccionar abajo" })
map("n", "<S-Left>", "v<Left>", { desc = "Seleccionar izquierda" })
map("n", "<S-Right>", "v<Right>", { desc = "Seleccionar derecha" })
-- En modo inserto (Sale a modo visual para seleccionar)
map("i", "<S-Up>", "<Esc>v<Up>", { desc = "Seleccionar arriba" })
map("i", "<S-Down>", "<Esc>v<Down>", { desc = "Seleccionar abajo" })
map("i", "<S-Left>", "<Esc>v<Left>", { desc = "Seleccionar izquierda" })
map("i", "<S-Right>", "<Esc>v<Right>", { desc = "Seleccionar derecha" })
-- En modo visual con Shift (extender selección)
map("v", "<S-Up>", "<Up>", { desc = "Extender selección arriba" })
map("v", "<S-Down>", "<Down>", { desc = "Extender selección abajo" })
map("v", "<S-Left>", "<Left>", { desc = "Extender selección izquierda" })
map("v", "<S-Right>", "<Right>", { desc = "Extender selección derecha" })

-- En modo visual SIN Shift (Cancelar selección y volver a escribir automáticamente)
map("v", "<Up>", "<Esc>i<Up>", { desc = "Cancelar y seguir escribiendo" })
map("v", "<Down>", "<Esc>i<Down>", { desc = "Cancelar y seguir escribiendo" })
map("v", "<Left>", "<Esc>i<Left>", { desc = "Cancelar y seguir escribiendo" })
map("v", "<Right>", "<Esc>a<Right>", { desc = "Cancelar y seguir escribiendo" })

-- Selección de palabras con Ctrl + Shift + Flechas
map("n", "<C-S-Left>", "vb", { desc = "Seleccionar palabra atrás" })
map("n", "<C-S-Right>", "vw", { desc = "Seleccionar palabra adelante" })
map("i", "<C-S-Left>", "<Esc>vb", { desc = "Seleccionar palabra atrás" })
map("i", "<C-S-Right>", "<Esc>vw", { desc = "Seleccionar palabra adelante" })
map("v", "<C-S-Left>", "b", { desc = "Extender selección por palabra atrás" })
map("v", "<C-S-Right>", "w", { desc = "Extender selección por palabra adelante" })

-- Selección de línea con Shift + Home/End
map("n", "<S-Home>", "v0", { desc = "Seleccionar hasta inicio de línea" })
map("n", "<S-End>", "v$", { desc = "Seleccionar hasta fin de línea" })
map("i", "<S-Home>", "<Esc>v0", { desc = "Seleccionar hasta inicio de línea" })
map("i", "<S-End>", "<Esc>v$", { desc = "Seleccionar hasta fin de línea" })
map("v", "<S-Home>", "0", { desc = "Extender hasta inicio de línea" })
map("v", "<S-End>", "$", { desc = "Extender hasta fin de línea" })

-- Nota: Si los de Ctrl fallan en el terminal, Alt sigue siendo una alternativa:
-- map("n", "<M-a>", "ggVG") , etc.
