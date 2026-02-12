{lib, ...}: {
  options.my.base.comin.pollerPeriod = lib.mkOption {
    type = lib.types.int;
    default = 300;
    description = "Comin poller period in seconds";
  };

  options.my.base.power.profile = lib.mkOption {
    type = lib.types.enum ["workstation" "stationary"];
    default = "workstation";
    description = "Power management profile: workstation (mobile use), stationary (always on AC)";
  };
}
