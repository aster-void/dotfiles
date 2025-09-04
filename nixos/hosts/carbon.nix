{...}: {
  # Lightweight desktop workstation
  imports = [
    ./carbon-hardware.nix
    ../profiles/desktop
    ../profiles/gaming
    ../hardware/bootloaders/lanzaboote.nix
  ];

  # Enable gaming profile
  profiles.gaming.enable = true;

  # Host-specific hardware configuration
  hardware.graphics.enable = true;
}
