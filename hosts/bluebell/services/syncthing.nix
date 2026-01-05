{config, ...}: {
  age.secrets.syncthing-password.file = ../../../secrets/syncthing-password.age;

  services.syncthing = {
    enable = true;
    user = "aster";
    group = "users";
    dataDir = "/home/aster";
    openDefaultPorts = true;
    settings.gui.user = "aster";
    guiPasswordFile = config.age.secrets.syncthing-password.path;
  };
}
