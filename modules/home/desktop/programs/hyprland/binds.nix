_: let
  term = "ghostty";
  mainMod = "SUPER";
in {
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = mainMod;
    "$TERM" = term;

    bind = [
      # System commands
      "${mainMod}, L, exec, hyprlock"
      "${mainMod}, K, exec, hyprlock & sleep .5 && hyprctl dispatch dpms off"

      # App launching + closing
      "${mainMod}, N, exec, ${term}"
      "${mainMod}, E, killactive"
      "${mainMod}, O, exec, fuzzel"
      "${mainMod}, I, exec, caelestia shell drawers toggle launcher"
      "${mainMod}, delete, exec, systemctl --user stop graphical-session.target && hyprctl dispatch exit"
      "${mainMod}, F, togglefloating"
      "${mainMod} SHIFT, F, fullscreen"
      "${mainMod}, J, togglesplit"

      # Screenshots
      "${mainMod}, P, exec, hyprshot -m region"
      "${mainMod} SHIFT, P, exec, hyprshot -m output"
      "${mainMod} CTRL, P, exec, hyprshot -m window"

      # Brightness
      "${mainMod}, f4, exec, brightnessctl s 10%-"
      "${mainMod}, f5, exec, brightnessctl s +10%"

      # Move focus (WASD in workman = DASH)
      "${mainMod}, D, movefocus, u"
      "${mainMod}, A, movefocus, l"
      "${mainMod}, S, movefocus, d"
      "${mainMod}, H, movefocus, r"

      # Move windows
      "${mainMod} SHIFT, D, movewindow, u"
      "${mainMod} SHIFT, A, movewindow, l"
      "${mainMod} SHIFT, S, movewindow, d"
      "${mainMod} SHIFT, H, movewindow, r"

      # Switch workspaces (hyprsplit: per-monitor workspaces)
      "${mainMod}, 1, split:workspace, 1"
      "${mainMod}, 2, split:workspace, 2"
      "${mainMod}, 3, split:workspace, 3"
      "${mainMod}, 4, split:workspace, 4"
      "${mainMod}, 5, split:workspace, 5"
      "${mainMod}, 6, split:workspace, 6"
      "${mainMod}, 7, split:workspace, 7"
      "${mainMod}, 8, split:workspace, 8"
      "${mainMod}, 9, split:workspace, 9"
      "${mainMod}, 0, split:workspace, 10"

      # Swipe between workspaces
      "${mainMod}, left, split:workspace, r-1"
      "${mainMod}, right, split:workspace, r+1"

      # Move to workspace
      "${mainMod} SHIFT, 1, split:movetoworkspace, 1"
      "${mainMod} SHIFT, 2, split:movetoworkspace, 2"
      "${mainMod} SHIFT, 3, split:movetoworkspace, 3"
      "${mainMod} SHIFT, 4, split:movetoworkspace, 4"
      "${mainMod} SHIFT, 5, split:movetoworkspace, 5"
      "${mainMod} SHIFT, 6, split:movetoworkspace, 6"
      "${mainMod} SHIFT, 7, split:movetoworkspace, 7"
      "${mainMod} SHIFT, 8, split:movetoworkspace, 8"
      "${mainMod} SHIFT, 9, split:movetoworkspace, 9"
      "${mainMod} SHIFT, 0, split:movetoworkspace, 10"

      # Focus other monitor
      "${mainMod}, comma, focusmonitor, -1"
      "${mainMod}, period, focusmonitor, +1"

      # Grab workspace from other monitor
      "${mainMod} CTRL, comma, split:grabroguewindows"

      # Special workspace (scratchpad)
      "${mainMod}, M, togglespecialworkspace, magic"
      "${mainMod} SHIFT, M, movetoworkspace, special:magic"

      # Scroll through workspaces
      "${mainMod}, mouse_down, split:workspace, e-1"
      "${mainMod}, mouse_up, split:workspace, e+1"

      # Middle mouse button (no-op)
      ",mouse:274, exec, ;"
    ];

    # Move/resize with mouse
    bindm = [
      "${mainMod}, mouse:272, movewindow"
      "${mainMod}, mouse:273, resizewindow"
    ];

    # Non-consuming bind (passes key to other apps too)
    bindn = [
      ", escape, exec, eww close power-menu"
    ];
  };
}
