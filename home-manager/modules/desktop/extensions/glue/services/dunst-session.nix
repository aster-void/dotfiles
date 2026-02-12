{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.desktop.shells.glue;
in {
  config.systemd.user.services = lib.mkIf cfg.enable {
    dunst-session = {
      Unit = {
        Description = "Dunst notification daemon";
        Documentation = "man:dunst(1)";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
      };
      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${pkgs.dunst}/bin/dunst";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
