return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    opts = {
      heading = {
        sign = false,
        position = 'inline',
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      },
      code = {
        enabled = true,
        style = 'full',
        border = 'thin',
      },
      pipe_table = {
        preset = 'round',
      },
      callout = {
        note = { icon = '󰋽 ', highlight = 'RenderMarkdownInfo' },
        tip = { icon = '󰌶 ', highlight = 'RenderMarkdownSuccess' },
        important = { icon = '󰅒 ', highlight = 'RenderMarkdownHint' },
        warning = { icon = '󰀪 ', highlight = 'RenderMarkdownWarn' },
        caution = { icon = '󰳦 ', highlight = 'RenderMarkdownError' },
      },
    },
    ft = { "markdown", "codecompanion" },
    keys = {
      {
        "<leader>um",
        "<cmd>RenderMarkdown toggle<cr>",
        desc = "Toggle Markdown Render",
      },
    },
  },
}
