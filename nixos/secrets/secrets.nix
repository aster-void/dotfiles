let
  publicKeys = builtins.fromJSON (builtins.readFile ../../config/ssh-authorized-keys.json);
in {
  "nixos/secrets/playit.toml.age".publicKeys = publicKeys;
  "nixos/secrets/cloudflared/cherry.json.age".publicKeys = publicKeys;
  "nixos/secrets/cloudflared/bluebell.json.age".publicKeys = publicKeys;
  "nixos/secrets/cloudflared/cert.pem.age".publicKeys = publicKeys;
  "nixos/secrets/syncthing-password.age".publicKeys = publicKeys;
  "nixos/secrets/wifi/password.age".publicKeys = publicKeys;
  "nixos/secrets/context7-api-key.age".publicKeys = publicKeys;
  "nixos/secrets/nix.conf.age".publicKeys = publicKeys;
  "nixos/secrets/tailscale-authkey.age".publicKeys = publicKeys;
}
