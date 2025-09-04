{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Desktop applications via Flatpak
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  assertions = [
    {
      assertion = config.xdg.portal.enable;
      message = "To use Flatpak you must enable XDG Desktop Portals with xdg.portal.enable.";
    }
  ];

  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "us.zoom.Zoom"
      "org.gnome.Platform//45"
    ];
  };

  # XDG portals for desktop integration
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
