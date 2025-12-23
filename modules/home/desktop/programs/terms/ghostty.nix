{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    enableFishIntegration = true;
    settings = {
      theme = "Catppuccin Frappe";
      font-family = [
        "MesloLGM Nerd Font"
        "Noto Sans Mono CJK JP"
      ];
      font-size = 14;
      confirm-close-surface = false;
      mouse-scroll-multiplier = "precision:0.5,discrete:2";
      cursor-style = "block";
      gtk-titlebar = false;
      linux-cgroup = "always";
      linux-cgroup-hard-fail = true;
      resize-overlay = "never";
    };
  };
}
