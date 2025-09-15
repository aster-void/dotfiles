{pkgs, ...}: {
  # Manual systemd integration for Waybar with Hyprland
  systemd.user = {
    targets.hyprland = {
      Unit = {
        Description = "Hyprland compositor session";
        Documentation = "man:systemd.special(7)";
        BindsTo = ["graphical-session.target"];
        Wants = ["graphical-session-pre.target"];
        After = ["graphical-session-pre.target"];
      };
    };

    # Waybar systemd service with manual target binding
    services.waybar = {
      Unit = {
        Description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
        Documentation = "https://github.com/Alexays/Waybar/wiki";
        ConditionPathExists = "%t/wayland-1";
        PartOf = ["hyprland.target"];
        After = ["hyprland.target"];
        Wants = ["hyprland.target"];
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
        WantedBy = ["hyprland.target"];
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
          while true; do
            ${pkgs.inotify-tools}/bin/inotifywait -e modify,move,create,delete ~/.config/waybar/**/*
            echo "Waybar config changed, restarting..."
            systemctl --user reload waybar
            sleep 1
          done
        ''}";
        Restart = "always";
        RestartSec = 5;
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };

    services.fcitx5 = {
      Unit = {
        Description = "Fcitx5 input method";
        PartOf = ["hyprland.target"];
        After = ["hyprland.target"];
      };
      Service = {
        Type = "dbus";
        ExecStart = "${pkgs.bash}/bin/bash -c fcitx5";
        Restart = "on-failure";
        RestartSec = 1;
      };
      Install = {
        WantedBy = ["hyprland.target"];
      };
    };

    # Hyprpaper wallpaper daemon service
    services.hyprpaper = {
      Unit = {
        Description = "Hyprpaper wallpaper daemon";
        PartOf = ["hyprland.target"];
        After = ["hyprland.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install = {
        WantedBy = ["hyprland.target"];
      };
    };

    # Dunst notification daemon service
    services.dunst-session = {
      Unit = {
        Description = "Dunst notification daemon";
        Documentation = "man:dunst(1)";
        PartOf = ["hyprland.target"];
        After = ["hyprland.target"];
      };
      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${pkgs.dunst}/bin/dunst";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install = {
        WantedBy = ["hyprland.target"];
      };
    };

    # Walker application launcher service
    services.walker-session = {
      Unit = {
        Description = "Walker application launcher";
        PartOf = ["hyprland.target"];
        After = ["hyprland.target"];
      };
      Service = {
        Type = "dbus";
        BusName = "org.gtk.Application.walker";
        ExecStart = "${pkgs.walker}/bin/walker --gapplication-service";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install = {
        WantedBy = ["hyprland.target"];
      };
    };

    services.hypridle-session = {
      Unit = {
        Description = "Hypridle idle daemon";
        Documentation = "man:hypridle(1)";
        PartOf = ["hyprland.target"];
        After = ["hyprland.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.hypridle}/bin/hypridle";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install = {
        WantedBy = ["hyprland.target"];
      };
    };
  };
}
