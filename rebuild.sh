#!/usr/bin/env bash
set -euo pipefail

# Dynamically find the directory where this script is located (the .dotfiles folder)
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

# Pre-flight checks
if ! command -v nixos-rebuild &>/dev/null; then
  echo "Error: nixos-rebuild not found. This script must run on NixOS." >&2
  exit 1
fi

if [[ ! -f "$DIR/flake.nix" ]]; then
  echo "Error: flake.nix not found in $DIR" >&2
  exit 1
fi

# Nix Flakes ignore files that are not tracked by Git.
# This automatically stages all new or modified files before building.
git -C "$DIR" add .

echo "Rebuilding Portable NixOS..."

# Execute the NixOS rebuild targeting the "portable" configuration in the flake.nix
exec sudo nixos-rebuild switch --flake "$DIR#portable"
