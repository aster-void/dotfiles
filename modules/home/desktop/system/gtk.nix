{pkgs, ...}: {
  gtk = {
    enable = true;
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
