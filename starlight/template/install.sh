#!/bin/bash
set -e

# Define base directory
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export BASE_DIR
export NODE_DIR="$BASE_DIR/node_modules"

# Function to check if curl is installed
check_and_install_curl() {
    if ! command -v curl &> /dev/null; then
        echo "curl could not be found"

        # Detect OS and install curl
        if [ "$(uname)" == "Darwin" ]; then
            # macOS
            echo "Detected macOS. Installing curl with Homebrew..."
            if ! command -v brew &> /dev/null; then
                echo "Homebrew not found. Please install Homebrew first."
                exit 1
            fi
            brew install curl
        elif [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$NAME
            if [ "$OS" = "Ubuntu" ]; then
                echo "Detected Ubuntu. Installing curl..."
                sudo apt update
                sudo apt install -y curl
            elif [ "$OS" = "Arch Linux" ]; then
                echo "Detected Arch Linux. Installing curl..."
                sudo pacman -Sy
                sudo pacman -S --noconfirm curl
            else
                echo "Unsupported OS for automatic curl installation."
                exit 1
            fi
        else
            echo "OS not detected. Please install curl manually."
            exit 1
        fi
    fi
}

# Function to check and install nvm
check_and_install_nvm() {
    if ! command -v nvm &> /dev/null; then
        echo "nvm could not be found, installing nvm"

        # Install nvm
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

        # Source nvm script
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    else
        echo "nvm is already installed"
    fi
}

# Function to check and install npm via nvm
check_and_install_nvm_npm() {
    # Ensure nvm is installed
    check_and_install_nvm

    if ! command -v npm &> /dev/null; then
        echo "npm could not be found, installing npm via nvm"

        # Load nvm
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    else
        echo "npm is already installed"
    fi
}

# Ensure curl is installed
check_and_install_curl

# Ensure npm is installed
check_and_install_nvm_npm

# Use the specific node version
nvm install 20.14.0
nvm use 20.14.0

# Move to base directory and check if node modules directory exists
cd $BASE_DIR

if [ ! -d "$NODE_DIR" ]; then
    echo "Directory $NODE_DIR does not exist. Creating it and setting up an npm environment."
    npm install    
fi

echo "We're good to go, welcome to your npm environment"

bash start.sh