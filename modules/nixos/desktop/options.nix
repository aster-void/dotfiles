{lib, ...}: {
  options.my = {
    desktop.gaming.enable = lib.mkEnableOption "gaming profile (Steam, etc.)";
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
