-- Archivo principal: init.lua
-- Carga las configuraciones modulares en orden.

require("core.options")
require("core.lazy")

-- Desactiva el "conteo" de caracteres en los símbolos de Markdown
-- Esto evita el error de Treesitter en la vista previa
vim.opt.conceallevel = 2

-- Cargar keymaps al final para asegurar prioridad
require("core.keymaps")