{lib, ...}: {
  options.my.base.comin.pollerPeriod = lib.mkOption {
    type = lib.types.int;
    default = 60;
    description = "Comin poller period in seconds";
  };
}
