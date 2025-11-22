{
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/aster-void/dotfiles";
        branches.main.name = "main";
        poller.period = 10 * 60; # every 10 minutes
      }
    ];
  };

  # Limit comin CPU usage to 50%
  systemd.services.comin.serviceConfig.CPUQuota = "50%";
}
