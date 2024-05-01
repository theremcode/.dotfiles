#!/bin/bash

# Array of tools to install
tools=("wget" "svn" "zsh")

# Update package lists once
sudo apt update -y

# Loop through the array and check if each tool is installed
for tool in "${tools[@]}"; do
    if ! [ -x "$(command -v $tool)" ]; then
        # Install the tool
        sudo apt install $tool -y
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
    wget -O ~/.zshrc https://raw.githubusercontent.com/theremcode/.dotfiles/main/.zshrc
fi

# Ensure .zshrc is sourced from .bashrc
if ! grep -q "source ~/.zshrc" ~/.bashrc; then
    echo "source ~/.zshrc" >> ~/.bashrc
fi
