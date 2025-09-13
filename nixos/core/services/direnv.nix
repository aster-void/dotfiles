{
  # Enable direnv.
  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    direnvrcExtra = "";
    nix-direnv.enable = true;
  };
}
