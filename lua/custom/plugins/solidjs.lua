return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    opts = {
      -- Enhanced TypeScript support with better code actions and completions
      -- For SolidJS: install with `npm install -g typescript @solidjs/language-server`
      -- Then the plugin will automatically detect SolidJS files
      settings = {
        expose_as_code_action = {
          'add_missing_imports',
          'remove_unused_imports',
          'fix_all',
          'organize_imports',
        },
        -- Enable inlay hints for better type visibility
        inlay_hints = {
          includeInlayParameterNameHints = 'literal',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
      },
    },
  },
  {
    'rafamadriz/friendly-snippets',
    dependencies = { 'L3MON4D3/LuaSnip' },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load({
        include = {
          'typescript',
          'javascript',
          'html',
        },
      })
    end,
  },
}


