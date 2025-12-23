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
    };
  };
}
