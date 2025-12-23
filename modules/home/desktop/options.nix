{lib, ...}: {
  options.my = {
    desktop = {
      gaming.enable = lib.mkEnableOption "gaming extension";
      shells = {
        glue = {
          enable = lib.mkEnableOption "glued shell";
          type = lib.mkOption {
            type = lib.types.enum ["glass" "neon" "brutal" "funky" "vapor" "editorial" "noir" "soft"];
            default = "glass";
            description = "Visual profile for waybar";
          };
        };
        caelestia.enable = lib.mkEnableOption "caelestia shell";
      };
    };

    hyprland = {
      primaryMonitor = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Primary monitor name (e.g., eDP-1, DP-1)";
      };
      scale = lib.mkOption {
        type = lib.types.str;
        default = "1.0";
        description = "Monitor scale factor";
      };
      sensitivity = lib.mkOption {
        type = lib.types.str;
        default = "0";
        description = "Mouse sensitivity";
      };
      touchpadScrollFactor = lib.mkOption {
        type = lib.types.str;
        default = "1.0";
        description = "Touchpad scroll factor";
      };
      mirrorSecondary = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Mirror secondary monitors to primary";
      };
    };
  };
}
