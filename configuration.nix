# ~/.dotfiles/configuration.nix (Managed via Flake)
# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system/hardware.nix
    ./modules/system/desktop.nix
    ./modules/system/power.nix
  ];

  # =========================================
  # Nix & Flakes Configuration
  # =========================================
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # =========================================
  # Networking
  # =========================================
  networking.networkmanager.enable = true;

  # =========================================
  # Time & Localization
  # =========================================

  # Auto-detect timezone via GeoIP - appropriate for a portable USB stick
  services.automatic-timezoned.enable = true;

  # Keep the hardware clock in local time to avoid messing up Windows host clocks
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";

  # =========================================
  # User Accounts
  # =========================================

  # Enable Zsh system-wide
  programs.zsh.enable = true;
  
  users.users.ayan = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" ]; # Enable 'sudo' for the user.
    shell = pkgs.zsh; # Set default shell to Zsh
  };

  # =========================================
  # System Packages & Software
  # =========================================
  
  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    nano
    vim
    wget
    git
  ];

  # =========================================
  # System State Version (DO NOT CHANGE)
  # =========================================
  
  system.stateVersion = "26.05"; 

}
