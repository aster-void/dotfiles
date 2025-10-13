{pkgs, ...}: {
  # Manual systemd services for Hyprland session management
  systemd.user = {
    # Declare graphical-session.target
    targets.graphical-session = {
      Unit = {
        Description = "Graphical session";
        Documentation = "man:systemd.special(7)";
        RefuseManualStart = "no";
        StopWhenUnneeded = "no";
        Requires = ["default.target"];
        After = ["default.target"];
      };
    };

    # Hyprpaper wallpaper daemon service
    services.hyprpaper = {
      Unit = {
        Description = "Hyprpaper wallpaper daemon";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    # Hypridle idle daemon service
    services.hypridle-session = {
      Unit = {
        Description = "Hypridle idle daemon";
        Documentation = "man:hypridle(1)";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.hypridle}/bin/hypridle";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
