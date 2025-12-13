{
  config,
  lib,
  ...
}: let
  # Design System - Typography
  primaryFont = "JetBrainsMono Nerd Font";

  # Design System - Colors (Sophisticated palette)
  colors = {
    text = {
      primary = "rgba(255, 255, 255, 0.95)";
      secondary = "rgba(255, 255, 255, 0.65)";
      muted = "rgba(255, 255, 255, 0.45)";
    };
    accent = "rgba(198, 160, 246, 1)"; # Soft purple
    success = "rgba(166, 227, 161, 1)"; # Soft green
    error = "rgba(243, 139, 168, 1)"; # Soft red
    warning = "rgba(249, 226, 175, 1)"; # Soft yellow
    surface = {
      glass = "rgba(17, 17, 27, 0.6)"; # Glassmorphism effect
      input = "rgba(30, 30, 46, 0.8)";
      border = "rgba(255, 255, 255, 0.15)";
    };
    shadow = "rgba(0, 0, 0, 0.5)";
  };
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      # UX: Smooth transitions for premium feel
      general = {
        ignore_empty_input = true;
        no_fade_in = false; # Enable smooth fade-in
        no_fade_out = false; # Enable smooth fade-out
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
      };

      # Motion design: Smooth, natural animations
      animation = [
        {
          name = "fadeIn";
          duration = 400;
          bezier = "easeOutCubic";
        }
        {
          name = "fadeOut";
          duration = 300;
          bezier = "easeInCubic";
        }
      ];

      bezier = [
        {
          name = "easeOutCubic";
          x0 = 0.33;
          y0 = 1.0;
          x1 = 0.68;
          y1 = 1.0;
        }
        {
          name = "easeInCubic";
          x0 = 0.32;
          y0 = 0.0;
          x1 = 0.67;
          y1 = 0.0;
        }
      ];

      # Visual hierarchy: Background with depth
      background = [
        {
          monitor = "";
          path = "${config.xdg.configHome}/lock";
          blur_passes = 4; # Stronger blur for depth
          blur_size = 6;
          noise = 0.02; # Subtle texture
          contrast = 1.1;
          brightness = 0.7; # Darker for better contrast
          vibrancy = 0.3;
          vibrancy_darkness = 0.0;
        }
      ];

      # User personalization: Avatar with elegant styling
      image = [
        {
          monitor = "";
          path = "~/.face";
          size = 120;
          border_size = 3;
          border_color = colors.accent;
          rounding = -1; # Perfect circle
          position = "0, 240";
          halign = "center";
          valign = "center";
          shadow_passes = 3;
          shadow_size = 8;
          shadow_color = colors.shadow;
        }
      ];

      # Visual hierarchy: Time - Primary focus (largest)
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span weight='light'>$(date +'%H:%M')</span>"'';
          color = colors.text.primary;
          font_size = 120;
          font_family = primaryFont;
          shadow_passes = 3;
          shadow_size = 4;
          shadow_color = colors.shadow;
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        # Date - Secondary info (medium)
        {
          monitor = "";
          text = ''cmd[update:43200000] echo "<span weight='normal'>$(date +'%A, %B %d')</span>"'';
          color = colors.text.secondary;
          font_size = 24;
          font_family = primaryFont;
          shadow_passes = 2;
          shadow_size = 3;
          shadow_color = colors.shadow;
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
        # User greeting - Welcoming touch
        {
          monitor = "";
          text = ''cmd[update:3600000] echo "<span weight='normal'>Welcome back, $(whoami)</span>"'';
          color = colors.text.muted;
          font_size = 18;
          font_family = primaryFont;
          position = "0, 140";
          halign = "center";
          valign = "center";
        }
        # Input hint - Clear UX guidance
        {
          monitor = "";
          text = "<span size='small' alpha='60%'>Enter password to unlock</span>";
          color = colors.text.secondary;
          font_size = 14;
          font_family = primaryFont;
          position = "0, -200";
          halign = "center";
          valign = "center";
        }
      ];

      # Interaction design: Beautiful input field with clear states
      input-field = [
        {
          monitor = "";
          size = "350, 60";
          outline_thickness = 2;
          dots_size = 0.25;
          dots_spacing = 0.4;
          dots_center = true;
          dots_rounding = -1; # Circular dots

          # Color states for clear feedback
          outer_color = colors.surface.border;
          inner_color = colors.surface.input;
          font_color = colors.text.primary;
          check_color = colors.success;
          fail_color = colors.error;
          capslock_color = colors.warning;

          # Typography
          font_family = primaryFont;
          font_size = 16;

          # UX: Smooth interactions
          fade_on_empty = true;
          fade_timeout = 2000;
          rounding = 12; # Soft, modern corners

          # Clear placeholder with icon
          placeholder_text = ''<span foreground="${colors.text.muted}"> Password</span>'';
          fail_text = ''<span foreground="${colors.error}"> Authentication failed</span>'';

          # Security: Hide input
          hide_input = false;

          # Layout
          position = "0, -120";
          halign = "center";
          valign = "center";

          # Depth
          shadow_passes = 4;
          shadow_size = 6;
          shadow_color = colors.shadow;
          shadow_boost = 0.5;
        }
      ];
    };
  };
}
