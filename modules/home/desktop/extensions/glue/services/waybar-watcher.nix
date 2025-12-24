{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.desktop.shells.glue;

  # Script to find and update HYPRLAND_INSTANCE_SIGNATURE
  updateHyprEnv = pkgs.writeShellScript "update-hypr-env" ''
    set -euo pipefail
    # Find the current Hyprland instance (the one with .socket.sock)
    for dir in /run/user/1000/hypr/*/; do
      if [[ -S "$dir/.socket.sock" ]]; then
        NEW_SIG=$(basename "$dir")
        if [[ "$NEW_SIG" != "$HYPRLAND_INSTANCE_SIGNATURE" ]]; then
          echo "Updating HYPRLAND_INSTANCE_SIGNATURE: $HYPRLAND_INSTANCE_SIGNATURE -> $NEW_SIG"
          systemctl --user set-environment HYPRLAND_INSTANCE_SIGNATURE="$NEW_SIG"
        fi
        break
      fi
    done
  '';
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
                ${updateHyprEnv}
                sleep 1

                # Workaround: disable monitors then reload to force xdg_output refresh
                # (fixes waybar not appearing on second monitor - Hyprland bug)
                for mon in $(hyprctl monitors -j | ${pkgs.jq}/bin/jq -r '.[].name'); do
                  hyprctl keyword monitor "$mon,disable" >/dev/null 2>&1 || true
                done
                sleep 0.05
                hyprctl reload >/dev/null 2>&1 || true
                sleep 0.1

                systemctl --user reset-failed waybar || true
                systemctl --user restart waybar || true
                systemctl --user restart hyprpaper || true
                ;;
            esac
          }

          # Find valid socket
          find_socket() {
            for dir in /run/user/1000/hypr/*/; do
              if [[ -S "$dir/.socket2.sock" ]]; then
                echo "$dir/.socket2.sock"
                return 0
              fi
            done
            return 1
          }

          while true; do
            SOCKET=$(find_socket) || { sleep 2; continue; }
            echo "Connecting to $SOCKET"
            ${pkgs.socat}/bin/socat -U - "UNIX-CONNECT:$SOCKET" | while read -r line; do
              handle_event "$line"
            done
            echo "Socket disconnected, reconnecting..."
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
  };
}
