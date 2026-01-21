#!/usr/bin/env bash
set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <device> <host>"
    exit 1
fi

DEVICE=$1
HOST=$2
CONFIG=$(dirname $(readlink -f "$0"))
HOME="/mnt/home/jaimarl"

echo "Partitioning Drive..."
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko "$CONFIG"/disko.nix --argstr device "$DEVICE"

echo "Installing System..."
sudo nixos-generate-config --root /mnt
sudo rm -rf "$CONFIG"/hosts/"$HOST"/.hardware.nix
sudo mv /mnt/etc/nixos/hardware-configuration.nix "$CONFIG"/hosts/"$HOST"/.hardware.nix
sudo rm -rf /mnt/etc/nixos

sudo nixos-install --flake "$CONFIG"/#"$HOST"

sudo cp -ra "$CONFIG" "$HOME"/.nixos
