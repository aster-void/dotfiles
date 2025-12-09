{inputs, ...}: {
  imports = [
    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default
    ./options.nix
    ./services
    ./system
  ];

  home-manager.backupFileExtension = "backup";
}
