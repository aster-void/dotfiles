{
  programs.bash = {
    enable = true;
    shellAliases = {
      hm = "home-manager";
      hb = "home-manager build";
      hs = "home-manager switch";
      ccp = "cargo compete";
    };

    bashrcExtra = ''
      source ~/.dotfiles/.zoxide.sh
      eval $(starship init bash)

    '';
    # don't forget to run this periodically: stow ~/.dotfiles
  };
}
