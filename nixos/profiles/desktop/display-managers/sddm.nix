{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.profiles.desktop;
in {
  services = lib.mkIf cfg.enable {
    xserver.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
    };
  };

  # Install SDDM theme and required Qt6 dependencies
  environment.systemPackages = lib.mkIf cfg.enable [
    pkgs.sddm-astronaut
    pkgs.kdePackages.qtmultimedia
  ];
}
