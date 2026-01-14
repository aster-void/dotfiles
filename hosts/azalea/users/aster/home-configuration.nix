{flake, ...}: {
  imports = [
    flake.homeModules.profile-dev
    flake.homeModules.desktop
  ];

  my.desktop.gaming.enable = true;
}
