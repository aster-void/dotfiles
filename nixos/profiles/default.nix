{lib, ...}: {
  imports = [
    ./desktop
    ./development
    ./gaming
  ];

  options = {
    my.profiles = {
      desktop.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      gaming.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      development .enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
}
