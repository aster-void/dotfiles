{flake, ...}: {
  imports = [
    flake.nixosModules.base
    flake.nixosModules.profile-dev
    ./hardware-configuration.nix
    ./system
    ./services
  ];

  my.base.comin.pollerPeriod = 15;
}
