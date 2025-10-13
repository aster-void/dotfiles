{
  lib,
  pkgs,
  config,
  meta,
  ...
}: let
  inherit (meta) username;
in {
  nixpkgs.config.allowUnfree = true;
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";

    sessionVariables = {
      EDITOR = "hx";
      BROWSER = "zen-beta";
      TERMINAL = "alacritty";
      NIXOS_OZONE_WL = 1;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  news.display = "silent";

  home.activation.stow-dotfiles = let
    stow = lib.getExe' pkgs.stow "stow";
  in
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      set -euo pipefail
      ${stow} -R -d "${config.home.homeDirectory}/${meta.home.dotfilesDir}" -t "${config.home.homeDirectory}" stow --adopt
    '';
}
