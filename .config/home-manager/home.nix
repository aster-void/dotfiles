{ username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  imports = [
    ./apps
    ./shell
    ./plasma
    ./desktop-entries
    # ./etc/ime.nix # it's installed system wide so nw
    ./local.nix
    ./packages.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    # EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
