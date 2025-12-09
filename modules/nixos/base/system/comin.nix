{config, ...}: {
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/aster-void/dotfiles.git";
        branches.main.name = "main";
        poller.period = 5;
      }
    ];
  };
}
