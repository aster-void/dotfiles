# Desktop environment module (Hyprland-based)
{
  lib,
  config,
  inputs,
  flake,
  ...
}: let
  cfg = config.my.profiles.desktop;
in {
  imports =
    [
      inputs.nix-flatpak.nixosModules.nix-flatpak
      inputs.lanzaboote.nixosModules.lanzaboote
      ./options.nix
      ./packages.nix
    ]
    ++ flake.lib.collectFiles ./extensions
    ++ flake.lib.collectFiles ./hardware
    ++ flake.lib.collectFiles ./services
    ++ flake.lib.collectFiles ./system;

  config = lib.mkIf cfg.enable {
    # Desktop-specific base config can go here
  };
}
