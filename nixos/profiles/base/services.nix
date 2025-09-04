{pkgs, ...}: {
  # Essential services for any NixOS system
  services = {
    printing.enable = true;

    locate = {
      enable = true;
      interval = "hourly";
    };

    # Automatic system updates from git
    comin = {
      enable = true;
      remotes = [
        {
          name = "origin";
          url = "https://github.com/aster-void/nixos-config.git";
          branches.main.name = "main";
          poller.period = 3 * 3600;
        }
      ];
    };
  };

  # Environment programs
  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
    silent = true;
    loadInNixShell = true;
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };
}
