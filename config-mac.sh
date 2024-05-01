#!/bin/bash

#check if brew is installed and if not install it
if ! [ -x "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Array of tools to install
tools=("wget" "svn" "starship" "zsh")

# Loop through the array and check if each tool is installed
for tool in "${tools[@]}"; do
    if ! [ -x "$(command -v $tool)" ]; then
        # Install the tool
        brew install $tool -y
    fi
done

# Loop through the array and check if each tool is installed
for tool in "${tools[@]}"; do
    if ! [ -x "$(command -v $tool)" ]; then
        # Install the tool
        sudo apt update -y
        sudo apt install $tool -y
    fi
done

# Download and install warp themes
if [ -x "$(command -v warp)" ]; then
    mkdir -p ~/.warp/themes
    wget -O ~/.warp/themes/dark.yaml https://raw.githubusercontent.com/theremcode/.dotfiles/main/.warp/themes/dark.yml
fi

# Download and install starship them
if [ -x "$(command -v starship)" ]; then
    mkdir -p ~/.config
    wget -O ~/.config/starship.toml https://raw.githubusercontent.com/theremcode/.dotfiles/main/.config/starship.toml
fi

# check if oh my zsh is installed and if not install it
if ! [ -d ~/.oh-my-zsh ]; then
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    svn export https://raw.githubusercontent.com/theremcode/.dotfiles/.zsh ~/
    wget -O ~/.zshrc https://raw.githubusercontent.com/theremcode/.dotfiles/main/.zshrc
fi
