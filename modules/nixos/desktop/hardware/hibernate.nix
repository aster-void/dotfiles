# Hibernate support via swapfile
{
  config,
  lib,
  ...
}: let
  cfg = config.my.desktop.hibernate;
  enabled = cfg.resumeDevice != null;
in {
  config = lib.mkIf enabled {
    swapDevices = [
      {
        device = "/swapfile";
        size = 18 * 1024; # 18GB, enough for 16GB RAM
      }
    ];

    boot.resumeDevice = cfg.resumeDevice;

    boot.kernelParams =
      lib.optional (cfg.resumeOffset != null)
      "resume_offset=${toString cfg.resumeOffset}";

    services.logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "suspend-then-hibernate";
      # Idle 15min -> suspend
      extraConfig = ''
        IdleAction=suspend-then-hibernate
        IdleActionSec=15min
      '';
    };

    # 30min in suspend -> hibernate
    systemd.sleep.extraConfig = ''
      HibernateDelaySec=30min
    '';
  };
}
