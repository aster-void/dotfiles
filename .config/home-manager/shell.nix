{
  programs.bash = {
    shellAliases = {
      hm = "home-manager";
      hb = "home-manager build";
      hs = "home-manager switch";
      ccp = "cargo compete";
    };

    bashrcExtra = ''
      eval $(zoxide init bash)
      eval $(starship init bash)

      stow ~/.dotfiles
    '';
  };
}
