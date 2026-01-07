{
  flake,
  lib,
  ...
}: {
  hardware.uinput.enable = true;

  services.kanata = {
    enable = true;
    keyboards.default = {
      configFile = "${flake}/config/kanata/default.kbd";
      devices = []; # empty = all keyboards
    };
  };

  systemd.services.kanata-default.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "root";
    Group = "root";
  };
}
