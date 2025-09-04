{...}: {
  imports = [
    ./common.nix
    ../modules/desktop
    ../modules/games
    ../packages
  ];

  # Desktop workstation common settings
  services.displayManager.defaultSession = "hyprland-uwsm";
  my.apps.games.enable = true;
}
