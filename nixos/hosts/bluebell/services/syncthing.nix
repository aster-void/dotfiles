{
  config,
  flake,
  ...
}:
{
  age.secrets.syncthing-password = {
    file = "${flake}/secrets/syncthing-password.age";
    owner = "syncthing";
    group = "syncthing";
  };

  services.syncthing = {
    enable = true;
    user = "syncthing";
    group = "syncthing";
    dataDir = "/var/lib/syncthing";
    openDefaultPorts = true;
    # Web UI でデバイス・フォルダを手動管理するため、settings で上書きしない
    overrideDevices = false;
    overrideFolders = false;
    settings.gui = {
      user = "aster";
      insecureSkipHostCheck = true;
    };
    guiPasswordFile = config.age.secrets.syncthing-password.path;
  };

  users.users.syncthing = {
    linger = true;
    extraGroups = [ "systemd-journal" ];
  };
}
