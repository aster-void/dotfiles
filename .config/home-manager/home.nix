{ username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  imports = [
    ./etc
    ./apps
    ./shell
    ./local.nix
    ./packages.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    # EDITOR = "hx";
    NIXOS_OZONE_WL = 1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
