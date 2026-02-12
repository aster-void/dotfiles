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

  # Automatic security updates
  system.autoUpgrade = {
    enable = true;
    flake = "github:aster-void/dotfiles";
    flags = ["--refresh"];
    dates = "04:00";
    allowReboot = false;
  };
}
