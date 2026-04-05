<h1 align="center">🐐 GOATvim</h1>

<p align="center">
  <em>A highly curated, blazing-fast, and modern Neovim configuration built for maximum developer productivity.</em>
</p>

---

## 🌟 Philosophy

**GOATvim** is designed to be a complete IDE replacement out of the box, focusing on speed, aesthetics, and modern Neovim features (0.10+). It bridges the gap between lightweight configurations and heavy distributions by providing a carefully selected set of powerful tools with sane, comfortable defaults.

- **Speed First:** Lazy-loaded plugins via `lazy.nvim` to keep startup times minimal.
- **Modern UI:** Clean, distraction-free interface powered by `noice.nvim`, `dressing.nvim`, and `snacks.nvim`.
- **Intelligent Coding:** AI-assisted completions with Gemini, blazing fast LSP, and modern syntax highlighting.
- **Surgical Navigation:** Jump anywhere instantly with `flash.nvim` and navigate project structures efficiently.

---

## 📦 What's Inside?

### Core & UI
- **[lazy.nvim](https://github.com/folke/lazy.nvim):** The best package manager for Neovim.
- **[snacks.nvim](https://github.com/folke/snacks.nvim):** Provides a beautiful dashboard, pickers, and scratch buffers.
- **[noice.nvim](https://github.com/folke/noice.nvim):** Replaces the UI for messages, cmdline, and the popupmenu.
- **[dressing.nvim](https://github.com/stevearc/dressing.nvim):** Improves standard Neovim UI interfaces.
- **[mini.nvim](https://github.com/echasnovski/mini.nvim):** A suite of modules providing `mini.sessions`, `mini.surround`, `mini.ai`, and a clean statusline.

### Navigation & Search
- **[Telescope](https://github.com/nvim-telescope/telescope.nvim) / Snacks Pickers:** Fuzzy find everything (files, buffers, grep, git history).
- **[flash.nvim](https://github.com/folke/flash.nvim):** Navigate your code with search labels, enhanced `f`/`t` motions, and Treesitter integration.
- **[trouble.nvim](https://github.com/folke/trouble.nvim):** A pretty list for showing diagnostics, references, and quickfix lists.
- **[grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim):** Powerful find and replace across your entire project.

### Development & LSP
- **Native LSP & Treesitter:** Pre-configured for deep semantic understanding, intelligent underlines, and context awareness (via `treesitter-context`).
- **[blink.cmp](https://github.com/Saghen/blink.cmp):** Blazing fast completion engine.
- **[conform.nvim](https://github.com/stevearc/conform.nvim):** Lightweight yet powerful formatter setup.
- **[gemini.nvim](https://github.com/kiddos/gemini.nvim):** AI-powered code completion and chat (disabled by default, toggleable).
- **[render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim):** Beautiful markdown rendering inside Neovim.

---

## ⌨️ Essential Keybindings

GOATvim uses `<Space>` as the leader key.

### General & Files
| Keymap | Action |
|--------|--------|
| `<leader>e` | Open File Explorer (Snacks) |
| `<leader>s` | Select & Restore Session (`mini.sessions`) |
| `<leader><space>` | Smart Find Files |
| `<leader>/` | Live Grep Project |
| `<leader>,` | Switch Buffers |
| `<leader>bd` | Delete current buffer |
| `<leader>z` | Toggle Zen Mode |

### Code Navigation (LSP & Trouble)
| Keymap | Action |
|--------|--------|
| `gd` | Go to Definition |
| `gr` | Go to References |
| `gI` | Go to Implementation |
| `gy` | Go to Type Definition |
| `gra` | Open Code Actions (Visual inline diagnostics) |
| `<leader>xx` | Toggle Trouble (Diagnostics List) |

### AI & Formatting
| Keymap | Action |
|--------|--------|
| `<leader>gt` | Toggle Gemini AI Completion/Hints |
| `<leader>f` | Format current buffer (Conform) |

### Movement (Flash)
| Keymap | Action |
|--------|--------|
| `s` | Flash search (Jump to any word on screen) |
| `S` | Flash Treesitter (Select syntax nodes visually) |

---

## 🚀 Installation

### Prerequisites
1. **Neovim** (v0.10.0 or newer)
2. **Git**, **Make**, **C Compiler**, **unzip**
3. **Ripgrep** (`rg`) - for fast text searches
4. **Nerd Font** - for beautiful icons in the UI and terminal
5. **eza** - modern replacement for `ls`

### Setup

Clone this repository directly into your Neovim configuration directory:

```bash
# Backup existing config if you have one
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup

# Clone GOATvim
git clone git@github.com:Mifd39/GOATvim.git ~/.config/nvim

# Open Neovim
nvim
```
*Upon launching, `lazy.nvim` will automatically bootstrap and install all configured plugins.*

---

## ⚙️ Customization

GOATvim is highly modular. You can easily add or modify plugins in the `lua/custom/plugins/` directory:
- To add a new plugin, simply create a new `.lua` file returning a lazy plugin spec inside `lua/custom/plugins/`.
- The main configuration is driven from `init.lua`.

---
<p align="center"><i>Happy Hacking!</i> 🐐</p>
