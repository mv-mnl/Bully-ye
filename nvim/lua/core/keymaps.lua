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
