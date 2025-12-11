{
  inputs,
  flake,
  ...
}: {
  imports =
    [
      inputs.comin.nixosModules.comin
      inputs.agenix.nixosModules.default
      ./options.nix
    ]
    ++ flake.lib.collectFiles ./services
    ++ flake.lib.collectFiles ./system;

  home-manager.backupFileExtension = "backup";
}
