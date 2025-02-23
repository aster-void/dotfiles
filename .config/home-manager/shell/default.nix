{
  lib,
  pkgs,
  ...
}: let
  alias = import ./aliases.nix;
in {
  # don't forget to run this periodically: stow ~/.dotfiles

  programs = {
    bash = {
      enable = true;
      shellAliases = alias.common // alias.bash;
    };

    nushell = {
      enable = true;
      shellAliases = alias.common // alias.nushell;
    };

    starship = {
      enable = true;
      settings = import ./starship.nix;
    };
    zoxide = {
      enable = true;

      enableBashIntegration = false; # HACK: see below
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };

    # HACK: zoxide init should be the last command to be executed in .bashrc
    bash.initExtra =
      lib.mkOrder 2000
      ''
        eval "$(${lib.getExe pkgs.zoxide} init bash)"
      '';

    # enabled OS-wide.
    # direnv = {
    #   enable = true;
    #   enableBashIntegration = true;
    #   nix-direnv.enable = true;
    # };
  };
}
