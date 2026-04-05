return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview Current File History" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview Project History" },
  },
  opts = {
    enhanced_diff_hl = true,
    use_icons = true,
    view = {
      merge_tool = {
        layout = "diff3_mixed",
        disable_diagnostics = true,
      },
    },
  },
}
