{
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  myPkgs = inputs.nix-repository.packages.${system};
in {
  services = {
    xserver.enable = true;
    displayManager = {
      defaultSession = "hyprland-uwsm";
      sddm = {
        enable = true;
        wayland.enable = true;
        # Force KDE's sddm package for Qt6/Wayland compatibility
        package = lib.mkForce pkgs.kdePackages.sddm;
        theme = "sddm-astronaut-theme";
        extraPackages = with pkgs; [
          kdePackages.qtmultimedia
          kdePackages.qtsvg
          kdePackages.qtdeclarative
          kdePackages.qtvirtualkeyboard
        ];
        settings = {
          General = {
            ScreenTimeout = 300;
          };
        };
      };
    };
  };

  environment.systemPackages = [myPkgs.sddm-astronaut-theme];
}
