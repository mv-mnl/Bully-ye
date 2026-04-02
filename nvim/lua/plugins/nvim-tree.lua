return {
  "nvim-tree/nvim-web-devicons", -- Iconos facheros para los archivos
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
        -- Esto ayuda a que se cierre solo si es el último buffer abierto
        filters = {
          dotfiles = false,
        },
      })

      -- Atajos de teclado específicos para el explorador
      local keymap = vim.keymap
      keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Abrir/Cerrar explorador" })
      keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { desc = "Encontrar archivo actual en el árbol" })
    end,
  },
}