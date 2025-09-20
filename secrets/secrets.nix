let
  inherit (import ../meta.nix) publicKeys;
in {
  "secrets/github/public-access-token.age".publicKeys = publicKeys;
  "secrets/nix.conf.age".publicKeys = publicKeys;
}
