{pkgs, ...}: let
  # cursors = pkgs.callPackage ../../store/cursors {};
  # available:
  # - catppuccin.mochaMauve # and others
  # - material-cursor
  # - empty-butterfly-cursor-{ butter, cyan, green, magenta, orange, purple, red, white, yellow };
  # - rose-pine
  # - googledot-violet
  # cursor = rec {
  #   name = "empty-butterfly-cursor-white";
  #   package = cursors.${name};
  # };
  cursor = {
    name = "Bibata_Spirit";
    package = pkgs.my.bibata-cursors-translucent;
  };
in {
  home.pointerCursor =
    cursor
    // {
      x11.enable = true;
      gtk.enable = true;
      hyprcursor.enable = true;
      hyprcursor.size = 48;
    };
}
