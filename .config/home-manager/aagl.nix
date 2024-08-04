{ config, pkgs, ... }:
let
  aagl-gtk-on-nix = import (builtins.fetchTarball "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz");
  # aaglPkgs = aagl-gtk-on-nix.withNixpkgs pkgs
in
{
  home.packages = with aagl-gtk-on-nix; [
    anime-game-launcher
    honkers-railway-launcher
  ];
}
