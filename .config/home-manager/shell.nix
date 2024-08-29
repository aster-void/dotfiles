let
  alias = import ./shell/aliases.nix;
in
{ ... }: {
  # don't forget to run this periodically: stow ~/.dotfiles
  programs.bash = {
    enable = true;
    shellAliases = alias.common // alias.bash;
    bashrcExtra = ''
      source ~/.shellinit/zoxide.bash
      source ~/.shellinit/starship.bash
    '';
  };

  programs.nushell = {
    enable = true;
    shellAliases = alias.common // alias.nushell;
    extraConfig = ''
      source ~/.shellinit/zoxide.nu
      source ~/.shellinit/starship.nu
    '';
  };
}

