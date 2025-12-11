{lib, ...}: {
  options.my.base.comin.pollerPeriod = lib.mkOption {
    type = lib.types.int;
    default = 300;
    description = "Comin poller period in seconds";
  };

  options.my.base.power.profile = lib.mkOption {
    type = lib.types.enum ["boost" "balanced" "survival"];
    default = "balanced";
    description = "Power management profile: boost (max performance), balanced (default), survival (max battery saving)";
  };
}
