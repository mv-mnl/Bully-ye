-- lua/plugins/ui.lua
return {
  -- Un tema bonito como base
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Cargar este plugin durante el inicio
    priority = 1000, -- Hacer que se cargue antes de otros
    opts = {
      style = "night",
      transparent = true,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
    end,
  },
  
  -- Línea de estado bonita
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
        }
      })
    end,
  }
}
