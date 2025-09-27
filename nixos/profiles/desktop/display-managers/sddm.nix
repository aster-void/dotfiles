{
  config,
  lib,
  pkgs,
  my,
  ...
}: let
  cfg = config.my.profiles.desktop;
in {
  services = lib.mkIf cfg.enable {
    xserver.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs; [
        kdePackages.qtmultimedia
        kdePackages.qtsvg
        kdePackages.qtdeclarative
        kdePackages.qtvirtualkeyboard
      ];
    };
  };

  environment.systemPackages = [my.pkgs.sddmThemes.sddm-astronaut-theme];
}
