# Portable USB boot and hardware compatibility settings
{ ... }:
{
  # Portable USB Bootloader settings
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = false;

  # Ensure maximum hardware compatibility for Wi-Fi/Bluetooth on random laptops
  hardware.enableRedistributableFirmware = true;
}
