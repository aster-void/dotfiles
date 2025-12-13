# Power management settings for all hosts
# Reduces power consumption when workload is low
{config, ...}: let
  profile = config.my.base.power.profile;

  # Profile-specific settings
  profiles = {
    boost = {
      cpuMaxPerfOnBat = 100;
      gpuMaxFreqOnBat = 1200;
      brightnessOnBat = 50;
      pcieAspmOnBat = "default";
      wifiPwrOnBat = "off";
      runtimePmOnBat = "on";
      batteryStart = 60;
      batteryStop = 80;
    };
    balanced = {
      cpuMaxPerfOnBat = 40;
      gpuMaxFreqOnBat = 500;
      brightnessOnBat = 25;
      pcieAspmOnBat = "powersupersave";
      wifiPwrOnBat = "on";
      runtimePmOnBat = "auto";
      batteryStart = 60;
      batteryStop = 80;
    };
    survival = {
      cpuMaxPerfOnBat = 20;
      gpuMaxFreqOnBat = 400;
      brightnessOnBat = 15;
      pcieAspmOnBat = "powersupersave";
      wifiPwrOnBat = "on";
      runtimePmOnBat = "auto";
      batteryStart = 60;
      batteryStop = 80;
    };
    # Always connected to power, maximize battery protection
    stationary = {
      cpuMaxPerfOnBat = 40;
      gpuMaxFreqOnBat = 500;
      brightnessOnBat = 25;
      pcieAspmOnBat = "default";
      wifiPwrOnBat = "off";
      runtimePmOnBat = "on";
      batteryStart = 40;
      batteryStop = 50;
    };
  };

  cfg = profiles.${profile};
in {
  # Disable conflicting power management service
  services.power-profiles-daemon.enable = false;

  # upower for battery status monitoring
  services.upower.enable = true;

  # TLP: power saving settings
  services.tlp = {
    enable = true;
    settings = {
      # CPU governor: powersave with intel_pstate still allows dynamic scaling
      # (schedutil is not available with intel_pstate in active mode)
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # Energy performance preference
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # USB autosuspend (saves power on idle USB devices)
      USB_AUTOSUSPEND = 1;

      # Battery charge thresholds (profile-dependent)
      START_CHARGE_THRESH_BAT0 = cfg.batteryStart;
      STOP_CHARGE_THRESH_BAT0 = cfg.batteryStop;
      START_CHARGE_THRESH_BAT1 = cfg.batteryStart;
      STOP_CHARGE_THRESH_BAT1 = cfg.batteryStop;

      # CPU performance limits on battery
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = cfg.cpuMaxPerfOnBat;

      # USB device exclusions (peripherals that shouldn't autosuspend)
      USB_BLACKLIST = "1e7d:2dcd 046d:c548"; # ROCCAT mouse & Logitech Bolt Receiver

      # Intel GPU frequency limits on battery
      INTEL_GPU_MIN_FREQ_ON_BAT = 300;
      INTEL_GPU_MAX_FREQ_ON_BAT = cfg.gpuMaxFreqOnBat;
      INTEL_GPU_BOOST_FREQ_ON_BAT = cfg.gpuMaxFreqOnBat;

      # Screen brightness on battery
      BRIGHTNESS_ON_BAT = cfg.brightnessOnBat;

      # WiFi power saving on battery
      WIFI_PWR_ON_BAT = cfg.wifiPwrOnBat;

      # Audio power saving (seconds of idle before suspend)
      SOUND_POWER_SAVE_ON_BAT = 1;

      # Runtime PM for PCI devices
      RUNTIME_PM_ON_BAT = cfg.runtimePmOnBat;

      # PCIe Active State Power Management
      PCIE_ASPM_ON_BAT = cfg.pcieAspmOnBat;

      # Disable CPU watchdog (saves power when debugging not needed)
      NMI_WATCHDOG = 0;
    };
  };

  # Enable basic power management
  powerManagement.enable = true;

  # powertop auto-tune on startup
  powerManagement.powertop.enable = true;
}
