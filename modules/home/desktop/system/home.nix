{...}: {
  # useGlobalPkgs = false; nixpkgs.overlays is set per HM module
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  news.display = "silent";
}
