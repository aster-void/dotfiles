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
    # Waybar systemd service
    services.waybar = {
      Unit = {
        Description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
        Documentation = "https://github.com/Alexays/Waybar/wiki";
        # Do not hardcode a specific WAYLAND_DISPLAY; rely on session env
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
        Wants = ["graphical-session.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.waybar}/bin/waybar";
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
        KillMode = "control-group";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    # Waybar config file watcher service
    services.waybar-watcher = {
      Unit = {
        Description = "Waybar Config File Watcher";
        After = ["waybar.service"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.writeShellScript "waybar-watcher" ''
          set -euo pipefail
          ${pkgs.inotify-tools}/bin/inotifywait -m -r -e modify,move,create,delete "$HOME/.config/waybar" | while read -r _; do
            echo "Waybar config changed, reloading..."
            systemctl --user reload waybar || true
          done
        ''}";
        Restart = "always";
        RestartSec = 5;
      };
      Install = {
        WantedBy = ["default.target"];
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

    # Dunst notification daemon service
    services.dunst-session = {
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
