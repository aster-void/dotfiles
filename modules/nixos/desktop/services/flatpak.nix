{config, ...}: {
  assertions = [
    {
      assertion = config.xdg.portal.enable;
      message = "To use Flatpak you must enable XDG Desktop Portals with xdg.portal.enable.";
    }
  ];

  # Enable system flatpak service
  # Packages are managed in home-manager (modules/home/desktop/flatpak.nix)
  services.flatpak.enable = true;
}
