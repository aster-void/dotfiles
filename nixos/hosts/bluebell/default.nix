{
  flake,
  config,
  pkgs,
  ...
}:
{
  networking.hostName = "bluebell";

  users.users.claude = {
    isNormalUser = true;
    home = "/home/claude";
    createHome = true;
    extraGroups = [
      "wheel"
      "users"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = config.meta.sshAuthorizedKeys;
  };

  imports = [
    ../../modules/base
    ../../modules/profile-dev
    ../../modules/profile-server
    ./hardware-configuration.nix
  ]
  ++ flake.lib.collectFiles ./services;
}
