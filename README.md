# 🐐 goatvim

A curated, modern Neovim configuration built for speed and developer happiness.

## Features

- **Blazing Fast Startup** (using lazy.nvim)
- **Code Actions & Diagnostics** (configured with better underlines and easy access)
- **Session Management** (with `mini.sessions`)
- **Interactive Dashboard** (via `snacks.nvim`)
- **Modern Icons** (using eza icons and nerd fonts)

## Installation

### Prerequisites

- [Neovim](https://neovim.io/) (0.10+ recommended)
- [eza](https://github.com/eza-community/eza) (for icons)
- [Nerd Font](https://www.nerdfonts.com/) (for icons)

### Setup

To install **goatvim**, simply run the install script:

```bash
git clone https://github.com/your-username/goatvim.git ~/project/goatvim
cd ~/project/goatvim
./install.sh
```

The script works perfectly for **Bash**, **Zsh**, and **Fish** shell users.

## Usage

- `<leader>s`: Open session selector
- `gra`: Open LSP code actions
- `:MiniSessions.save('name')`: Save a session

Enjoy your ultimate Neovim experience! 🐐
