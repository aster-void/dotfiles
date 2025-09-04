{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ../../modules/hardware/bootloader/lanzaboote.nix
    ../../modules/drivers/logitech.nix
    ../../modules/drivers/nvidia.nix
  ];

  # No host-specific configuration needed - all common settings in desktop profile
}
