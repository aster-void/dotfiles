{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.desktop.shells.glue;
in {
  config.systemd.user.services = lib.mkIf cfg.enable {
    waybar-watcher = {
      Unit = {
        Description = "Waybar Config File Watcher";
        After = ["waybar.service"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.writeShellScript "waybar-watcher" ''
          set -euo pipefail
          while true; do
            ${pkgs.inotify-tools}/bin/inotifywait -r -e modify,move,create,delete "$HOME/.config/waybar"
            echo "Waybar config changed, restart..."
            systemctl --user restart waybar || true
            sleep 0.5
          done
        ''}";
        Restart = "always";
        RestartSec = 5;
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
