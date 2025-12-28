{flake, ...}: {
  networking.hostName = "bluebell";

  imports =
    [
      flake.nixosModules.base
      flake.nixosModules.profile-dev
      flake.nixosModules.profile-server
      ./hardware-configuration.nix
    ]
    ++ flake.lib.collectFiles ./services;
}
