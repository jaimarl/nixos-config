#!/usr/bin/env bash
set -e

# Help
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: $0 <host> [device]"
    echo ""
    echo "Arguments:"
    echo "  <host>      Name of the host configuration in ./hosts/"
    echo "  [device]    (Optional) Target device for partitioning (e.g. /dev/sda)"
    echo "              If omitted, the script assumes drives are already partitioned and mounted at /mnt"
    exit 1
fi

# Variables
HOST=$1
DEVICE=$2
CONFIG=$(dirname $(readlink -f "$0"))


#---[ Host Validation ]------------------------------------------------------------------
# Check if host exist
if [ ! -d "$CONFIG/hosts/$HOST" ]; then
    echo "ERROR: Directory \"$CONFIG/hosts/$HOST\" not found"
    exit 1
fi

if ! grep -q "\"$HOST\" = " "$CONFIG/flake.nix"; then
    echo "ERROR: Host \"$HOST\" is not defined in $CONFIG/flake.nix"
    exit 1
fi

# Get username of host user
HOST_USER=$(grep -A 1 "\"$HOST\" = " "$CONFIG/flake.nix" | grep "user = " | sed -E 's/.*user = "([^"]+)".*/\1/')
if [ -z "$HOST_USER" ]; then
    echo "ERROR: Unable to get user for host \"$HOST\" in $CONFIG/flake.nix"
    exit 1
fi
HOME="/mnt/home/$HOST_USER"


#---[ Partitioning ]---------------------------------------------------------------------
# Define the used disko.nix
HOST_DISKO="$CONFIG/hosts/$HOST/disko.nix"
DEFAULT_DISKO="$CONFIG/disko.nix"
if [ -f "$HOST_DISKO" ]; then
    DISKO_CONFIG="$HOST_DISKO"
else
    DISKO_CONFIG="$DEFAULT_DISKO"
fi

# Partition device
if [ -n "$DEVICE" ]; then
    echo "WARNING: This will erase all data on $DEVICE"
    read -p "Are you sure you want to proceed with partitioning? (y/N): " confirm
    if [[ ! $confirm == [yY] && ! $confirm == [yY][eE][sS] ]]; then
        echo -e "\nInstallation canceled by user"
        exit 1
    fi
    SECONDS=0

    echo -e "\nPartitioning Drive..."
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko "$DISKO_CONFIG" --argstr device "$DEVICE"
else
    echo "WARNING: No device specified. Proceeding with installation on currently mounted partitions at /mnt"
    read -p "Ensure your drives are mounted correctly. Continue? (y/N): " confirm
    if [[ ! $confirm == [yY] && ! $confirm == [yY][eE][sS] ]]; then
        echo -e "\nInstallation canceled by user"
        exit 1
    fi
    SECONDS=0
fi


#---[ Installing System ]----------------------------------------------------------------
# Check if /mnt is mountpoint
if ! mountpoint -q /mnt; then
    echo -e "Error: /mnt is not a mountpoint"
    exit 1
fi

# Generate hardware configuration
echo -e "\nGenerating hardware configuration..."
sudo nixos-generate-config --root /mnt
sudo rm -rf "$CONFIG"/hosts/"$HOST"/.hardware.nix
sudo mv /mnt/etc/nixos/hardware-configuration.nix "$CONFIG"/hosts/"$HOST"/.hardware.nix
sudo rm -rf /mnt/etc/nixos

# Install NixOS
echo -e "\nInstalling System..."
sudo nixos-install --flake "$CONFIG"/#"$HOST"

# Copy config to /home
sudo cp -ra "$CONFIG" "$HOME"/.nixos

echo "Time elapsed: $(($SECONDS / 60))h, $(($SECONDS %3600 / 60))m, $(($SECONDS % 60))s"
