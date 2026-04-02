return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Dependencia estricta de Telescope
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make", -- Mejora el rendimiento de las búsquedas
      },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = "❯ ",
          path_display = { "truncate" }, -- Acorta las rutas muy largas
        },
      })

      -- Cargamos el plugin de rendimiento (fzf) si `make` tuvo éxito
      pcall(telescope.load_extension, "fzf")

      -- Atajos de teclado para Telescope
      local keymap = vim.keymap
      keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Buscar archivos en el proyecto" })
      keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Buscar palabras/texto en el proyecto" })
      keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Listar buffers abiertos" })
      keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Buscar en la ayuda de Neovim" })
    end,
  },
}
