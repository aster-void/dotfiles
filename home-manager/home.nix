{ ... }:
{
  home.username = "aster";
  home.homeDirectory = "/home/aster";

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.nix-profile/bin"
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
  ];

  # You should not change this value, even if you update Home Manager.
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  news.display = "silent";

  # Suppress upstream warning about options.json store path context
  # https://github.com/nix-community/home-manager/issues/7935
  manual.json.enable = false;
}
