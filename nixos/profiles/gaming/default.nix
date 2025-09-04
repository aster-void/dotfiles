{
  lib,
  config,
  ...
}: let
  cfg = config.profiles.gaming;
in {
  options.profiles.gaming.enable = lib.mkEnableOption "Enable gaming profile";

  config = lib.mkIf cfg.enable {
    imports = [
      ./steam.nix
      ./flatpak-games.nix
    ];

    # Gaming-optimized settings
    programs.gamemode.enable = true;
  };
}
