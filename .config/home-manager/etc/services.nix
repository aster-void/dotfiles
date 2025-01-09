{ pkgs, ... }: {
  # notification
  # services.dunst.enable = true;
  # widgets / bars
  # programs.waybar.enable = true;
  # home.packages = [ pkgs.eww ]; # eww module doesn't support autostart yet.

  # hyprpanel always generates config. installing via overlays for now...
  # imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
  # programs.hyprpanel = {
  #   enable = true;
  #   overlay.enable = true;
  #   hyprland.enable = true;
  # };

  home.packages = [ pkgs.hyprpanel ];

  # wallpaper
  services.hyprpaper.enable = true;

}
