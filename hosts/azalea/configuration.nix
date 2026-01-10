{flake, ...}: {
  networking.hostName = "azalea";
  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  # Intel I225-V (igc) has power management issues
  # 1. Disable runtime PM (prevents random disconnects)
  # 2. Reload driver after suspend (driver doesn't recover link)
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", DRIVERS=="igc", ATTR{device/power/control}="on"
  '';
  powerManagement.resumeCommands = ''
    modprobe -r igc && modprobe igc
  '';

  imports = [
    flake.nixosModules.base
    flake.nixosModules.profile-dev
    flake.nixosModules.desktop
    ./hardware-configuration.nix
  ];

  my.desktop.gaming.enable = true;
  my.boot.enableLanzaboote = true;
}
