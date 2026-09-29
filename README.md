<h1 align="center">🐐 GOATvim</h1>

<p align="center">
  <em>A curated, fast Neovim configuration built on kickstart.nvim.</em>
</p>

---

## 📦 What's inside

### Core & UI
- **[lazy.nvim](https://github.com/folke/lazy.nvim)**: plugin manager, pinned via `lazy-lock.json`
- **[snacks.nvim](https://github.com/folke/snacks.nvim)**: dashboard, pickers, explorer, notifications, indent guides, terminal, scratch buffers
- **[noice.nvim](https://github.com/folke/noice.nvim)**: cmdline and message UI
- **[mini.nvim](https://github.com/echasnovski/mini.nvim)**: `mini.ai`, `mini.surround`, `mini.sessions`, `mini.icons`, statusline
- **[catppuccin](https://github.com/catppuccin/nvim)**: colorscheme

### Navigation & search
- **Snacks pickers**: files, grep, buffers, LSP, git, help, keymaps
- **[flash.nvim](https://github.com/folke/flash.nvim)**: jump anywhere with labels
- **[harpoon](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)**: pin files and jump between them
- **[oil.nvim](https://github.com/stevearc/oil.nvim)**: edit the filesystem like a buffer
- **[trouble.nvim](https://github.com/folke/trouble.nvim)**: diagnostics, references and quickfix lists
- **[grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim)**: project-wide find and replace

### Development
- **Native LSP** with [Mason](https://github.com/mason-org/mason.nvim): installs servers automatically (Lua, Python, C/C++, Tailwind)
- **[typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim)**: TypeScript / JavaScript / SolidJS
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** (`main` branch) + treesitter-context
- **[blink.cmp](https://github.com/Saghen/blink.cmp)**: completion, with LuaSnip + friendly-snippets
- **[conform.nvim](https://github.com/stevearc/conform.nvim)**: format on save (stylua, prettierd)
- **[nvim-lint](https://github.com/mfussenegger/nvim-lint)**: markdownlint
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)** + dap-ui: debugging
- **[gitsigns](https://github.com/lewis6991/gitsigns.nvim)**: git hunks in the gutter
- **[render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)**: markdown rendering in the buffer
- English / Danish spell checking (`<leader>us` cycles en → da → off)

---

## 🚀 Installation

### Prerequisites

| Tool | Why |
|------|-----|
| **Neovim 0.12+** | required by nvim-treesitter's `main` branch |
| **tree-sitter-cli 0.26.1+** | builds syntax parsers (install it natively, **not** from npm) |
| git, a C compiler, curl, tar, unzip | plugins, parsers and Mason packages |
| ripgrep (`rg`) | grep pickers |
| Node.js + npm | Mason installs pyright, prettierd, Tailwind and TypeScript with it |
| a [Nerd Font](https://www.nerdfonts.com/) | icons (set in your terminal) |
| *optional:* make, fd, wl-clipboard / xclip, go | LuaSnip regex, faster file search, system clipboard, Go debugging |

**Arch / Manjaro**
```bash
sudo pacman -S --needed neovim tree-sitter-cli git base-devel curl tar unzip ripgrep fd nodejs npm wl-clipboard
```

**Fedora**
```bash
sudo dnf install neovim tree-sitter-cli git gcc make curl tar unzip ripgrep fd-find nodejs npm wl-clipboard
```

**Debian / Ubuntu** (the packaged Neovim is too old, so install it from the release tarball)
```bash
sudo apt install git build-essential curl tar unzip ripgrep fd-find nodejs npm xclip
# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz && sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
# tree-sitter CLI (needs Rust: https://rustup.rs)
cargo install --locked tree-sitter-cli
```

Any distro can check its versions with `nvim --version` and `tree-sitter --version`.

### Setup

```bash
git clone https://github.com/Mifd39/GOATvim.git ~/GOATvim
cd ~/GOATvim
./install.sh            # becomes your main config (an existing one is backed up, never deleted)
# or
./install.sh goatvim    # installs side by side: run it with `NVIM_APPNAME=goatvim nvim`
```

The installer checks prerequisites and symlinks the repo into `~/.config`, so `git pull` updates your config.
On first launch, wait for lazy.nvim, the treesitter parsers and Mason to finish installing, then run
`:checkhealth kickstart` to confirm everything is in place.

### Updating

```bash
cd ~/GOATvim && git pull
```

Then run `:Lazy restore` in Neovim to move plugins to the versions pinned in `lazy-lock.json`.

### Uninstalling

```bash
rm ~/.config/nvim                      # or ~/.config/goatvim; this only removes the symlink
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim   # plugins, Mason tools, sessions
```

Swap `nvim` for `goatvim` in those paths if you installed it side by side. Restore your old config from the
`*.bak-<timestamp>` folder the installer created.

---

## ⌨️ Essential keybindings

Leader is `<Space>`. Press it and wait to see every mapping (which-key).

### Files & search
| Keymap | Action |
|--------|--------|
| `<leader><space>` | Smart find files |
| `<leader>/` | Grep project |
| `<leader>,` | Buffers |
| `<leader>e` | File explorer (snacks) |
| `-` | Open parent directory (oil) |
| `<leader>sf` / `sg` / `sr` / `sh` / `sk` | Files / grep / recent / help / keymaps |
| `<leader>sR` | Resume last picker |
| `<leader>a`, `<C-e>`, `<leader>1-4` | Harpoon: add, menu, jump |

### Code
| Keymap | Action |
|--------|--------|
| `gd` / `gr` / `gI` / `gy` | Definition / references / implementation / type definition |
| `grn` / `gra` | Rename / code action |
| `<leader>f` | Format buffer |
| `<leader>xx` | Diagnostics (Trouble) |
| `<leader>rr` / `rw` / `rf` | Find & replace: project / word / file |
| `<C-i>` | Accept completion |

### Editing & motion
| Keymap | Action |
|--------|--------|
| `s` / `S` | Flash jump / Flash treesitter |
| `gsa` / `gsd` / `gsr` | Surround add / delete / replace |

### Git
| Keymap | Action |
|--------|--------|
| `]h` / `[h` | Next / previous hunk |
| `<leader>hs` / `hr` / `hp` | Stage / reset / preview hunk |
| `<leader>gs` / `gl` / `gd` | Status / log / diff pickers |

### Toggles (`<leader>u`)
`us` spell (en/da/off) · `uw` wrap · `uh` inlay hints · `ud` diagnostics · `um` markdown render · `uL` relative numbers

### Debug
`<F5>` start/continue · `<F1>/<F2>/<F3>` step into/over/out · `<leader>db` breakpoint · `<leader>du` UI

---

## ⚙️ Customization

- Add plugins as new files in `lua/custom/plugins/`, each returning a lazy.nvim spec.
- Core options, LSP servers and treesitter languages live in `init.lua`.
- After adding or removing plugins, run `:Lazy sync` and commit `lazy-lock.json`.

---
<p align="center"><i>Happy hacking!</i> 🐐</p>
