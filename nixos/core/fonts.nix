{
  pkgs,
  my,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      # primary fonts
      # koruri
      nerd-fonts.meslo-lg
      # Fallback fonts for compatibility
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      my.sf-mono-nerd-font
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = ["Koruri"];
        serif = ["Koruri"];
        monospace = ["MesloLGMNerdFont" "Jetbrains Mono" "Noto Sans Mono CJK JP"];
      };
    };
  };
}
