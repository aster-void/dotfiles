{flake, ...}: {
  networking.hostName = "azalea";
  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  # Intel I225-V (igc) needs reload after resume
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
