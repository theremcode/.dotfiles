#!/bin/bash

# Array of tools to install
tools=("nano" "dos2unix" "jq" "curl" "wget" "git" "unzip" "zip" "unzip" "python3" "python3-pip" "python3-venv" "build-essential" "apt-transport-https" "ca-certificates" "software-properties-common" "gnupg" "zsh" "gpg" "tmux" "neofetch")

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


# install yq
if ! [ -x "$(command -v yq)" ]; then
    wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_arm64 -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq
else
    echo "Yq is already installed."
fi

# Check and config eza
if ! [ -x "$(command -v eza)" ]; then
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
else
    echo "Eza is already installed."
fi

# Function to install a font
install_font() {
    local url=$1
    local font_name=$2
    temp_dir=$(mktemp -d)
    wget -O "$temp_dir/$font_name.zip" "$url"
    unzip "$temp_dir/$font_name.zip" -d "$temp_dir"
    mkdir -p ~/.local/share/fonts
    mv "$temp_dir"/*.ttf ~/.local/share/fonts/
    fc-cache -f -v
    rm -rf "$temp_dir"
    echo "$font_name installed successfully."
}

# Install JetBrains Mono Nerd Font
install_font "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip" "JetBrainsMono"

# Verify the installation
if fc-list | grep -qi "JetBrainsMono"; then
    echo "JetBrains Mono Nerd Font is successfully installed."
else
    echo "Failed to install JetBrains Mono Nerd Font."
fi

# Verify the installation
if fc-list | grep -i "JetBrains Mono Nerd Font"; then
    echo "JetBrains Mono Nerd Font is successfully installed."
else
    echo "Failed to install JetBrains Mono Nerd Font."
fi

# Check and config zsh
if ! [ -x "$(command -v zsh)" ]; then
    echo 'source ~/.zshrc' >> ~/.zshrc
    sudo mkdir -p ~/.zsh
    sudo wget -O ~/.zsh/aliases.zsh https://raw.githubusercontent.com/theremcode/.dotfiles/main/.zsh/aliases.zsh
    sudo chsh -s /usr/bin/zsh
    source ~/.zshrc
else
    sudo mkdir -p ~/.zsh
    sudo wget -O ~/.zsh/aliases.zsh https://raw.githubusercontent.com/theremcode/.dotfiles/main/.zsh/aliases.zsh
    sudo wget -O ~/.zshrc https://raw.githubusercontent.com/theremcode/.dotfiles/main/.zshrc
    sudo chsh -s /usr/bin/zsh
    source ~/.zshrc
    echo "Zsh is already installed."
fi

# Check and install Starship
if ! [ -x "$(command -v starship)" ]; then
    sudo curl -sS https://starship.rs/install.sh | sh
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
    sudo mkdir -p ~/.config
    sudo wget -O ~/.config/starship.toml https://raw.githubusercontent.com/theremcode/.dotfiles/main/.config/starship.toml
    source ~/.zshrc
else
    wget -O ~/.config/starship.toml https://raw.githubusercontent.com/theremcode/.dotfiles/main/.config/starship.toml
    source ~/.zshrc
    echo "Starship is already installed."
fi

# Check and install Azure CLI
if ! [ -x "$(command -v az)" ]; then
    sudo curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
else
    echo "Azure CLI is already installed."
fi

# Determine system architecture
ARCH=$(uname -m)

# Check and install kubectl
if ! [ -x "$(command -v kubectl)" ]; then
    if [ "$ARCH" == "x86_64" ]; then
        KUBECTL_URL="https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    elif [ "$ARCH" == "aarch64" ]; then
        KUBECTL_URL="https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/arm64/kubectl"
    else
        echo "Unsupported architecture: $ARCH"
        exit 1
    fi

    curl -LO "$KUBECTL_URL"
    sudo chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
else
    echo "kubectl is already installed."
fi

# Check and install Helm
if ! [ -x "$(command -v helm)" ]; then
    sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    sudo chmod +x get_helm.sh
    ./get_helm.sh
    rm get_helm.sh
else
    echo "Helm is already installed."
fi

# Check and install Terraform
if ! [ -x "$(command -v terraform)" ]; then
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
    gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
    sudo apt-get install terraform
else
    echo "Terraform is already installed."
fi

# Check and install OCI CLI
if ! [ -x "$(command -v oci)" ]; then
    sudo bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
else
    echo "OCI CLI is already installed."
fi

sudo apt install zsh-autosuggestions zsh-syntax-highlighting

chsh -s /usr/bin/zsh
source ~/.zshrc
