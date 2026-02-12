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
}
