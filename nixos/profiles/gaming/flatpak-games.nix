{
  inputs,
  lib,
  config,
  ...
}: {
  # Gaming applications via Flatpak
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  services.flatpak = {
    remotes = [
      {
        name = "launcher.moe";
        location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
      }
    ];
    packages = [
      # Game launchers available but not currently installed:
      # - moe.launcher.the-honkers-railway-launcher (Star Rail)
      # - moe.launcher.sleepy-launcher (Genshin Impact)
      {
        appId = "io.mrarm.mcpelauncher";
        origin = "flathub";
      }
    ];
  };
}
