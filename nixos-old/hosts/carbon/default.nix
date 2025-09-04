{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ../../modules/hardware/bootloader/lanzaboote.nix
  ];

  # Host-specific hardware configuration
  hardware.graphics.enable = true;
}
