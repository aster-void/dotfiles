let
  alias = import ./aliases.nix;
in
{ ... }: {
  # don't forget to run this periodically: stow ~/.dotfiles

  programs.bash = {
    enable = true;
    shellAliases = alias.common // alias.bash;
  };

  programs.nushell = {
    enable = true;
    shellAliases = alias.common // alias.nushell;
  };

  # enabled OS-wide.
  # programs.direnv = {
  #   enable = true;
  #   enableBashIntegration = true;
  #   nix-direnv.enable = true;
  # };

  programs.starship = {
    enable = true;
    settings = import ./starship.nix;
  };

  programs.zoxide = {
    enable = true;

    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };
}

