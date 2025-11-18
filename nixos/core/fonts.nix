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

    # MEMO
    # Windows Default -> Yu
    # macOS Default -> Hiragino
    fontconfig = {
      defaultFonts = {
        sansSerif = ["Noto Sans CJK JP"];
        serif = ["Noto Serif CJK JP"];
        # Jetbrains Mono, Noto Sans Mono CJK JP
        monospace = ["MesloLGMNerdFont"];
      };
    };
  };
}
