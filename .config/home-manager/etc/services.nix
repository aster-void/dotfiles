{ pkgs, ... }: {
  # notification
  # services.dunst.enable = true;
  # widgets / bars
  programs.waybar.enable = true;

  # hyprpanel always generates config. installing via overlays for now...
  # imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
  # programs.hyprpanel = {
  #   enable = true;
  #   overlay.enable = true;
  #   hyprland.enable = true;
  # };

  # wallpaper
}
