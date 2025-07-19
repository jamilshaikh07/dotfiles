#!/bin/bash
# Define username
USERNAME="jamil-shaikh"

# Grant sudo access without a password
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$USERNAME
# Avoid any interactive prompts
export DEBIAN_FRONTEND=noninteractive

# Update and install required packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y vim git tmux openssh-server htop lxappearance i3 pasystray neofetch zsh curl wget stow

# Install LazyVim (Neovim)
NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
sudo rm -rf /opt/nvim
curl -LO "$NVIM_URL"
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm -f nvim-linux-x86_64.tar.gz

# Install Oh My Zsh (Non-interactive)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    export RUNZSH="no"
    export KEEP_ZSHRC="yes"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
# Enable plugins in .zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

# Set Zsh as default shell without user prompt
echo "Changing shell to Zsh..."
echo "$USERNAME" | chsh -s $(which zsh)

# Install Homebrew (Non-interactive)
if [ ! -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    echo | NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Starship prompt (Non-interactive)
curl -sS https://starship.rs/install.sh | sh -s -- --yes
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

echo "Setup completed! Restart your system for all changes to take effect."

