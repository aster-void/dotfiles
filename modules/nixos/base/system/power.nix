# Power management settings for all hosts
# Reduces power consumption when workload is low
{
  # Disable conflicting power management service
  services.power-profiles-daemon.enable = false;

  # TLP: basic power saving settings (common to all hosts)
  services.tlp = {
    enable = true;
    settings = {
      # CPU governor: schedutil adjusts dynamically based on load
      CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

      # Energy performance preference
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # USB autosuspend (saves power on idle USB devices)
      USB_AUTOSUSPEND = 1;
    };
  };

  # Enable basic power management
  powerManagement.enable = true;

  # powertop auto-tune on startup
  powerManagement.powertop.enable = true;
}
