#!/bin/bash

# goatvim Installation Script
# This script sets up the goatvim configuration on your system.

NVIM_CONFIG_DIR="$HOME/.config/nvim"
GOATVIM_REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure config directory exists
mkdir -p "$HOME/.config"

# Handle existing nvim configuration
if [ -e "$NVIM_CONFIG_DIR" ] && [ ! -L "$NVIM_CONFIG_DIR" ]; then
    echo "Backing up existing Neovim configuration to ~/.config/nvim.backup..."
    mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.backup"
elif [ -L "$NVIM_CONFIG_DIR" ]; then
    echo "Removing existing symbolic link..."
    rm "$NVIM_CONFIG_DIR"
fi

# Create symlink
echo "Installing goatvim (linking $GOATVIM_REPO_DIR to $NVIM_CONFIG_DIR)..."
ln -s "$GOATVIM_REPO_DIR" "$NVIM_CONFIG_DIR"

# Fix "dubious ownership" error for ALL repositories on this machine
# This is necessary because lazy.nvim installs plugins in ~/.local/share/nvim/lazy/
echo "Fixing Git 'dubious ownership' issues globally..."
git config --global --add safe.directory '*'

echo "goatvim installation complete!"
echo "Now run 'nvim' and wait for lazy.nvim to install your plugins."
