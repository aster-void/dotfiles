{lib, ...}: {
  options.my = {
    desktop.gaming.enable = lib.mkEnableOption "gaming profile (Steam, etc.)";
    desktop.hibernate = {
      resumeDevice = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Device to resume from (e.g., /dev/disk/by-uuid/...). Set to enable hibernate.";
      };
      resumeOffset = lib.mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
        description = "Swapfile offset for resume. Get with: sudo filefrag -v /swapfile | awk 'NR==4 {print $4}' | tr -d '.'";
      };
    };
    nixos = {
      devMode = lib.mkEnableOption "use direct paths for config files (edit without rebuild)";
      primaryUser = lib.mkOption {
        type = lib.types.str;
        default = "aster";
        description = "Primary user for devMode paths";
      };
    };
  };
}
