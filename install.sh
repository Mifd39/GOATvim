#!/bin/bash

# 🐐 goatvim Installation Script
# This script sets up the goatvim configuration on your system.

NVIM_CONFIG_DIR="$HOME/.config/nvim"
GOATVIM_REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Starting goatvim installation..."

# Check prerequisites
command -v nvim >/dev/null 2>&1 || { echo >&2 "Warning: Neovim is not installed. Please install it."; }
command -v git >/dev/null 2>&1 || { echo >&2 "Warning: Git is not installed. Please install it."; }
command -v eza >/dev/null 2>&1 || { echo >&2 "Note: 'eza' is recommended for improved file icons."; }

# Ensure config directory exists
mkdir -p "$HOME/.config"

# Handle existing nvim configuration
if [ -e "$NVIM_CONFIG_DIR" ] && [ ! -L "$NVIM_CONFIG_DIR" ]; then
    echo "Backing up existing Neovim configuration to ~/.config/nvim.backup..."
    mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.backup"
elif [ -L "$NVIM_CONFIG_DIR" ]; then
    echo "Updating existing symbolic link..."
    rm "$NVIM_CONFIG_DIR"
fi

# Create symlink
echo "Linking goatvim: $GOATVIM_REPO_DIR -> $NVIM_CONFIG_DIR"
ln -s "$GOATVIM_REPO_DIR" "$NVIM_CONFIG_DIR"

# Fix "dubious ownership" error for ALL repositories on this machine
# This is necessary because lazy.nvim installs plugins in ~/.local/share/nvim/lazy/
# which Git often flags as having dubious ownership on new machine setups.
echo "Fixing Git 'dubious ownership' issues globally..."
git config --global --add safe.directory '*'

echo "----------------------------------------"
echo "🐐 goatvim installation complete!"
echo "Now run 'nvim' and wait for lazy.nvim to bootstrap your environment."
echo "----------------------------------------"
