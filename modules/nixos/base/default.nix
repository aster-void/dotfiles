{
  inputs,
  flake,
  ...
}: {
  imports =
    [
      inputs.comin.nixosModules.comin
      inputs.agenix.nixosModules.default
      # inputs.determinate.nixosModules.default
      ./options.nix
    ]
    ++ flake.lib.collectFiles ./services
    ++ flake.lib.collectFiles ./system;

  home-manager.backupFileExtension = "backup";
  home-manager.useGlobalPkgs = false;
  home-manager.extraSpecialArgs = {inherit inputs flake;};
  home-manager.sharedModules = [
    {nixpkgs.config.allowUnfree = true;}
  ];
}
