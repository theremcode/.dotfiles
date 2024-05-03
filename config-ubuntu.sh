#!/bin/bash

# Array of tools to install
tools=("nano")

# Update package lists once
if ! sudo apt update; then
    echo "Failed to update packages list, exiting..."
    exit 1
fi

# Loop through the array and check if each tool is installed
for tool in "${tools[@]}"; do
    if ! [ -x "$(command -v $tool)" ]; then
        echo "Installing $tool..."
        sudo apt install $tool -y
    else
        echo "$tool is already installed."
    fi
done

# Check and install Starship
if ! [ -x "$(command -v starship)" ]; then
    curl -sS https://starship.rs/install.sh | sh
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
    mkdir -p ~/.config
    wget -O ~/.config/starship.toml https://raw.githubusercontent.com/theremcode/.dotfiles/main/.config/starship.toml
    source ~/.bashrc
fi

# Install Oh My Zsh if not installed
if ! [ -d ~/.oh-my-zsh ]; then
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
fi

# Download and install .zsh files
mkdir -p ~/.zsh
wget -O ~/.zshrc https://raw.githubusercontent.com/theremcode/.dotfiles/main/.zshrc
wget -O ~/.zsh/starship.zsh https://raw.githubusercontent.com/theremcode/.dotfiles/main/.zsh/starship.zsh
wget -O ~/.zsh/aliases.zsh https://raw.githubusercontent.com/theremcode/.dotfiles/main/.zsh/aliases.zsh

# Ensure .zshrc is sourced from .bashrc
if ! grep -q "source ~/.zshrc" ~/.bashrc; then
    echo "source ~/.zshrc" >> ~/.bashrc
fi
