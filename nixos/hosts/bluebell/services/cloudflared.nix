{
  config,
  flake,
  ...
}: {
  age.secrets.cloudflared-bluebell.file = "${flake}/nixos/secrets/cloudflared/bluebell.json.age";
  services.cloudflared = {
    enable = true;
    tunnels.bluebell = {
      credentialsFile = config.age.secrets.cloudflared-bluebell.path;
      default = "http_status:404";
      ingress = {
        "syncthing.aster-void.dev" = "http://localhost:8384";
        "webhook.aster-void.dev" = "http://localhost:8085";
        "bluebell.aster-void.dev" = "ssh://localhost:22";
      };
    };
  };
}
