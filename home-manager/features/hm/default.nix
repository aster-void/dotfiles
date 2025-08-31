{
  lib,
  pkgs,
  config,
  meta,
  ...
}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  news.display = "silent";

  home.activation.stow-dotfiles = let
    stow = lib.getExe' pkgs.stow "stow";
  in
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      set -euo pipefail
      ${stow} -R -d "${config.home.homeDirectory}/${meta.home.dotfilesDir}" -t "${config.home.homeDirectory}" stow
    '';
}
