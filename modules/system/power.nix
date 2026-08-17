# Power management and battery charge thresholds
{ ... }:
{
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
}
