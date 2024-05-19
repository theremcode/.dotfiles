#!/bin/bash

# Array of tools to install
tools=("nano" "dos2unix" "yq" "jq" "curl" "wget" "git" "unzip" "zip" "python3" "python3-pip" "python3-venv" "build-essential" "apt-transport-https" "ca-certificates" "software-properties-common")

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
else
    echo "Starship is already installed."
fi

# Check and install Azure CLI
if ! [ -x "$(command -v az)" ]; then
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
else
    echo "Azure CLI is already installed."
fi

# Check and install kubectl
if ! [ -x "$(command -v kubectl)" ]; then
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
else
    echo "kubectl is already installed."
fi

# Check and install Helm
if ! [ -x "$(command -v helm)" ]; then
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    chmod +x get_helm.sh
    ./get_helm.sh
    rm get_helm.sh
else
    echo "Helm is already installed."
fi

# Determine system architecture
ARCH=$(uname -m)
if [ "$ARCH" == "x86_64" ]; then
    TERRAFORM_URL="https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip"
elif [ "$ARCH" == "aarch64" ]; then
    TERRAFORM_URL="https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_arm64.zip"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Check and install Terraform
if ! [ -x "$(command -v terraform)" ]; then
    curl -fsSL -o terraform.zip "$TERRAFORM_URL"
    unzip terraform.zip
    sudo mv terraform /usr/local/bin/
    rm terraform.zip
else
    echo "Terraform is already installed."
fi

# Check and install OCI CLI
if ! [ -x "$(command -v oci)" ]; then
    bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
else
    echo "OCI CLI is already installed."
fi
