{...}: let
  common = import ./common-aliases.nix;
  nuSpecific = {
    cg = "cd (git root)";
    rbbb = "nh os boot; reboot";
  };
in {
  programs.nushell = {
    enable = true;
    shellAliases = common // nuSpecific;
  };
}
