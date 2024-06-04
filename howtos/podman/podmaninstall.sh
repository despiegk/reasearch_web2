#!/bin/bash

# Function to handle errors
error_exit() {
  echo "Error: $1"
  exit 1
}

# Ensure Podman is installed
if ! command -v podman &> /dev/null
then
    echo "Podman could not be found, installing..."
    sudo pacman -Syu --noconfirm podman buildah  podman-docker || error_exit "Failed to install Podman"
fi


# Remove existing storage data
# sudo rm -rf /var/lib/containers/storage || error_exit "Failed to remove existing storage data"
# sudo mkdir -p /var/lib/containers/storage || error_exit "Failed to create storage directory"
# sudo chown -R $USER:$USER /var/lib/containers/storage || error_exit "Failed to change ownership of storage directory"

sudo pacman -S --noconfirm bridge-utils || error_exit "Failed to install bridge-utils"

# Restart Podman service
sudo systemctl restart podman || error_exit "Failed to restart Podman service"

# Check Podman service status
sudo systemctl status podman || error_exit "Podman service is not running correctly"

echo "Podman is set up and running with cni network backend."
echo "Podman is set up and running with vfs storage driver."
