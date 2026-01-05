{
  config,
  flake,
  ...
}: {
  age.secrets.tailscale-authkey.file = "${flake}/secrets/tailscale-authkey.age";

  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscale-authkey.path;
  };
}
