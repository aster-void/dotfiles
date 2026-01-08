{
  flake,
  config,
  lib,
  ...
}: let
  devMode = config.my.nixos.devMode;
  configFile =
    if devMode
    then "/home/aster/workspace/github.com/aster-void/dotfiles/config/kanata/default.kbd"
    else "${flake}/config/kanata/default.kbd";
in {
  hardware.uinput.enable = true;

  services.kanata = {
    enable = true;
    keyboards.default = {
      inherit configFile;
      devices = []; # empty = all keyboards
    };
  };

  systemd.services.kanata-default.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "root";
    Group = "root";
  };
}
