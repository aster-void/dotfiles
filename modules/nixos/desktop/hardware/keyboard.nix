{
  flake,
  config,
  lib,
  ...
}: let
  devMode = config.my.nixos.devMode;
  homeDir = config.users.users.${config.my.nixos.primaryUser}.home;
  configFile =
    if devMode
    then "${homeDir}/${flake.lib.dotfilesRelPath}/config/kanata/default.kbd"
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
    ProtectHome = lib.mkIf devMode (lib.mkForce false);
    PrivateUsers = lib.mkIf devMode (lib.mkForce false);
    CapabilityBoundingSet = lib.mkIf devMode (lib.mkForce ["CAP_DAC_READ_SEARCH"]);
    AmbientCapabilities = lib.mkIf devMode (lib.mkForce ["CAP_DAC_READ_SEARCH"]);
  };
}
