#!/bin/bash
set -ex

check_and_install_mosh() {
    if ! command -v  &> /dev/null; then
        echo "mosh could not be found"

        # Detect OS and install mosh
        if [ "$(uname)" == "Darwin" ]; then
            # macOS
            echo "Detected macOS. Installing mosh with Homebrew..."
            if ! command -v brew &> /dev/null; then
                echo "Homebrew not found. Please install Homebrew first."
                exit 1
            fi
            brew install mosh
        elif [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$NAME
            if [ "$OS" = "Ubuntu" ]; then
                echo "Detected Ubuntu. Installing mosh..."
                sudo apt update
                sudo apt install -y mosh
            elif [ "$OS" = "Arch Linux" ]; then
                echo "Detected Arch Linux. Installing mosh..."
                sudo pacman -Sy
                sudo pacman -S --noconfirm mosh
            else
                echo "Unsupported OS for automatic mosh installation."
                exit 1
            fi
        else
            echo "OS not detected. Please install mosh manually."
            exit 1
        fi
    fi
}


check_and_install_mosh()

