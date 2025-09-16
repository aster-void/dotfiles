let
  inherit (import ../meta.nix) publicKeys;
in {
  "secrets/github/public-access-token.age".publicKeys = publicKeys;
}
