{
  lib,
  flake,
  inputs,
  config,
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
    file.".local/bin/zz".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/github.com/aster-void/zz/zz.sh";
  };
}
