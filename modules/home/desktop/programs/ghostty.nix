{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    enableFishIntegration = true;
    settings = {
      theme = "Catppuccin Frappe";
      font-family = "MesloLGM Nerd Font";
      font-size = 12;
      confirm-close-surface = false;
      mouse-scroll-multiplier = 20;
      cursor-style = "block";
      gtk-titlebar = false;
      linux-cgroup = "always";
      linux-cgroup-hard-fail = true;
      resize-overlay = "never";
    };
  };
}
