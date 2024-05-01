#!/bin/bash
# check if wget is install and if not install it
if ! [ -x "$(command -v wget)" ]; then
    sudo apt update
    sudo apt install wget
fi
#check if brew is installed and if not install it
if ! [ -x "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# check if warp is installed and if not install it
if ! [ -x "$(command -v warp)" ]; then
    brew install warp
    mkdir -p ~/.warp/themes
    wget -O ~/.warp/themes/dark.yaml https://raw.githubusercontent.com/theremcode/.dotfiles/main/.warp/themes/dark.yml
fi

# c
if ! [ -x "$(command -v starship)" ]; then
    brew install starship
    mkdir -p ~/.config
    wget -O ~/.config/starship.toml https://raw.githubusercontent.com/theremcode/.dotfiles/main/.config/starship.toml
fi

# check if oh my zsh is installed and if not install it
if ! [ -d ~/.oh-my-zsh ]; then
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    wget -O ~/.zshrc https://raw.githubusercontent.com/theremcode/.dotfiles/main/.zshrc
fi
