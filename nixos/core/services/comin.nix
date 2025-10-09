{
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/aster-void/dotfiles";
        branches.main.name = "main";
        poller.period = 1 * 60; # every minute
      }
    ];
  };
}
