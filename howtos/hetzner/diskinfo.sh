#!/bin/bash
set -ex
# Function to handle errors
error_exit() {
  echo "Error: $1"
  exit 1
}

# Identify physical disks (excluding loop devices)
disks=$(lsblk -dno NAME,TYPE | grep -w "disk" | awk '{print $1}')
[ -z "$disks" ] && error_exit "No physical disks found."

echo "Disks:" 
echo $disks

echo "Btrfs configuration on SSDs:"

# Loop through each disk and check for Btrfs filesystems
for disk in $disks; do
  partitions=$(lsblk -no NAME /dev/$disk | tail -n +2)
  for partition in $partitions; do
    if blkid /dev/$partition | grep -q 'TYPE="btrfs"'; then
      echo "Found Btrfs filesystem on /dev/$partition"
      echo "Filesystem information:"
      btrfs filesystem show /dev/$partition || error_exit "Failed to show Btrfs filesystem information"
      echo "Mounted at:"
      mount | grep /dev/$partition || echo "Not mounted"
      echo "Btrfs device stats:"
      btrfs device stats /dev/$partition || error_exit "Failed to retrieve Btrfs device stats"
      echo "Btrfs filesystem usage:"
      btrfs filesystem df /dev/$partition || error_exit "Failed to retrieve Btrfs filesystem usage"
      echo "Btrfs filesystem status:"
      btrfs filesystem usage /dev/$partition || error_exit "Failed to retrieve Btrfs filesystem status"
      echo "----------------------------------------"
    fi
  done
done

echo "Btrfs configuration listing completed."