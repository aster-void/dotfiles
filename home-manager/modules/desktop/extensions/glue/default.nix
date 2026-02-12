{
  pkgs,
  config,
  lib,
  flake,
  ...
}: {
  imports =
    flake.lib.collectFiles ./services
    ++ flake.lib.collectFiles ./programs;

  config = let
    cfg = config.my.desktop.shells.glue;
    inherit (pkgs.stdenv.hostPlatform) system;
  in
    lib.mkIf cfg.enable {
      home.packages = [
        flake.packages.${system}.wpick
      ];
    };
}
