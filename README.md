<h1 align="center">🐐 GOATvim</h1>

<p align="center">
  <em>A curated, fast Neovim configuration built on kickstart.nvim.</em>
</p>

---

## 📦 What's inside

| Area | Plugins |
|------|---------|
GOATvim is deliberately lean: 22 plugins, and one plugin per job. [snacks.nvim](https://github.com/folke/snacks.nvim) and
[mini.nvim](https://github.com/echasnovski/mini.nvim) each cover many small features, so nothing is installed twice.

| Area | Plugins |
|------|---------|
| Core & UI | [lazy.nvim](https://github.com/folke/lazy.nvim) (plugins pinned in `lazy-lock.json`), [snacks.nvim](https://github.com/folke/snacks.nvim) (dashboard, pickers, file explorer, notifications, indent guides, terminal), [which-key.nvim](https://github.com/folke/which-key.nvim), [catppuccin](https://github.com/catppuccin/nvim), [mini.nvim](https://github.com/echasnovski/mini.nvim) (statusline, icons, sessions, textobjects, surround, auto-pairs, TODO highlights) |
| Navigation | [flash.nvim](https://github.com/folke/flash.nvim), [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) (find & replace) |
| Language support | Native LSP ([nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)) + [Mason](https://github.com/mason-org/mason.nvim), installing servers automatically for Lua, Python, C/C++, Rust, TypeScript / JavaScript (vtsls, incl. SolidJS) and Tailwind; [lazydev.nvim](https://github.com/folke/lazydev.nvim); [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (`main` branch) + treesitter-context |
| Editing | [blink.cmp](https://github.com/Saghen/blink.cmp) + [friendly-snippets](https://github.com/rafamadriz/friendly-snippets), [conform.nvim](https://github.com/stevearc/conform.nvim) (format on save: stylua, prettierd, ruff), treesitter folding, Neovim's built-in undo tree and directory diff |
| Git & debug | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [nvim-dap](https://github.com/mfussenegger/nvim-dap) + dap-ui (Python and Rust) |
| Writing | [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim), English / Danish spell checking |

---

## 🚀 Installation

### Requirements

| Tool | Version | Why |
|------|---------|-----|
| Neovim | **0.12+** | nvim-treesitter's `main` branch needs it |
| tree-sitter CLI | **0.26.1+** | builds the syntax parsers. Install it natively, **not** from npm |
| Node.js + npm | **22+** | Mason installs pyright, prettierd, Tailwind and vtsls with it (prettierd needs 22+) |
| git, a C compiler, curl, tar, unzip, ripgrep | any | plugins, parsers, Mason packages, grep search |
| A [Nerd Font](https://www.nerdfonts.com/) | any | icons; set it as your terminal font |
| *Optional:* python3 with `venv`, lazygit, fd, wl-clipboard or xclip | any | Python debugging (Mason installs debugpy into a venv), git UI (`<leader>gg`), faster file search, system clipboard |

### Arch / Manjaro

Everything in the official repos is new enough:

```bash
sudo pacman -S --needed neovim tree-sitter-cli nodejs npm git base-devel curl tar unzip ripgrep fd python lazygit wl-clipboard
```

### Fedora 43

Fedora's `neovim` (0.11) and `tree-sitter-cli` (0.25) packages are too old, so install those two from their releases:

```bash
sudo dnf install nodejs nodejs-npm git gcc curl tar unzip gzip ripgrep fd-find python3 wl-clipboard

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

# tree-sitter CLI
mkdir -p ~/.local/bin
curl -L https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz | gunzip > ~/.local/bin/tree-sitter
chmod +x ~/.local/bin/tree-sitter
```

### Debian / Ubuntu

The packaged Neovim, tree-sitter and Node.js are all too old:

```bash
sudo apt install git build-essential curl tar unzip gzip ripgrep fd-find python3-venv wl-clipboard xclip

# Node.js 22 (NodeSource)
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install nodejs

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
```

For the tree-sitter CLI, **Ubuntu 24.04+ / Debian 13+** can use the prebuilt binary:

```bash
mkdir -p ~/.local/bin
curl -L https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz | gunzip > ~/.local/bin/tree-sitter
chmod +x ~/.local/bin/tree-sitter
```

**Ubuntu 22.04 / Debian 12** have a glibc that's too old for that binary, so build it with Rust ([rustup.rs](https://rustup.rs)):

```bash
cargo install --locked tree-sitter-cli
```

**lazygit** (optional) is `sudo apt install lazygit` on Debian 13+ / Ubuntu 25.10+. On Fedora and older Ubuntu, follow
[lazygit's install guide](https://github.com/jesseduffield/lazygit#installation).

Make sure `~/.local/bin` (or `~/.cargo/bin`) is on your `PATH`. The commands above are for x86-64. On ARM, use the `arm64` release files instead.

### Setup

```bash
git clone https://github.com/Mifd39/GOATvim.git ~/GOATvim
cd ~/GOATvim
./install.sh            # becomes your main config (an existing one is backed up, never deleted)
# or
./install.sh goatvim    # installs side by side; start it with: NVIM_APPNAME=goatvim nvim
```

The installer checks the requirements above, then symlinks the repo into `~/.config`, so `git pull` updates your config.
On first launch, wait for lazy.nvim, the treesitter parsers and Mason to finish installing. Then run
`:checkhealth kickstart` to confirm your system has everything.

### Updating

```bash
cd ~/GOATvim && git pull
```

Then run `:Lazy restore` in Neovim to move plugins to the versions pinned in `lazy-lock.json`.

### Uninstalling

```bash
rm ~/.config/nvim                                              # only removes the symlink
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim   # plugins, Mason tools, sessions
```

If you installed side by side, use `goatvim` instead of `nvim` in those paths. Your previous config is in the
`*.bak-<timestamp>` folder the installer created.

---

## ⌨️ Keybindings

Leader is `<Space>`. Press it, `g`, `[` or `]` and pause to see every available key (which-key). `<leader>sk` searches all keymaps.

### Find & navigate
| Key | Action |
|-----|--------|
| `<leader>h` | Home screen (dashboard) |
| `<leader><leader>` | Smart find files |
| `<leader>/` | Grep in project |
| `<leader>,` | Open buffers |
| `<leader>:` | Command history |
| `<leader>e` | File explorer |
| `-` | File explorer, opened at the current file |
| `<leader>sf` | Find files |
| `<leader>sg` | Grep |
| `<leader>sw` | Grep word under cursor / selection |
| `<leader>sb` | Lines in current buffer |
| `<leader>sB` | Grep open buffers |
| `<leader>sr` | Recent files |
| `<leader>sG` | Git files (all files when not in a git repo) |
| `<leader>sp` | Projects |
| `<leader>sn` | Neovim config files |
| `<leader>sh` | Help pages |
| `<leader>sk` | Keymaps |
| `<leader>sd` | Diagnostics |
| `<leader>ss` | LSP symbols |
| `<leader>sR` | Resume last picker |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move between windows |

### Code & LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | References |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `grD` | Go to declaration |
| `grn` | Rename |
| `gra` | Code action |
| `gO` / `gW` | Document / workspace symbols |
| `K` | Hover documentation |
| `]]` / `[[` | Next / previous reference of word under cursor |
| `<leader>f` | Format buffer (also runs on save) |
| `<leader>cR` | Rename file |

### Completion (insert mode)
| Key | Action |
|-----|--------|
| `<Tab>` / `<C-i>` or `<C-y>` | Accept completion |
| `<C-n>` / `<C-p>` (or arrow keys) | Next / previous item |
| `<C-space>` | Open menu / toggle documentation |
| `<C-b>` / `<C-f>` | Scroll documentation |
| `<C-e>` | Close menu |
| `<C-k>` | Toggle signature help |

### Diagnostics
| Key | Action |
|-----|--------|
| `<leader>xx` | Diagnostics in the project |
| `<leader>xX` | Diagnostics in the current buffer |
| `<leader>xL` / `<leader>xQ` | Location / quickfix list |
| `<leader>q` | Diagnostics to location list |

### Find & replace
| Key | Action |
|-----|--------|
| `<leader>rr` | Search and replace in project |
| `<leader>rw` | Replace word under cursor |
| `<leader>rf` | Replace in current file |

### Motion & editing
| Key | Action |
|-----|--------|
| `s` | Flash jump (type characters, then the label) |
| `S` | Flash treesitter selection |
| `r` / `R` (after an operator) | Remote flash / treesitter search, e.g. `yr` |
| `gsa{motion}{char}` | Add surrounding, e.g. `gsaiw)` |
| `gsd{char}` | Delete surrounding, e.g. `gsd"` |
| `gsr{old}{new}` | Replace surrounding, e.g. `gsr)]` |
| `a` / `i` textobjects | Extended by mini.ai, e.g. `vaf`, `ciq`, `yinb` |
| `za` / `zc` / `zo` | Toggle / close / open fold (files open unfolded) |
| `zM` / `zR` | Close / open all folds |
| `<Esc>` | Clear search highlight |

### Git (in files tracked by git)
| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / previous hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk (works on a visual selection too) |
| `<leader>hS` / `<leader>hR` | Stage / reset buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` / `<leader>hD` | Diff against index / last commit |
| `<leader>tb` | Toggle inline blame |
| `<leader>tD` | Toggle showing deleted lines |
| `<leader>gs` / `<leader>gl` / `<leader>gd` | Git status / log / diff pickers |
| `<leader>gB` | Open file in the browser |
| `<leader>gg` | lazygit (needs `lazygit` installed) |
| `:DiffTool <a> <b>` | Compare two directories or files side by side |

### Toggles
| Key | Toggle |
|-----|--------|
| `<leader>us` | Spell check (English → Danish → off) |
| `<leader>uw` | Line wrap |
| `<leader>ul` / `<leader>uL` | Line numbers / relative numbers |
| `<leader>ud` | Diagnostics |
| `<leader>uh` | Inlay hints |
| `<leader>um` | Markdown rendering |
| `<leader>uc` | Conceal |
| `<leader>ug` | Indent guides |
| `<leader>uT` | Treesitter highlighting |
| `<leader>ub` | Dark / light background |
| `<leader>uD` | Dim inactive code |
| `<leader>uu` | Undo tree |
| `<leader>un` | Dismiss notifications |

### Windows, buffers & terminal
| Key | Action |
|-----|--------|
| `<leader>bd` | Delete buffer |
| `<leader>z` / `<leader>Z` | Zen mode / zoom window |
| `<leader>.` / `<leader>S` | Scratch buffer / pick scratch buffer |
| `<leader>n` | Notification history |
| `<C-/>` | Toggle terminal |
| `<Esc><Esc>` | Leave terminal mode |

### Debugging
Set up for **Python** (debugpy) and **Rust** (codelldb); Mason installs both adapters.

- **Python:** `<F5>` runs the current file with your active virtualenv's Python, or `python3` from your `PATH`.
- **Rust:** run `cargo build` first. `<F5>` asks whether to launch with or without arguments, then for the binary
  (it pre-fills `target/debug/`).

To debug another language, add its adapter in `lua/kickstart/plugins/debug.lua`.

| Key | Action |
|-----|--------|
| `<F5>` | Start / continue |
| `<F1>` / `<F2>` / `<F3>` | Step into / over / out |
| `<leader>db` / `<leader>dB` | Toggle breakpoint / conditional breakpoint |
| `<leader>dq` | Stop debugging |
| `<leader>du` / `<F7>` | Toggle debug UI |

### Dashboard
`<leader>h` opens it at any time. On the dashboard: `f` find file · `n` new file · `g` find text · `r` recent files · `c` config · `s` restore session · `l` Lazy · `q` quit

---

## ⚙️ Customization

- Add plugins as new files in `lua/custom/plugins/`, each returning a lazy.nvim spec.
- Core options, LSP servers, formatters and treesitter languages are in `init.lua`.
- After adding or removing plugins, run `:Lazy sync` and commit `lazy-lock.json`.

---
<p align="center"><i>Happy hacking!</i> 🐐</p>
