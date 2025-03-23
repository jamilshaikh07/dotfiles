# Dotfiles managed with GNU Stow

## Initial Setup

1. Clone the repository:
```bash
git clone <your-private-repo-url> ~/.dotfiles
cd ~/.dotfiles


The advantages of using Stow over the custom bash script approach:

1. **Reliability**: Stow has been tested and used for years, handling edge cases we might miss
2. **Simplicity**: No need to maintain complex symlink creation logic
3. **Flexibility**: Easy to add/remove packages without modifying scripts
4. **Safety**: Stow won't overwrite existing files unless told to
5. **Visibility**: Easy to see what's linked with `stow -n -v package_name`
6. **Consistency**: Enforces a clean directory structure
7. **Reversibility**: Easy to unlink with `stow -D package_name`

To use this system:

1. Set up the directory structure as shown
2. Move your config files into the appropriate directories, maintaining the home directory structure
3. Run `install.sh` on your machines
4. Use `sync.sh` to push changes
5. Use `git pull && stow --restow */` on other machines to update

This is much more maintainable than the bash script approach and follows Unix philosophy of using specialized tools for specialized tasks.