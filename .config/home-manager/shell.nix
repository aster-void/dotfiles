let
  alias = import ./shell/aliases.nix;
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

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.starship = {
    enable = true;
    settings = import ./shell/starship.nix;
  };

  programs.zoxide = {
    enable = true;

    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };
}

