{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    themeFile = "Catppuccin-Frappe";
    settings = {
      confirm_os_window_close = 0;
      touch_scroll_multiplier = "20.0";
      font_size = 12;
      cursor_trail = 1;
      shell = "fish";
      default_pointer_shape = "arrow";
    };
  };
}
