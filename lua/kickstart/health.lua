--[[
--
-- This file is not required for your own configuration,
-- but helps people determine if their system is setup correctly.
-- Run it with `:checkhealth kickstart`.
--
--]]

local check_version = function()
  local verstr = tostring(vim.version())
  -- nvim-treesitter (main branch) requires 0.12+
  if vim.version.ge(vim.version(), '0.12') then
    vim.health.ok(string.format("Neovim version is: '%s'", verstr))
  else
    vim.health.error(string.format("Neovim out of date: '%s'. GOATvim needs 0.12 or newer", verstr))
  end
end

local check_tree_sitter_cli = function()
  if vim.fn.executable 'tree-sitter' == 0 then
    vim.health.error("Could not find 'tree-sitter' (tree-sitter-cli)", {
      'nvim-treesitter needs it to build parsers; without it there is no syntax highlighting.',
      'Install 0.26.1+ from your package manager, `cargo install --locked tree-sitter-cli`,',
      'or a release binary from https://github.com/tree-sitter/tree-sitter/releases (not from npm).',
    })
    return
  end
  local out = vim.fn.system { 'tree-sitter', '--version' }
  local ver = vim.version.parse(out)
  if ver and vim.version.lt(ver, '0.26.1') then
    vim.health.warn(string.format("tree-sitter-cli %s is too old, 0.26.1+ is required", tostring(ver)))
  else
    vim.health.ok(string.format("Found tree-sitter-cli: '%s'", vim.trim(out)))
  end
end

local check_node = function()
  if vim.fn.executable 'node' == 0 then
    vim.health.error("Could not find 'node'", 'Mason needs Node.js 22+ to install pyright, prettierd, tailwind and vtsls.')
    return
  end
  local ver = vim.version.parse(vim.fn.system { 'node', '--version' })
  if ver and vim.version.lt(ver, '22.0.0') then
    vim.health.error(string.format('Node.js %s is too old, 22+ is required', tostring(ver)), 'prettierd needs Node.js 22+.')
  else
    vim.health.ok(string.format("Found Node.js: '%s'", tostring(ver)))
  end
end

local check_python = function()
  if vim.fn.executable 'python3' == 0 then
    vim.health.warn("Could not find 'python3'", 'Needed for Python debugging (Mason installs debugpy into a Python venv).')
    return
  end
  -- Actually create a venv: on Debian/Ubuntu the modules import fine but this fails without python3-venv
  local dir = vim.fn.tempname()
  vim.fn.system { 'python3', '-m', 'venv', dir }
  local failed = vim.v.shell_error ~= 0
  vim.fn.delete(dir, 'rf')
  if failed then
    vim.health.warn("python3 has no working 'venv' module", 'Mason cannot install debugpy. On Debian/Ubuntu: sudo apt install python3-venv')
  else
    vim.health.ok("Found python3 with venv (for debugpy)")
  end
end

local check_exes = function(exes, level)
  for _, exe in ipairs(exes) do
    local name, why = exe[1], exe[2]
    if vim.fn.executable(name) == 1 then
      vim.health.ok(string.format("Found executable: '%s'", name))
    else
      vim.health[level](string.format("Could not find executable: '%s' (%s)", name, why))
    end
  end
end

local check_clipboard = function()
  for _, exe in ipairs { 'wl-copy', 'xclip', 'xsel', 'pbcopy', 'win32yank.exe' } do
    if vim.fn.executable(exe) == 1 then
      vim.health.ok(string.format("Found clipboard tool: '%s'", exe))
      return
    end
  end
  vim.health.warn('No clipboard tool found', 'Install wl-clipboard (Wayland) or xclip (X11) to sync with the system clipboard.')
end

return {
  check = function()
    vim.health.start 'kickstart.nvim'

    vim.health.info [[NOTE: Not every warning is a 'must-fix' in `:checkhealth`

  Fix only warnings for plugins and languages you intend to use.
    Mason will give warnings for languages that are not installed.
    You do not need to install, unless you want to use those languages!]]

    local uv = vim.uv or vim.loop
    vim.health.info('System Information: ' .. vim.inspect(uv.os_uname()))

    check_version()
    check_tree_sitter_cli()
    check_node()
    check_exes({
      { 'git', 'plugin installs' },
      { 'cc', 'building treesitter parsers' },
      { 'curl', 'downloads for treesitter and mason' },
      { 'tar', 'treesitter parser downloads' },
      { 'unzip', 'mason package installs' },
      { 'rg', 'grep pickers' },
      { 'npm', 'mason installs pyright, prettierd, tailwind and vtsls' },
    }, 'error')
    check_exes({
      -- Debian/Ubuntu install fd as `fdfind`; snacks picks up either name
      { vim.fn.executable 'fdfind' == 1 and 'fdfind' or 'fd', 'faster file pickers' },
      { 'lazygit', 'git UI on <leader>gg' },
    }, 'warn')
    check_python()
    check_clipboard()
  end,
}
