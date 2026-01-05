{config, ...}: {
  age.secrets.cloudflared-cert.file = ../../../secrets/cloudflared/cert.pem.age;

  services.cloudflared.certificateFile = config.age.secrets.cloudflared-cert.path;
}
