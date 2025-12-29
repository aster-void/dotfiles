{config, ...}: {
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };

  home.file."Mounts".source =
    config.lib.file.mkOutOfStoreSymlink "/run/media/${config.home.username}";
}
