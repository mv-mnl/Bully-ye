return {
  -- Renderizado de Markdown en el editor
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {},
  },

  -- Previsualización en el navegador
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- Treesitter corregido
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Importamos de forma segura
      local status, configs = pcall(require, "nvim-treesitter.configs")
      if not status then 
        return 
      end

      configs.setup({
        -- Asegúrate de incluir estos para que Obsidian y Render-Markdown funcionen
        ensure_installed = { "markdown", "markdown_inline", "lua", "vim", "bash" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
}