{
  lib,
  config,
  ...
}: {
  services.flatpak = lib.mkIf config.my.profiles.gaming.enable {
    remotes = [
      # {
      #   name = "launcher.moe";
      #   location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
      # }
    ];
    packages = [
      # {
      #   appId = "moe.launcher.the-honkers-railway-launcher";
      #   origin = "launcher.moe";
      # }
      # {
      #   appId = "moe.launcher.sleepy-launcher";
      #   origin = "launcher.moe";
      # }
      {
        appId = "io.mrarm.mcpelauncher";
        origin = "flathub";
      }
    ];
  };
}
