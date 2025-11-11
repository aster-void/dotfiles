let
  inherit (import ../meta.nix) publicKeys;
in {
  "secrets/nix.conf.age".publicKeys = publicKeys;
}
