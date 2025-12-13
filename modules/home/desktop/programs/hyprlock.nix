{
  config,
  lib,
  ...
}: let
  # Brutalist Design System
  font = "JetBrainsMono Nerd Font";

  # Monochrome palette
  white = "rgba(255, 255, 255, 1)";
  white80 = "rgba(255, 255, 255, 0.8)";
  white60 = "rgba(255, 255, 255, 0.6)";
  white40 = "rgba(255, 255, 255, 0.4)";
  white30 = "rgba(255, 255, 255, 0.3)";
  red = "rgba(255, 60, 60, 1)";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
        no_fade_in = true; # Brutalist: no smooth transitions
        no_fade_out = true;
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
      };

      # Raw background - no blur, no effects
      background = [
        {
          monitor = "";
          path = "${config.xdg.configHome}/lock";
          blur_passes = 0;
          blur_size = 0;
          noise = 0;
          contrast = 1.0;
          brightness = 0.15; # Crush to near-black
          vibrancy = 0;
        }
      ];

      label = [
        # TIME - Massive, bottom-left
        {
          monitor = "";
          text = ''cmd[update:1000] date +%H:%M'';
          color = white;
          font_size = 360;
          font_family = "${font} Bold";
          position = "-60, -80";
          halign = "left";
          valign = "bottom";
        }
        # DATE - Top-right
        {
          monitor = "";
          text = ''cmd[update:43200000] date +"%Y.%m.%d"'';
          color = white60;
          font_size = 32;
          font_family = font;
          position = "-60, -60";
          halign = "right";
          valign = "top";
        }
        # WEEKDAY - Top-right
        {
          monitor = "";
          text = ''cmd[update:43200000] date +%A | tr '[:lower:]' '[:upper:]' '';
          color = white30;
          font_size = 24;
          font_family = font;
          position = "-60, -110";
          halign = "right";
          valign = "top";
        }
      ];

      # Input field - Monochrome minimal
      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 2;
          dots_size = 0.25;
          dots_spacing = 0.3;
          dots_center = true;

          outer_color = white40;
          inner_color = "rgba(0, 0, 0, 0)";
          font_color = white;
          check_color = white;
          fail_color = red;
          capslock_color = red;

          font_family = font;

          fade_on_empty = false;
          rounding = 0;

          placeholder_text = "";
          hide_input = true;
          fail_text = "<i>$FAIL</i>";

          position = "-60, 60";
          halign = "right";
          valign = "bottom";
        }
      ];
    };
  };
}
