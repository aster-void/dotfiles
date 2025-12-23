{flake, ...}: {
  imports = [
    flake.homeModules.profile-dev
    flake.homeModules.desktop
  ];

  my.desktop = {
    gaming.enable = true;
    shells.glue.enable = true;
    shells.glue.type = "glass";
  };
  my.hyprland = {
    primaryMonitor = "eDP-1";
    sensitivity = "0.3";
    touchpadScrollFactor = "0.15";
    mirrorSecondary = false;
  };
}
