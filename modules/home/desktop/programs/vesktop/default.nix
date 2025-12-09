{pkgs, ...}: {
  home.packages = [pkgs.vesktop];

  # Vesktop themes
  xdg.configFile."vesktop/themes".source = ./themes;
}
