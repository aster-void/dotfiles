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

    waybar-hyprland-watcher = {
      Unit = {
        Description = "Waybar Hyprland Monitor Watcher";
        After = ["hyprland-session.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.writeShellScript "waybar-hyprland-watcher" ''
          set -euo pipefail

          LAST_HANDLED=0
          DEBOUNCE_SEC=5
          SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

          handle_event() {
            case "$1" in
              monitoraddedv2*|monitorremovedv2*)
                NOW=$(date +%s)
                if (( NOW - LAST_HANDLED < DEBOUNCE_SEC )); then
                  echo "Debounced: $1"
                  return
                fi
                LAST_HANDLED=$NOW

                echo "Monitor event: $1"
                systemctl --user reset-failed waybar || true
                systemctl --user restart waybar || true
                systemctl --user restart hyprpaper || true
                ;;
            esac
          }

          ${pkgs.socat}/bin/socat -U - "UNIX-CONNECT:$SOCKET" | while read -r line; do
            handle_event "$line"
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
