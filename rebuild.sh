#!/usr/bin/env bash
set -euo pipefail

# Dynamically find the directory where this script is located (the  /.dotfiles folder)
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

# Nix Flakes ignore files that are not tracked by Git. 
# This automatically stages all new or modified files before building.
git -C "$DIR" add .

echo "Rebuilding Portable NixOS..."

# Execute the NixOS rebuild targeting the "portable" configuration in the flake.nix
exec sudo nixos-rebuild switch --flake "$DIR#portable"
