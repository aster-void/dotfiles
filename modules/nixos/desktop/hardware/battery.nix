# Desktop-specific battery settings (laptops using desktop module)
# Base power settings are inherited from modules/nixos/base/system/power.nix
{
  # upower for battery status in desktop environments
  services.upower.enable = true;

  # Additional TLP settings for desktop laptops
  services.tlp.settings = {
    # Battery charge thresholds
    START_CHARGE_THRESH_BAT0 = 65;
    STOP_CHARGE_THRESH_BAT0 = 85;

    # CPU performance limits on battery
    CPU_MIN_PERF_ON_AC = 0;
    CPU_MAX_PERF_ON_AC = 100;
    CPU_MIN_PERF_ON_BAT = 0;
    CPU_MAX_PERF_ON_BAT = 50;

    # USB device exclusions
    USB_BLACKLIST = "1e7d:2dcd 046d:c548"; # ROCCAT mouse & Logitech Bolt Receiver

    # Intel GPU frequency limits on battery
    INTEL_GPU_MIN_FREQ_ON_BAT = 300;
    INTEL_GPU_MAX_FREQ_ON_BAT = 600;
    INTEL_GPU_BOOST_FREQ_ON_BAT = 600;

    # Screen brightness on battery
    BRIGHTNESS_ON_BAT = 30;
  };
}
