{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.boot;
in {
  options.my.boot = {
    grubDevice = lib.mkOption {
      type = lib.types.str;
      default = "nodev";
    };
    enableLanzaboote = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    environment.systemPackages = [pkgs.sbctl];
    boot =
      if cfg.enableLanzaboote
      then {
        # enable secure boot with lanzaboote

        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };
        loader = {
          # systemd-boot.enable = true;
        };
      }
      else {
        # grub.
        loader = {
          efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
          };
          grub = {
            enable = true;

            efiSupport = true;
            useOSProber = true;
            device = cfg.grubDevice;

            default = "saved";
          };
          timeout = 10;
        };
      };
  };
}
