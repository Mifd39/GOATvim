#!/usr/bin/env bash
# 🐐 GOATvim installer
#
#   ./install.sh            install as your main config (~/.config/nvim)
#   ./install.sh goatvim    install side by side; start it with `NVIM_APPNAME=goatvim nvim`
#
# It never deletes anything: an existing config is moved to <dir>.bak-<timestamp>.

set -euo pipefail

APPNAME="${1:-nvim}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
TARGET="$CONFIG_HOME/$APPNAME"

missing_required=()
missing_optional=()
need() { command -v "$1" >/dev/null 2>&1 || missing_required+=("$1 ($2)"); }
want() { command -v "$1" >/dev/null 2>&1 || missing_optional+=("$1 ($2)"); }

echo "🐐 Installing GOATvim -> $TARGET"
echo

# --- Neovim version -----------------------------------------------------------
if command -v nvim >/dev/null 2>&1; then
  if ! nvim --headless -c 'if has("nvim-0.12") | qa | else | cq | endif' >/dev/null 2>&1; then
    missing_required+=("nvim 0.12+ (found $(nvim --version | head -1))")
  fi
else
  missing_required+=("nvim 0.12+")
fi

# --- tree-sitter CLI (nvim-treesitter main branch needs 0.26.1+) --------------
if command -v tree-sitter >/dev/null 2>&1; then
  ts_ver="$(tree-sitter --version | awk '{print $2}')"
  if [ "$(printf '%s\n0.26.1\n' "$ts_ver" | sort -V | head -1)" != "0.26.1" ]; then
    missing_required+=("tree-sitter-cli 0.26.1+ (found $ts_ver)")
  fi
else
  missing_required+=("tree-sitter (tree-sitter-cli 0.26.1+, needed for syntax highlighting)")
fi

need git   "plugin installs"
need cc    "building treesitter parsers (gcc or clang)"
need curl  "downloads"
need tar   "treesitter parser downloads"
need unzip "Mason package installs"
need rg    "ripgrep, used by the grep pickers"
need npm   "Mason installs pyright, prettierd, tailwind and typescript with it"
want make  "LuaSnip regex support"
want fd    "faster file pickers"
if ! command -v wl-copy >/dev/null 2>&1 && ! command -v xclip >/dev/null 2>&1 && ! command -v xsel >/dev/null 2>&1; then
  missing_optional+=("wl-clipboard or xclip (system clipboard)")
fi

if [ ${#missing_optional[@]} -gt 0 ]; then
  echo "Optional tools not found:"
  printf '  - %s\n' "${missing_optional[@]}"
  echo
fi

if [ ${#missing_required[@]} -gt 0 ]; then
  echo "Missing requirements:"
  printf '  - %s\n' "${missing_required[@]}"
  echo
  echo "See the README 'Prerequisites' section for per-distro install commands."
  read -r -p "Continue anyway? (y/N) " answer
  [[ "$answer" =~ ^[Yy]$ ]] || exit 1
fi

# --- Link the config into place -----------------------------------------------
mkdir -p "$CONFIG_HOME"
if [ -L "$TARGET" ]; then
  rm "$TARGET"
elif [ -e "$TARGET" ]; then
  backup="$TARGET.bak-$(date +%Y%m%d-%H%M%S)"
  echo "Moving existing $TARGET to $backup"
  mv "$TARGET" "$backup"
fi
ln -s "$REPO_DIR" "$TARGET"
echo "Linked $REPO_DIR -> $TARGET"

echo
echo "Done. Start Neovim and wait for plugins, parsers and language servers to install:"
if [ "$APPNAME" = "nvim" ]; then
  echo "  nvim"
else
  echo "  NVIM_APPNAME=$APPNAME nvim"
fi
echo "Then run :checkhealth kickstart to verify your system."
