{
  config,
  flake,
  ...
}: {
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
    settings.gui = {
      user = "aster";
      insecureSkipHostCheck = true;
    };
    guiPasswordFile = config.age.secrets.syncthing-password.path;
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/syncthing 2770 syncthing syncthing -"
    "z /var/lib/syncthing 2770 syncthing syncthing -"
    "a+ /var/lib/syncthing - - - - mask::rwx"
    "A+ /var/lib/syncthing - - - - default:user::rwx,default:group::rwx,default:other::---"
  ];
}
