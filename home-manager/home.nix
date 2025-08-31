{
  username,
  dotfilesDir,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./etc
    ./apps
    ./shell
    ./plugins
  ];

  programs.asdf.enable = false;

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

  home.activation.dotfiles = let
    stow = lib.getExe pkgs.stow;
  in
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      set -euo pipefail
      ${stow} -R -d "${config.home.homeDirectory}/${dotfilesDir}" -t "${config.home.homeDirectory}" stow
    '';
}
