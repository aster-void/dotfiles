{
  imports = [
    ./hardware-configuration.nix
    ../../desktop
    ../../core/hardware
    ../../profiles/gaming
  ];

  my.apps.games.enable = true;
  my.boot.grubDevice = "nodev";

  services.displayManager.autoLogin.enable = false; # LY doesn't support
}
