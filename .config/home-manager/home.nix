{username, ...}: {
  imports = [
    ./etc
    ./apps
    ./shell
    ./packages/share.nix
    ./packages/desktop.nix
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
      BROWSER = "zen";
      NIXOS_OZONE_WL = 1;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  news.display = "silent";
}
