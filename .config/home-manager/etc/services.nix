{pkgs, ...}: {
  # Manual systemd integration for Waybar with Hyprland
  # Create hyprland-session.target manually
  systemd.user.targets.hyprland-session = {
    Unit = {
      Description = "Hyprland compositor session";
      Documentation = "man:systemd.special(7)";
      BindsTo = ["graphical-session.target"];
      Wants = ["graphical-session-pre.target"];
      After = ["graphical-session-pre.target"];
    };
  };

  # Waybar systemd service with manual target binding
  systemd.user.services.waybar = {
    Unit = {
      Description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
      Documentation = "https://github.com/Alexays/Waybar/wiki";
      ConditionPathExists = "%t/wayland-1";
      PartOf = ["hyprland-session.target"];
      After = ["hyprland-session.target"];
      Wants = ["hyprland-session.target"];
    };
    Service = {
      Type = "exec";
      ExecStart = "${pkgs.waybar}/bin/waybar";
      ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
      KillMode = "mixed";
    };
    Install = {
      WantedBy = ["hyprland-session.target"];
    };
  };

  # notification
  # services.dunst.enable = true;

  # hyprpanel always generates config. installing via overlays for now...
  # home.packages = [inputs.hyprpanel.packages.${pkgs.system}.default];
  # imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
  # programs.hyprpanel = {
  # enable = true;
  # config.enable = false;
  # overlay.enable = true;
  # };

  # wallpaper
}
