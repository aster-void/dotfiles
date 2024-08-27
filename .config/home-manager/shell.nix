{
  programs.bash = {
    enable = true;
    shellAliases = {
      hm = "home-manager";
      hb = "home-manager build";
      hs = "home-manager switch";
      ccp = "cargo compete";
    };

    # this doesn't seem to be working...
    bashrcExtra = ''
      eval $(zoxide init bash)
      eval $(starship init bash)
    '';
    # don't forget to run this periodically: stow ~/.dotfiles
  };
}
