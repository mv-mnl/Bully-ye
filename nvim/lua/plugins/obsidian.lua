-- lua/plugins/obsidian.lua
return {
  "epwalsh/obsidian.nvim",
  version = "*", -- usar la última versión estable
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Requerido
    "nvim-lua/plenary.nvim",
    -- Opcional, para algunas características
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documentos/manuelmv/manuelmv",
      },
    },
    -- Configuración adicional
    notes_subdir = "notes",
    log_level = vim.log.levels.INFO,

    daily_notes = {
      folder = "dailies",
      date_format = "%Y-%m-%d",
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- Mapeos sugeridos por el plugin
    mappings = {
      -- "gf" para seguir enlaces
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Alternar casilla de verificación
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Buscar notas
      ["<leader>os"] = {
        action = function()
          vim.cmd("ObsidianSearch")
        end,
        opts = { buffer = true },
      },
      -- Abrir hoy
      ["<leader>od"] = {
        action = function()
          vim.cmd("ObsidianToday")
        end,
        opts = { buffer = true },
      },
    },
  },
}
