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
    services.flatpak.remotes = [
      {
        name = "launcher.moe";
        location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
      }
    ];
    services.flatpak.packages = [
      "org.gnome.Platform//49"
      "org.freedesktop.Platform.GL.nvidia-590-44-01//1.4"
      "org.freedesktop.Platform.GL32.nvidia-590-44-01//1.4"
      {
        appId = "moe.launcher.the-honkers-railway-launcher";
        origin = "launcher.moe";
      }
      {
        appId = "moe.launcher.sleepy-launcher";
        origin = "launcher.moe";
      }
      {
        appId = "io.mrarm.mcpelauncher";
        origin = "flathub";
      }
    ];
  };
}
