{
  config,
  lib,
  ...
}: let
  cfg = config.my.profiles.desktop;
in {
  services = lib.mkIf cfg.enable {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };
}
