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

          handle_event() {
            case "$1" in
              monitoradded*|monitorremoved*)
                echo "Monitor event: $1"
                ${updateHyprEnv}
                sleep 0.5
                systemctl --user restart waybar || true
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
