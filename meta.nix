{
  username = "aster";
  # TODO: make system flexible (e.g. make this flake also usable in darwin)
  system = "x86_64-linux";

  git = {
    user = "aster";
    email = "137767097+aster-void@users.noreply.github.com";
  };

  home = {
    dotfilesDir = ".dotfiles"; # path to the dotfiles from $HOME (gets appended after ${home.homeDir}/)
  };
}
