{
  config,
  flake,
  ...
}: {
  age.secrets.syncthing-password.file = "${flake}/secrets/syncthing-password.age";

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings.gui = {
      user = "syncthing";
      insecureSkipHostCheck = true;
    };
    guiPasswordFile = config.age.secrets.syncthing-password.path;
  };
}
