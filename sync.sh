#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function to sync dotfiles
sync_dotfiles() {
    cd "$DOTFILES_DIR"

    echo "Pulling latest changes..."
    git pull

    echo "Restowing all packages..."
    stow --restow */

    echo "Checking for local changes..."
    if [ -n "$(git status --porcelain)" ]; then
        echo "Changes detected, committing..."
        git add .
        git commit -m "Auto-sync: $(date '+%Y-%m-%d %H:%M:%S')"
        git push
        echo "Changes pushed to repository"
    else
        echo "No changes to sync"
    fi
}

# Run sync
sync_dotfiles