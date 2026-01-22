{
  config,
  osConfig,
  pkgs,
  ...
}: let
  cfg = config.my.hyprland;
  xkb = osConfig.services.xserver.xkb;
in {
  imports = [
    ./binds.nix
    ./windowrules.nix
    ./exec.nix
  ];

  config = {
    # Ensure monitors.conf exists for nwg-displays
    home.activation.ensureMonitorsConf = config.lib.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ~/.config/hypr
      touch ~/.config/hypr/monitors.conf
    '';

    xdg.portal = {
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config.common.default = ["hyprland" "gtk"];
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = true;
        enableXdgAutostart = true;
      };
      xwayland.enable = true;

      # Source nwg-displays config at the end to override defaults
      extraConfig = ''
        source = ~/.config/hypr/monitors.conf
      '';

      settings = {
        # Fallback monitor configuration (overridden by monitors.conf via extraConfig)
        monitor = [",preferred,auto,1"];

        misc = {
          vrr = 0;
          disable_hyprland_logo = true;
          force_default_wallpaper = 2;
          focus_on_activate = true;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        input = {
          kb_layout = xkb.layout;
          kb_variant = xkb.variant;
          kb_options = xkb.options;
          repeat_rate = 40;
          repeat_delay = 250;
          follow_mouse = 1;
          mouse_refocus = false;
          inherit (cfg) sensitivity;
          accel_profile = "flat";

          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
            scroll_factor = cfg.touchpadScrollFactor;
          };
        };

        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 0;
          "col.active_border" = "rgb(303030)";
          "col.inactive_border" = "rgba(303030aa)";
          layout = "dwindle";
          allow_tearing = true;
        };

        xwayland.force_zero_scaling = true;

        decoration = {
          rounding = 0;
          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            ignore_opacity = false;
            new_optimizations = true;
            xray = false;
          };
        };

        animations = {
          enabled = true;
          bezier = ["myBezier, 0.05, 0.9, 0.1, 1.05"];
          animation = [
            "windows, 1, 2, myBezier"
            "windowsOut, 1, 2, default, popin 80%"
            "border, 1, 2, default"
            "borderangle, 1, 2, default"
            "fade, 1, 2, default"
            "workspaces, 1, 1, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        gestures = {
          workspace_swipe_distance = 300;
          workspace_swipe_invert = true;
          workspace_swipe_forever = false;
          workspace_swipe_create_new = true;
          gesture = "3, horizontal, workspace";
        };

        cursor.no_hardware_cursors = false;

        debug = {
          disable_logs = false;
        };
      };
    };
  };
}
