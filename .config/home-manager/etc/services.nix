{ pkgs, ... }: {
  # notification
  services.dunst.enable = true;
  # widgets / bars
  # programs.waybar.enable = true;
  # eww module doesn't support autostart yet.
  home.packages = [ pkgs.eww ];

  # wallpaper
  services.hyprpaper.enable = true;
}
