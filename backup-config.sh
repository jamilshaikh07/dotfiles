#!/usr/bin/env bash
# 1. timestamped backup dir
TS=$(date +%Y%m%d_%H%M)
BACKUP=~/dotfiles_backup_$TS
mkdir -p "$BACKUP"

# 2. copy your live configs
cp -r ~/.config/i3        "$BACKUP/i3"
cp -r ~/.config/nvim      "$BACKUP/nvim"
cp -r ~/.config/tmux "$BACKUP/tmux"
cp ~/.zshrc               "$BACKUP/.zshrc"
cp ~/.config/starship.toml "$BACKUP/starship.toml"

echo "Backed up to $BACKUP"

