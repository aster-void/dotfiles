{config, ...}: {
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/aster-void/dotfiles.git";
        branches.main.name = "main";
        poller.period = config.my.base.comin.pollerPeriod;
      }
    ];
  };
}
