{flake, ...}: {
  networking.hostName = "azalea";
  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  imports = [
    flake.nixosModules.base
    flake.nixosModules.profile-dev
    flake.nixosModules.desktop
    ./hardware-configuration.nix
  ];

  my.profiles.desktop.enable = true;
  my.boot.enableLanzaboote = true;
}
