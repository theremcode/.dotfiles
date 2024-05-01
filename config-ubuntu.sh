#!/bin/bash
# Array of tools to install
tools=("wget" "svn" "zsh")

# Loop through the array and check if each tool is installed
for tool in "${tools[@]}"; do
    if ! [ -x "$(command -v $tool)" ]; then
        # Install the tool
        sudo apt update -y
        sudo apt update install $tool -y
    fi
done

# check if starship is installed and if not install it
if ! [ -x "$(command -v starship)" ]; then
    curl -sS https://starship.rs/install.sh | sh
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
    mkdir -p ~/.config
    wget -O ~/.config/starship.toml https://raw.githubusercontent.com/theremcode/.dotfiles/main/.config/starship.toml
    source ~/.bashrc
fi
    
# check if oh my zsh is installed and if not install it
if ! [ -d ~/.oh-my-zsh ]; then
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    wget -O ~/.zshrc https://raw.githubusercontent.com/theremcode/.dotfiles/main/.zshrc
fi

# Check if the line exists in .bashrc
if grep -q "source ~/.zshrc" ~/.bashrc; then
    echo "The line 'source ~/.zshrc' is already in your .bashrc file."
else
    # If the line doesn't exist, add it to .bashrc
    echo "Adding 'source ~/.zshrc' to your .bashrc file..."
    echo "source ~/.zshrc" >> ~/.bashrc
    echo "Line added successfully."
fi
