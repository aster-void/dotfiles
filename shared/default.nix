{
  config = {
    git = import ./config/git.nix;
    mkShellAliases = import ./config/mkShellAliases.nix;
  };
}
