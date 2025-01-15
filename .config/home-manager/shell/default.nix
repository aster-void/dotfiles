let
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

      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };

    # enabled OS-wide.
    # direnv = {
    #   enable = true;
    #   enableBashIntegration = true;
    #   nix-direnv.enable = true;
    # };
  };
}
