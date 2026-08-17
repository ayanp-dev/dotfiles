# Desktop environment and audio configuration
{ pkgs, ... }:
{
  # =========================================
  # Desktop Environment (GNOME on Wayland)
  # =========================================
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # =========================================
  # Sound / Audio (Pipewire)
  # =========================================
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
