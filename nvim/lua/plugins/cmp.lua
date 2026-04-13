return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",           -- Autocompletado basado en texto del archivo
      "hrsh7th/cmp-path",             -- Autocompletado de rutas de archivos
      "hrsh7th/cmp-nvim-lsp",          -- Autocompletado desde LSP
      "L3MON4D3/LuaSnip",             -- Motor de snippets (necesario)
      "saadparwaiz1/cmp_luasnip",     -- Conexión entre cmp y luasnip
      "rafamadriz/friendly-snippets", -- Colección de snippets para muchos lenguajes
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Carga snippets estilo VSCode (como los de friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- Moverse arriba en la lista
          ["<C-j>"] = cmp.mapping.select_next_item(), -- Moverse abajo en la lista
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),     -- Forzar aparición del menú
          ["<C-e>"] = cmp.mapping.abort(),            -- Cerrar menú
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Enter para confirmar
        }),
        -- Fuentes de donde sacará las sugerencias
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- Sugerencias del Servidor de Lenguaje (LSP)
          { name = "nvim_lua" }, -- Sugerencias de la API de Neovim
          { name = "luasnip" },  -- Snippets
          { name = "buffer" },   -- Palabras que ya escribiste en el archivo
          { name = "path" },     -- Rutas de carpetas/archivos
        }),
      })
    end,
  },
}