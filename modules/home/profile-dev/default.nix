{
  lib,
  flake,
  inputs,
  ...
}: {
  nixpkgs.overlays = [
    (_final: _prev: {inherit inputs;})
    inputs.edgepkgs.overlays.default
  ];

  imports =
    [
      ./packages.nix
    ]
    ++ flake.lib.collectFiles ./programs;

  home = {
    stateVersion = lib.mkDefault "26.05";
    sessionVariables.EDITOR = "hx";
  };
}
