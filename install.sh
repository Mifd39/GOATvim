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

# Fix permissions if Neovim was previously run with sudo
echo "Checking permissions for Neovim data directories..."
for dir in "$HOME/.local/share/nvim" "$HOME/.local/state/nvim" "$HOME/.cache/nvim"; do
    if [ -d "$dir" ]; then
        if ! chown -R "$USER":"$(id -gn)" "$dir" 2>/dev/null; then
            echo "⚠️  Warning: Permission denied fixing ownership of $dir."
            echo "   Please run this manually: sudo chown -R $USER:$USER $dir"
        fi
    fi
done

# Fix "dubious ownership" error for ALL repositories on this machine
# This is necessary because lazy.nvim installs plugins in ~/.local/share/nvim/lazy/
# which Git often flags as having dubious ownership on new machine setups.
echo "Fixing Git 'dubious ownership' issues globally..."
git config --global --add safe.directory '*'

# Option to flush existing plugins
if [ -d "$HOME/.local/share/nvim/lazy" ]; then
    echo ""
    read -p "Do you want to wipe existing Neovim plugins to ensure a clean installation? (y/N) " wipe_plugins
    if [[ "$wipe_plugins" =~ ^[Yy]$ ]]; then
        echo "Flushing installed plugins in ~/.local/share/nvim/lazy..."
        rm -rf "$HOME/.local/share/nvim/lazy"
        echo "Plugins flushed."
    fi
fi

echo "----------------------------------------"
echo "🐐 goatvim installation complete!"
echo "Now run 'nvim' and wait for lazy.nvim to bootstrap your environment."
echo "----------------------------------------"