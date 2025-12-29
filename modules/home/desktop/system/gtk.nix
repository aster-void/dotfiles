{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.packages = [
    pkgs.papirus-icon-theme
    pkgs.adwaita-icon-theme
    pkgs.kdePackages.breeze-icons
    pkgs.qt6Packages.qt6ct
  ];
}
