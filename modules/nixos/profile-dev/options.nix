{lib, ...}: {
  options.my.profile-dev.docker.rootful = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable rootful docker instead of rootless";
  };
}
