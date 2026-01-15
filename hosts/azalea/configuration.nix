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
  my.desktop.hibernate.resumeDevice = "/dev/disk/by-uuid/ea447cc3-a371-4a61-aec3-9f77ab6571c1";
  my.boot.enableLanzaboote = true;
}
