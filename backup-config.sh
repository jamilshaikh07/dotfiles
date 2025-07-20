#!/usr/bin/env bash
# 1. timestamped backup dir
TS=$(date +%Y%m%d_%H%M)
BACKUP=~/dotfiles_backup_$TS
mkdir -p "$BACKUP"

# 2. copy your live configs
cp -r ~/.config/i3        "$BACKUP/.config/i3"
cp -r ~/.config/nvim      "$BACKUP/.config/nvim"
cp -r ~/.config/tmux "$BACKUP/.config/tmux"
cp ~/.zshrc               "$BACKUP/zsh/.zshrc"
cp ~/.config/starship.toml "$BACKUP/starship/.config/starship.toml"
cp ~/.vimrc             "$BACKUP/vimrc/.vimrc"

echo "Backed up to $BACKUP"

# pull latest, create branches if you like
git pull
# copy backups into each package
rsync -a --delete ~/dotfiles_backup_$TS/i3/     i3/
rsync -a --delete ~/dotfiles_backup_$TS/nvim/   nvim/
rsync -a --delete ~/dotfiles_backup_$TS/tmux/   tmux/
rsync -a --delete ~/dotfiles_backup_$TS/zsh/.zshrc zsh/.zshrc
rsync -a --delete ~/dotfiles_backup_$TS/starship/.config/starship.toml starship/.config/starship.toml
rsync -a --delete ~/dotfiles_backup_$TS/.vimrc .vimrc

# stage, commit & push
git add .
git commit -m "chore: import laptop configs ($TS)"
git push

