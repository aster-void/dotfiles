{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    noto-fonts-cjk-sans
    nerd-fonts.meslo-lg
  ];
}
