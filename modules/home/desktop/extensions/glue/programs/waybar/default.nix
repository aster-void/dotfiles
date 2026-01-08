{
  pkgs,
  config,
  ...
}: let
  profile = config.my.desktop.shells.glue.type;
  devMode = config.my.desktop.devMode;
  baseDir = "${config.home.homeDirectory}/workspace/github.com/aster-void/dotfiles/modules/home/desktop/extensions/glue/programs/waybar";
  mkSource = file:
    if devMode
    then config.lib.file.mkOutOfStoreSymlink "${baseDir}/${file}"
    else ./. + "/${file}";
in {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.enable = true;
  };

  # waybar configuration files (complex config with scripts)
  xdg.configFile = {
    "waybar/config.jsonc".source = mkSource "config.jsonc";
    "waybar/style.css".source = mkSource "style-${profile}.css";
    "waybar/macchiato.css".source = mkSource "macchiato.css";
    "waybar/modules".source = mkSource "modules";
    "waybar/scripts".source = mkSource "scripts";
  };
}
