#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install packages first
echo "Installing required packages..."
bash "$DOTFILES_DIR/packages/install-packages.sh"

# Create necessary directories
mkdir -p ~/.config/{i3,starship} ~/.local/bin

# Change to dotfiles directory
cd "$DOTFILES_DIR"

# Stow each package
for package in vim starship i3 zsh bash scripts; do
    echo "Stowing $package..."
    stow -v --adopt $package
done

echo "Installation complete!"