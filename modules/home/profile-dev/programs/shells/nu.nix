{...}: let
  common = import ./common-aliases.nix;
  nuSpecific = {
    cg = "cd (git root)";
  };
in {
  programs.nushell = {
    enable = true;
    shellAliases = common // nuSpecific;
  };
}
