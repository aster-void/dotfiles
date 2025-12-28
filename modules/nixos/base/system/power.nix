# Power management settings for all hosts
{config, ...}: let
  profile =
    if config.my.base.power.profile == "stationary"
    then {
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 50;
      START_CHARGE_THRESH_BAT1 = 40;
      STOP_CHARGE_THRESH_BAT1 = 50;
    }
    else {
      START_CHARGE_THRESH_BAT0 = 60;
      STOP_CHARGE_THRESH_BAT0 = 80;
      START_CHARGE_THRESH_BAT1 = 60;
      STOP_CHARGE_THRESH_BAT1 = 80;
    };
in {
  services.power-profiles-daemon.enable = false;
  services.upower.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      inherit
        (profile)
        START_CHARGE_THRESH_BAT0
        STOP_CHARGE_THRESH_BAT0
        START_CHARGE_THRESH_BAT1
        STOP_CHARGE_THRESH_BAT1
        ;

      # CPU
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 40;

      # USB
      USB_AUTOSUSPEND = 1;
      USB_AUTOSUSPEND_DELAY_INIT = 3600; # 1 hour delay before suspend
      USB_BLACKLIST = "1e7d:2dcd 046d:c548"; # ROCCAT mouse & Logitech Bolt Receiver

      # GPU (Intel)
      INTEL_GPU_MIN_FREQ_ON_BAT = 300;
      INTEL_GPU_MAX_FREQ_ON_BAT = 500;
      INTEL_GPU_BOOST_FREQ_ON_BAT = 500;

      # GPU (AMD Radeon)
      RADEON_DPM_STATE_ON_AC = "performance";
      RADEON_DPM_STATE_ON_BAT = "battery";
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";

      # Platform profile (ThinkPad)
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Power saving
      BRIGHTNESS_ON_BAT = 25;
      WIFI_PWR_ON_BAT = "on";
      SOUND_POWER_SAVE_ON_BAT = 1;
      RUNTIME_PM_ON_BAT = "auto";
      PCIE_ASPM_ON_BAT = "powersupersave";
      NMI_WATCHDOG = 0;
    };
  };

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;

  # Use s2idle (suspend-to-idle) for faster wake and lower overhead
  boot.kernelParams = ["mem_sleep_default=s2idle"];
}
