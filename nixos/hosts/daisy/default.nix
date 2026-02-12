{...}: {
  networking.hostName = "daisy";

  imports = [
    ../../modules/base
    ../../modules/profile-dev
    ../../modules/desktop
    ./hardware-configuration.nix
  ];

  my.desktop.gaming.enable = true;
  my.nixos.devMode = true;
  my.boot.enableLanzaboote = true;
}
