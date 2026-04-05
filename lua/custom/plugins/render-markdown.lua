return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        -- 'simple' is very minimal. 'block' gives headers a background color for that "Modern" feel.
        sign = false,
        position = 'inline',
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      },
      code = {
        enabled = true,
        style = 'full', -- Adds background and border to code blocks
        border = 'thin',
      },
      pipe_table = {
        preset = 'round', -- Replaces ASCII | with smooth rounded Unicode pipes
      },
      callout = {
        -- Support for GitHub style > [!NOTE] blocks
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
