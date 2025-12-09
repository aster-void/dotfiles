{flake, ...}: {
  imports = [
    flake.nixosModules.base
    flake.nixosModules.profile-dev
    ./hardware-configuration.nix
    ./system
    ./services
  ];
}
