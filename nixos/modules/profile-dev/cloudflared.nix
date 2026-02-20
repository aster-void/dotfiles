{
  config,
  flake,
  ...
}: {
  age.secrets.cloudflared-cert.file = "${flake}/secrets/cloudflared/cert.pem.age";

  services.cloudflared.certificateFile = config.age.secrets.cloudflared-cert.path;
}
