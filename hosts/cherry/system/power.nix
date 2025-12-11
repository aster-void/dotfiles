# Carbon-specific power settings (laptop with battery)
{...}: {
  # Battery charge thresholds (ThinkPad specific)
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 40;
    STOP_CHARGE_THRESH_BAT0 = 60;
    START_CHARGE_THRESH_BAT1 = 40;
    STOP_CHARGE_THRESH_BAT1 = 60;

    # CPU performance limits on battery
    CPU_MIN_PERF_ON_AC = 0;
    CPU_MAX_PERF_ON_AC = 100;
    CPU_MIN_PERF_ON_BAT = 0;
    CPU_MAX_PERF_ON_BAT = 50;

    # USB device exclusions (peripherals that shouldn't autosuspend)
    USB_BLACKLIST = "1e7d:2dcd 046d:c548"; # ROCCAT mouse & Logitech Bolt Receiver

    # Intel GPU frequency limits on battery
    INTEL_GPU_MIN_FREQ_ON_BAT = 300;
    INTEL_GPU_MAX_FREQ_ON_BAT = 600;
    INTEL_GPU_BOOST_FREQ_ON_BAT = 600;

    # Screen brightness on battery
    BRIGHTNESS_ON_BAT = 30;
  };

  # upower for battery status monitoring
  services.upower.enable = true;
}
