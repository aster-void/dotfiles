{pkgs, ...}: {
  # Gvfs
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.gvfs
    glib
    kdePackages.kio-extras
  ];
}
