{
  lib,
  flake,
  ...
}: {
  imports =
    [
      ./packages.nix
    ]
    ++ flake.lib.collectFiles ./programs;

  home = {
    stateVersion = lib.mkDefault "26.05";
    sessionVariables.EDITOR = "hx";
  };
}
