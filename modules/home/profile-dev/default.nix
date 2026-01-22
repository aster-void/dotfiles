{
  lib,
  flake,
  inputs,
  config,
  ...
}: {
  nixpkgs.overlays = [
    (_final: _prev: {inherit inputs;})
    inputs.llm-agents.overlays.default
    # GCC 15 strict type fixes
    (_final: prev: {
      netcat-openbsd = prev.netcat-openbsd.override {
        stdenv = prev.gcc14Stdenv;
      };
    })
  ];

  imports =
    [
      ./packages.nix
    ]
    ++ flake.lib.collectFiles ./programs;

  home = {
    stateVersion = lib.mkDefault "25.11";
    sessionVariables.EDITOR = "hx";
    file.".local/bin/zz".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/github.com/aster-void/zz/zz.sh";
  };
}
