{
  imports = [
    ./direnv.nix
    ./systemd.nix
    ./security.nix
    ./network.nix
    ./comin.nix
    ./shell.nix
    ./flatpak.nix
    ./git.nix
    ./wine.nix
  ];

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
    # printing.drivers = [pkgs.cnijfilter2];

    # Enable comin for automatic rebuilds from GitHub

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    locate = {
      enable = true;
      interval = "hourly";
    };
  };
}
