{callPackage}: {
  config = {
    git = callPackage ./config/git.nix {};
    mkShellAliases = callPackage ./config/mkShellAliases.nix {};
  };
}
