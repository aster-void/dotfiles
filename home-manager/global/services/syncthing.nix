{
  config,
  lib,
  ...
}: let
  wallpapersDir = "${config.home.homeDirectory}/Pictures/Wallpapers";
in {
  services.syncthing = {
    enable = true;
    settings = {
      folders = {
        "wallpapers" = {
          id = "wallpapers";
          label = "Wallpapers";
          path = wallpapersDir;
          type = "sendreceive";
        };
      };
    };
  };

  home.activation.createWallpapersDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${wallpapersDir}
  '';
}
