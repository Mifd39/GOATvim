-- Oil.nvim: edit the file system like a buffer
-- https://github.com/stevearc/oil.nvim

return {
  'stevearc/oil.nvim',
  opts = {
    -- Optional dependencies
    dependencies = { { 'nvim-tree/nvim-web-devicons', opts = {} } },
    -- Configuration for oil.nvim
    columns = {
      'icon',
      -- "permissions",
      -- "size",
      -- "mtime",
    },
    -- Buffer-local options
    buf_options = {
      buflisted = false,
      bufhidden = 'hide',
    },
    -- Window-local options
    win_options = {
      wrap = false,
      signcolumn = 'no',
      cursorcolumn = false,
      foldcolumn = '0',
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = 'nvic',
    },
    -- Send to trash instead of deleting
    delete_to_trash = true,
    -- Skip the confirmation popup for simple operations
    skip_confirm_for_simple_edits = true,
    -- Configuration for the keymaps
    keymaps = {
      ['g?'] = 'actions.show_help',
      ['<CR>'] = 'actions.select',
      ['<C-s>'] = 'actions.select_vsplit',
      ['<C-h>'] = 'actions.select_split',
      ['<C-t>'] = 'actions.select_tab',
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = 'actions.close',
      ['<C-l>'] = 'actions.refresh',
      ['-'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['`'] = 'actions.cd',
      ['~'] = 'actions.tcd',
      ['gs'] = 'actions.change_sort',
      ['gx'] = 'actions.open_external',
      ['g.'] = 'actions.toggle_hidden',
      ['g\\'] = 'actions.toggle_trash',
    },
    -- Set to true to watch the filesystem for changes
    use_default_keymaps = true,
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = false,
      -- This function defines what is considered a "hidden" file
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, '.')
      end,
      -- This function defines what is considered a "ignored" file
      is_always_hidden_file = function(name, bufnr)
        return false
      end,
    },
  },
  -- Set up keymap to open Oil
  keys = {
    { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
  },
}
