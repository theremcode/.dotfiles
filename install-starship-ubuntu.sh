curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init bash)"' >> ~/.bashrc
source ~/.bashrc
mkdir -p ~/.config
wget -O ~/.config/starship.toml https://raw.githubusercontent.com/alexislepresle/dotfiles/main/starship.toml