{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.desktop.gaming;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Minecraft
      prismlauncher
      lunar-client

      # Game managers
      lutris
    ];

    # Gaming-specific flatpak packages (base config in ../flatpak.nix)
    services.flatpak.packages = [
      "org.gnome.Platform//49"
      "org.freedesktop.Platform.GL.nvidia-590-44-01//1.4"
      "org.freedesktop.Platform.GL32.nvidia-590-44-01//1.4"
      "moe.launcher.the-honkers-railway-launcher"
      "moe.launcher.sleepy-launcher"
      "io.mrarm.mcpelauncher"
    ];
  };
}
