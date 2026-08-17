# ~/.dotfiles/home.nix
{ config, pkgs, dotfilesPath, ... }:

{
  imports = [
    ./modules/home/packages.nix
    ./modules/home/shell.nix
    ./modules/home/symlinks.nix
  ];

  # =========================================
  # Core User Configuration
  # =========================================
  home.username = "ayan";
  home.homeDirectory = "/home/ayan";
  home.stateVersion = "26.05"; # Must match the system state version
}
