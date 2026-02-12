{flake, ...}: {
  networking.hostName = "bluebell";

  imports =
    [
      ../../modules/base
      ../../modules/profile-dev
      ../../modules/profile-server
      ./hardware-configuration.nix
    ]
    ++ flake.lib.collectFiles ./services;
}
