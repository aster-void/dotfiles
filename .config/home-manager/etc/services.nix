{ inputs, pkgs, ... }: {
  # notification
  # services.dunst.enable = true;
  # widgets / bars
  programs.waybar.enable = true;

  # hyprpanel always generates config. installing via overlays for now...
  home.packages = [ inputs.hyprpanel.packages.${pkgs.system}.default ];
  # imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
  # programs.hyprpanel = {
  # enable = true;
  # config.enable = false;
  # overlay.enable = true;
  # };

  # wallpaper
}
