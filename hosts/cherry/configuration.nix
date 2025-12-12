{flake, ...}: {
  networking.hostName = "cherry";

  imports =
    [
      flake.nixosModules.base
      flake.nixosModules.profile-dev
      ./hardware-configuration.nix
    ]
    ++ flake.lib.collectFiles ./system
    ++ flake.lib.collectFiles ./services;
}
