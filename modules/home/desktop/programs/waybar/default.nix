{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.enable = true;
  };

  # waybar configuration files (complex config with scripts)
  xdg.configFile = {
    "waybar/config.jsonc".source = ./config.jsonc;
    "waybar/style.css".source = ./style.css;
    "waybar/macchiato.css".source = ./macchiato.css;
    "waybar/modules".source = ./modules;
    "waybar/scripts".source = ./scripts;
  };
}
