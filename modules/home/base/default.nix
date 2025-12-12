{flake, ...}: {
  imports = flake.lib.collectFiles ./system;
}
