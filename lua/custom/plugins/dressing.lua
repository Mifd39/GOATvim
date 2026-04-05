return {
  {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
    opts = {
      input = {
        enabled = true,
        border = "rounded",
        start_in_insert = true,
      },
      select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "builtin" },
      },
    },
  },
}
