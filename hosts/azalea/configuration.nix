{flake, ...}: {
  networking.hostName = "azalea";
  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  imports = [
    flake.nixosModules.base
    flake.nixosModules.profile-dev
    flake.nixosModules.desktop
    ./hardware-configuration.nix
    ./fixes.nix
  ];

  my.desktop.gaming.enable = true;
  my.boot.enableLanzaboote = true;
}
