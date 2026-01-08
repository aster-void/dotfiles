{flake, ...}: {
  networking.hostName = "azalea";
  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  # Intel I225-V (igc) has power management issues causing random disconnects
  # Disable runtime PM for this device
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", DRIVERS=="igc", ATTR{device/power/control}="on"
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
