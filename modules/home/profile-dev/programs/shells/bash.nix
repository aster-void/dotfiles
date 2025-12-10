{...}: let
  common = import ./common-aliases.nix;
  bashSpecific = {
    cg = "cd $(git root)";
    sizeof = "du -sh";
    nixman = "cd /etc/nixos/; sudo -s;";
  };
in {
  programs.bash = {
    enable = true;
    shellAliases = common // bashSpecific;
    enableCompletion = false;
  };
}
