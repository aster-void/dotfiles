{
  config,
  flake,
  ...
}: {
  age.secrets.syncthing-password.file = "${flake}/secrets/syncthing-password.age";

  services.syncthing = {
    enable = true;
    user = "syncthing";
    group = "syncthing";
    dataDir = "/var/lib/syncthing";
    openDefaultPorts = true;
    settings.gui = {
      user = "aster";
      insecureSkipHostCheck = true;
    };
    guiPasswordFile = config.age.secrets.syncthing-password.path;
  };
}
