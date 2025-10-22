{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.extensions.gaming;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Minecraft
      prismlauncher
      lunar-client
    ];
  };
}
