#!/usr/bin/env bash
# bootstrap.sh — clone/update dotfiles and deploy with stow

# 1. Repo & workdir
DOTFILES_DIR="$HOME/dotfiles"
if [[ -d $DOTFILES_DIR/.git ]]; then
  echo "Updating dotfiles…"
  git -C "$DOTFILES_DIR" pull --ff-only
else
  echo "Cloning dotfiles…"
  git clone git@github.com:jamil/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR" || exit

# 2. Deploy each package via stow
for pkg in i3 nvim tmux zsh starship; do
  stow --restow --target="$HOME" "$pkg"
done

echo "Dotfiles deployed!"

