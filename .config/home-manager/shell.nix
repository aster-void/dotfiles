let
  shellAliases = {
    hm = "home-manager";
    hb = "home-manager build";
    hs = "home-manager switch";
    ccp = "cargo compete";
  };
in
{
  programs.bash = {
    enable = true;
    inherit shellAliases;

    bashrcExtra = ''
      source ~/.shellinit/zoxide.bash
      source ~/.shellinit/starship.bash
    '';
    # don't forget to run this periodically: stow ~/.dotfiles
  };
  programs.nushell = {
    enable = true;
    inherit shellAliases;
    extraConfig = ''
      source ~/.shellinit/zoxide.nu
      source ~/.shellinit/starship.nu
    '';
  };
}
