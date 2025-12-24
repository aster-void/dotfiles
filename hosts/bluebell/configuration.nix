{flake, ...}: {
  networking.hostName = "bluebell";

  imports =
    [
      flake.nixosModules.base
      flake.nixosModules.profile-dev
      ./hardware-configuration.nix
    ]
    ++ flake.lib.collectFiles ./services;
}
