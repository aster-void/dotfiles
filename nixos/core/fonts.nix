{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # primary fonts
      koruri
      nerd-fonts.meslo-lg
      # Fallback fonts for compatibility
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
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
