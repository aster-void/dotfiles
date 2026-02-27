{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Noto Sans CJK JP" ];
    serif = [ "Noto Serif CJK JP" ];
  };

  home.packages = with pkgs; [
    noto-fonts-cjk-sans
    nerd-fonts.meslo-lg
  ];
}
