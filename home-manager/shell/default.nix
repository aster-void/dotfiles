{shared, ...}: let
  alias = shared.shell-aliases;
in {
  # don't forget to run this periodically: stow ~/.dotfiles

  programs = {
    bash = {
      enable = true;
      shellAliases = alias.common // alias.bash;
      enableCompletion = false;
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

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    fish = {
      enable = true;
      shellAliases = alias.common // alias.bash; # standard aliases for POSIX
    };
  };
}
