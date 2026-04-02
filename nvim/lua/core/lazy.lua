-- lua/core/lazy.lua
-- Instalación de lazy.nvim de manera automática si no está presente
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configuración e importe de la carpeta lua/plugins/
require("lazy").setup("plugins", {
  change_detection = {
    notify = false, -- No notificar cada vez que modificamos un archivo de plugin
  },
})
