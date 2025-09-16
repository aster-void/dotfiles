{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # Japanese fonts
      koruri
      # Fallback fonts for compatibility
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = ["Koruri"];
        serif = ["Koruri"];
        monospace = ["JetBrains Mono" "Noto Sans Mono CJK JP"];
      };
    };
  };
}
