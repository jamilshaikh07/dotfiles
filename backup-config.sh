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
cp ~/.vimrc             "$BACKUP/.vimrc"

echo "Backed up to $BACKUP"

# pull latest, create branches if you like
git pull
# copy backups into each package
rsync -a --delete ~/dotfiles_backup_$TS/i3/     i3/
rsync -a --delete ~/dotfiles_backup_$TS/nvim/   nvim/
rsync -a --delete ~/dotfiles_backup_$TS/tmux/   tmux/
rsync -a --delete ~/dotfiles_backup_$TS/.zshrc .zshrc
rsync -a --delete ~/dotfiles_backup_$TS/starship.toml starship.toml
rsync -a --delete ~/dotfiles_backup_$TS/.vimrc .vimrc

# stage, commit & push
git add .
git commit -m "chore: import laptop configs ($TS)"
git push

