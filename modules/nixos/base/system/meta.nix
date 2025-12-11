{
  lib,
  inputs,
  ...
}: let
  sshAuthorizedKeys =
    builtins.fromJSON (builtins.readFile (inputs.self + "/config/ssh-authorized-keys.json"));
in {
  options.meta = {
    sshAuthorizedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Authorized SSH public keys shared across admin users.";
    };
  };

  config.meta = {
    sshAuthorizedKeys = lib.mkDefault sshAuthorizedKeys;
  };
}
