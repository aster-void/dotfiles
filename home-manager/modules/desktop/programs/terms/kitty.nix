{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    themeFile = "Catppuccin-Frappe";
    shellIntegration.enableFishIntegration = true;
    font = {
      name = "MesloLGM Nerd Font";
      size = 14;
    };
    settings = {
      confirm_os_window_close = 0;
      scrollback_lines = 10000;
      hide_window_decorations = true;
    };
  };
}
