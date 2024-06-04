#!/bin/bash

# Function to handle errors
error_exit() {
  echo "Error: $1"
  #exit 1
}

echo "Stopping all running containers..."
podman stop -a || error_exit "Failed to stop running containers"

echo "Removing all containers..."
podman rm -a || error_exit "Failed to remove containers"

echo "Removing all images..."
podman rmi -a -f || error_exit "Failed to remove images"

echo "Removing all volumes..."
podman volume rm $(podman volume ls -q) || error_exit "Failed to remove volumes"

echo "Cleaning up storage..."
sudo rm -rf /var/lib/containers || error_exit "Failed to clean up storage"
sudo rm -rf /etc/containers || error_exit "Failed to remove Podman and Buildah configuration"

rm -f /usr/local/bin/podman

echo "Uninstalling Podman and Buildah..."
sudo pacman -Rns --noconfirm podman buildah || error_exit "Failed to uninstall Podman and Buildah"

echo "Removing Podman and Buildah binaries..."
sudo rm -rf /usr/bin/podman || error_exit "Failed to remove Podman binaries"
sudo rm -rf /usr/bin/buildah || error_exit "Failed to remove Buildah binaries"

echo "Removing any remaining configuration files..."
sudo rm -rf ~/.config/containers || error_exit "Failed to remove user configuration files"


echo "Podman and Buildah have been completely removed from the system."
