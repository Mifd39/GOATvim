return {
  {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>rr",
        function()
          require('grug-far').open()
        end,
        desc = "Replace (Global)",
      },
      {
        "<leader>rw",
        function()
          require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
        end,
        desc = "Replace Word under cursor",
      },
      {
        "<leader>rf",
        function()
          require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } })
        end,
        desc = "Replace in current File",
      },
    },
  },
}
