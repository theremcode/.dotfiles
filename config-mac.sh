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
# Install Starship
brew install starship
mkdir -p ~/.config
wget -O ~/.config/starship.toml https://raw.githubusercontent.com/theremcode/.dotfiles/main/.config/starship.toml

# Install Oh My zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
wget -O ~/.zshrc https://raw.githubusercontent.com/theremcode/.dotfiles/main/.zshrc

