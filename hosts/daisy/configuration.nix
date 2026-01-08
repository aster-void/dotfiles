{flake, ...}: {
  networking.hostName = "daisy";

  imports = [
    flake.nixosModules.base
    flake.nixosModules.profile-dev
    flake.nixosModules.desktop
    ./hardware-configuration.nix
  ];

  my.desktop.gaming.enable = true;
  my.nixos.devMode = true;
  my.boot.enableLanzaboote = true;
}
