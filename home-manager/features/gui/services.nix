{pkgs, ...}: {
  # UWSM-managed services - UWSM handles session management automatically
  # No manual systemd targets needed with UWSM

  # Keep only non-conflicting services that make sense with UWSM
  systemd.user.services.waybar-watcher = {
    Unit = {
      Description = "Waybar Config File Watcher";
      After = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.writeShellScript "waybar-watcher" ''
        while true; do
          ${pkgs.inotify-tools}/bin/inotifywait -e modify,move,create,delete ~/.config/waybar/**/*
          echo "Waybar config changed, restarting..."
          # With UWSM, restart waybar via uwsm
          pkill waybar
          uwsm app -- waybar &
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
}
