{
  pkgs,
  config,
  lib,
  flake,
  ...
}: {
  imports = [
    ./services
  ];
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
