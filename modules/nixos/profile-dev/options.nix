{lib, ...}: {
  options.my.profile-dev.docker.rootful = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable rootful docker instead of rootless";
  };
}
