-- snacks centres every header line on its own, so lines of different widths
-- drift apart. Pad each piece into a rectangle, centre the goat over the title,
-- and the art stays in one piece (and survives editors that strip trailing spaces).
local goat = [[
  ___.
 //  \\
((   ''
 \\__,
  /6 (%)\,
 (__/:";,;\--____--_
  ;; :';,:';`;,';,;';`,`_
    ;:,;;';';,;':,';';,-Y\
     ;,;,;';';,;':;';'; Z/
     / ;,';';,;';,;';;'
    / / |';/~~~\';;;';\
   (;)  |;|    |;|  |;|
   |;|  |;|    |;|  |;|
  /  | /  |   /  | /  |
 "---'"---'  "---'"---']]

local title = [[
 ██████╗  ██████╗  █████╗ ████████╗██╗   ██╗██╗███╗   ███╗
██╔════╝ ██╔═══██╗██╔══██╗╚══██╔══╝██║   ██║██║████╗ ████║
██║  ███╗██║   ██║███████║   ██║   ██║   ██║██║██╔████╔██║
██║   ██║██║   ██║██╔══██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
╚██████╔╝╚██████╔╝██║  ██║   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═════╝  ╚═════╝ ╚═╝  ╚═╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝]]

local function rect(text, width)
  local lines = vim.split(text, '\n')
  local w = width or 0
  for _, l in ipairs(lines) do
    w = math.max(w, vim.api.nvim_strwidth(l))
  end
  for i, l in ipairs(lines) do
    lines[i] = l .. string.rep(' ', w - vim.api.nvim_strwidth(l))
  end
  return lines, w
end

local title_lines, title_width = rect(title)
local goat_lines, goat_width = rect(goat)
local indent = string.rep(' ', math.floor((title_width - goat_width) / 2))
for i, l in ipairs(goat_lines) do
  goat_lines[i] = indent .. l
end
goat_lines = rect(table.concat(goat_lines, '\n'), title_width)

-- Git pickers error out with "not a git repository" when the working directory
-- isn't in a repo. Use the repo of the working directory, else of the current file;
-- outside any repo, open `fallback` instead (or just say so).
local function git_picker(name, fallback)
  return function()
    local root = Snacks.git.get_root(vim.uv.cwd()) or Snacks.git.get_root(0)
    if root then
      Snacks.picker[name] { cwd = root }
    elseif fallback then
      Snacks.picker[fallback]()
    else
      Snacks.notify.warn 'Not inside a git repository'
    end
  end
end

local header = table.concat(vim.list_extend(vim.list_extend(goat_lines, { '', '' }), title_lines), '\n')

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      explorer = { enabled = true }, -- also opens for `nvim <dir>` instead of netrw
      dashboard = {
        preset = {
          header = header,
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })" },
            { icon = " ", key = "s", desc = "Restore Session", action = ":lua MiniSessions.select()" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = { enabled = true, ui_select = true },
      quickfix = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      -- Top pickers
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>h", function() Snacks.dashboard() end, desc = "Home (dashboard)" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      { "-", function() Snacks.explorer.reveal() end, desc = "Explorer at current file" },

      -- Search (<leader>s)
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sf", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sG", git_picker("git_files", "files"), desc = "Find Git Files" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Neovim config files" },
      { "<leader>sp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>sr", function() Snacks.picker.recent() end, desc = "Recent" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume last picker" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

      -- Diagnostics & lists (<leader>x)
      { "<leader>xx", function() Snacks.picker.diagnostics() end, desc = "Diagnostics (project)" },
      { "<leader>xX", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostics (buffer)" },
      { "<leader>xL", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>xQ", function() Snacks.picker.qflist() end, desc = "Quickfix List" },

      -- Git (<leader>g)
      { "<leader>gd", git_picker("git_diff"), desc = "Git Diff (hunks)" },
      { "<leader>gl", git_picker("git_log"), desc = "Git Log" },
      { "<leader>gs", git_picker("git_status"), desc = "Git Status" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse (open in web)" },
      {
        "<leader>gg",
        function()
          if vim.fn.executable("lazygit") == 0 then
            Snacks.notify.warn("lazygit is not installed (see the README requirements)")
            return
          end
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },

      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },

      -- UI / misc
      { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
      { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<c-/>", function() Snacks.terminal() end, desc = "Terminal" },
      { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },
      { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },
    init = function()
      -- Show LSP progress ("indexing…") as a single updating notification.
      vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          vim.notify(vim.lsp.status(), "info", {
            id = "lsp_progress",
            title = "LSP Progress",
            opts = function(notif)
              notif.icon = ev.data.params.value.kind == "end" and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (optional)
          _G.Snacks = require("snacks")
          -- Toggle mappings (spell toggle is <leader>us, handled in lua/custom/spell.lua)
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
}
