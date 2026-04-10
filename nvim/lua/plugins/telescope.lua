-- lua/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    -- OPCIÓN A: Si quieres seguir en la versión estable, deja la línea de branch y usa el parche de abajo.
    -- OPCIÓN B: Si borras la línea de branch, se usará la versión master que suele tener estas correcciones ya integradas.
    branch = "0.1.x", 
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = "❯ ",
          path_display = { "truncate" },
          
          -- FIX: Esta es la parte que soluciona el error 'ft_to_lang'
          -- Desactiva el resaltado de Treesitter solo en la ventanita de preview 
          -- para que no choque con la API nueva de Neovim.
          preview = {
            treesitter = false,
          },
        },
      })

      -- Cargamos el plugin de rendimiento (fzf)
      pcall(telescope.load_extension, "fzf")

      -- Atajos de teclado
      local keymap = vim.keymap
      keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Buscar archivos" })
      keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Buscar texto" })
      keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Listar buffers" })
      keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Ayuda" })
    end,
  },
}