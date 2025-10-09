{pkgs, ...}: {
  hardware.graphics.extraPackages = [pkgs.intel-media-driver];

  my.apps.games.enable = true;
}
