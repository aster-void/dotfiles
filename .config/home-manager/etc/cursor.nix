{ pkgs, ... }:
let
  cursors = pkgs.callPackage ../store/cursors { };

  # available:
  # - catppuccin.mochaMauve # and others
  # - material-cursor
  # - empty-butterfly-cursor.{ butter, cyan, green, magenta, orange, purple, red, white, yellow };
  # - rose-pine
  # - googledot-violet
  name = "rose-pine";
in
{
  home.pointerCursor = {
    inherit name;
    package = cursors.${name};
    x11.enable = true;
    gtk.enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = 32;
  };
}
