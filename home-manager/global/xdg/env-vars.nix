{config, ...}: {
  home.sessionVariables = {
    XDG_PICTURES_DIR = "${config.home.homeDirectory}/Pictures";

    # Hyprshot
    HYPRSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshot";
  };
}
