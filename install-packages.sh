#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo_success() {
    echo -e "${GREEN}$1${NC}"
}

echo_error() {
    echo -e "${RED}$1${NC}"
}

# Install Homebrew if not present
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Linux
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.zshrc"
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
    fi
}

# Install apt packages
install_apt_packages() {
    if command -v apt &> /dev/null; then
        echo "Installing apt packages..."
        
        # Add required repositories
        sudo add-apt-repository -y ppa:aslatter/ppa  # for wezterm
        
        # Add Google Chrome repository
        wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
        
        # Add Brave repository
        sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
        
        sudo apt update
        while read -r package; do
            if [ ! -z "$package" ]; then
                echo "Installing $package..."
                sudo apt install -y "$package"
            fi
        done < "apt.txt"
        echo_success "Apt packages installed successfully!"
    fi
}

# Install Brew packages
install_brew_packages() {
    if command -v brew &> /dev/null; then
        echo "Installing Brew packages..."
        
        # Add required taps
        brew tap azure/azure-cli
        brew tap homebrew/cask-versions
        
        while read -r package; do
            if [ ! -z "$package" ]; then
                echo "Installing $package..."
                brew install "$package"
            fi
        done < "brew.txt"
        echo_success "Brew packages installed successfully!"
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo_success "Oh My Zsh installed successfully!"
    fi
}

# Install Windsurf
install_windsurf() {
    if ! command -v windsurf &> /dev/null; then
        echo "Installing Windsurf..."
        curl -fsSL https://www.codeium.com/windsurf-install.sh | sh
        echo_success "Windsurf installed successfully!"
    fi
}

# Main installation process
main() {
    cd "$(dirname "$0")"
    
    install_homebrew
    install_apt_packages
    install_brew_packages
    install_oh_my_zsh
    install_windsurf
    
    echo_success "All packages installed successfully!"
}

main