# ~/.dotfiles/configuration.nix (Managed via Flake)
# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # =========================================
  # Bootloader & Hardware
  # =========================================
  
  # Portable USB Bootloader settings
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true; 
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = false;

  # Ensure maximum hardware compatibility for Wi-Fi/Bluetooth on random laptops
  hardware.enableRedistributableFirmware = true;

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
  
  time.timeZone = "Europe/Vienna"; # Comment out if not in Vienna
  #services.automatic-timezoned.enable = true;

  # Keep the hardware clock in local time to avoid messing up Windows host clocks
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";

  # =========================================
  # Desktop Environment (GNOME & X11)
  # =========================================
  
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # =========================================
  # Sound / Audio (Pipewire)
  # =========================================
  
  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # =========================================
  # User Accounts
  # =========================================

  # Enable Zsh system-wide
  programs.zsh.enable = true;
  
  users.users.ayan = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
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
  # Power Management & Battery Thresholds
  # =========================================
  
  # GNOME's default power daemon 
  services.power-profiles-daemon.enable = true;

  # Disable TLP to prevent conflicts
  services.tlp.enable = false;

  # Hardware-agnostic battery threshold via Udev 
  # (Replaces systemd oneshot to ensure it persists across sleep/wake and AC plug events)
  services.udev.extraRules = ''
    # Apply standard end threshold (Framework, Asus, etc.) 
    ACTION=="add|change", SUBSYSTEM=="power_supply", KERNEL=="BAT*", ATTR{charge_control_end_threshold}="60"
    
    # Apply legacy stop threshold (ThinkPads, older Lenovo)
    ACTION=="add|change", SUBSYSTEM=="power_supply", KERNEL=="BAT*", ATTR{charge_stop_threshold}="60"
  '';


  # =========================================
  # System State Version (DO NOT CHANGE)
  # =========================================
  
  system.stateVersion = "26.05"; 

}
