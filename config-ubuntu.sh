#!/bin/bash

# Install Starship
curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init bash)"' >> ~/.bashrc
source ~/.bashrc

# Install Oh My zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"


mkdir -p ~/.config
wget -O ~/.config/starship.toml https://raw.githubusercontent.com/alexislepresle/dotfiles/main/starship.toml