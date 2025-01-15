{pkgs}: let
  reload = pkgs.callPackage ./reload.nix {};
in
  pkgs.writeShellApplication {
    name = "reload-d";
    runtimeInputs = [pkgs.inotify-tools reload];
    text = ''
      trap 'kill 0' EXIT
      (
        while true; do
          inotifywait ~/.config/waybar/config.jsonc --event modify --event move --event move_self
          reload waybar
          sleep 1
        done
      ) &
      (
        while true; do
          inotifywait ~/.config/waybar/style.css --event modify --event move --event move_self
          reload waybar
          sleep 1
        done
      ) &
      wait
    '';
  }
