{pkgs, ...}: {
  # Prevent sleep on lid close and idle
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
    HandlePowerKey = "poweroff";
    IdleAction = "ignore";
  };

  # Disable sleep/hibernate
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  # Console auto-logout after 5 minutes
  programs.bash.interactiveShellInit = ''
    export TMOUT=300
    readonly TMOUT
  '';

  # Basic firewall (SSH already allowed in base)
  networking.firewall.enable = true;

  # Fail2ban for SSH brute-force protection
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "1h";
    bantime-increment = {
      enable = true;
      maxtime = "48h";
      factor = "4";
    };
  };

  # Automatic security updates
  system.autoUpgrade = {
    enable = true;
    flake = "github:aster-void/dotfiles";
    flags = ["--refresh"];
    dates = "04:00";
    allowReboot = false;
  };

  environment.systemPackages = with pkgs; [
    htop
    iotop
    ncdu
  ];
}
