return {
  -- Mason: Gestor de paquetes para LSP, formateadores y linters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason-lspconfig: Puente entre Mason y lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        -- Lista de servidores a instalar automáticamente
        ensure_installed = {
          "pylsp",  -- LSP para Python (no requiere npm)
          "lua_ls", -- LSP para Lua (opcional pero recomendado)
        },
      })
    end,
  },

  -- Nvim-lspconfig: Configuración de los servidores de lenguaje
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Capacidades para que nvim-cmp funcione con LSP
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Configuración de pylsp (Python)
      lspconfig.pylsp.setup({
        capabilities = capabilities,
      })

      -- Configuración de lua_ls (Lua)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  },
}
