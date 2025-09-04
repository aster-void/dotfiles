{...}: {
  # Gaming desktop workstation with NVIDIA graphics
  imports = [
    ./amberwood-hardware.nix
    ../profiles/desktop
    ../profiles/gaming
    ../hardware/bootloaders/lanzaboote.nix
    ../hardware/drivers/logitech.nix
    ../hardware/drivers/nvidia.nix
  ];

  # Enable gaming profile
  profiles.gaming.enable = true;

  # Host-specific hardware configuration loaded separately
}
