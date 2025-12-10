{...}: let
  common = import ./common-aliases.nix;
  fishSpecific = {
    cg = "cd $(git root)";
    sizeof = "du -sh";
    nixman = "cd /etc/nixos/; sudo -s;";
  };
in {
  programs.fish = {
    enable = true;
    shellAliases = common // fishSpecific;
    interactiveShellInit = ''
      # NixOS doesn't set $SHELL from /etc/passwd in graphical sessions
      set -gx SHELL (command -v fish)
      set -g fish_greeting
      set -g __starship_fish_use_job_groups "false"
    '';
  };
}
