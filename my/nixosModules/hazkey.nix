{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.hazkey;
  fcitx5-hazkey = pkgs.callPackage ../pkgs/fcitx5-hazkey.nix {};
in {
  options.programs.hazkey = {
    enable = lib.mkEnableOption "hazkey";
    package = lib.mkOption {
      type = lib.types.package;
      default = fcitx5-hazkey;
      description = "The package to use for fcitx5-hazkey";
    };
  };

  config = lib.mkIf cfg.enable {
    i18n.inputMethod.fcitx5.addons = [
      cfg.package
    ];

    systemd.tmpfiles.rules = [
      "L+ /usr/local/share/hazkey - - - - ${cfg.package}/share/hazkey"
      "L+ /usr/share/hazkey - - - - ${cfg.package}/share/hazkey"
    ];
  };
}
