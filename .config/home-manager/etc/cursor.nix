{ pkgs, ... }:
let
  cursors = import ../store/cursors { inherit pkgs; };

  # available:
  # - catppuccin.mochaMauve # and others
  # - material-cursor
  # - empty-butterfly-cursor.{ butter, cyan, green, magenta, orange, purple, red, white, yellow };
  cursor = cursors.empty-butterfly-cursor.white;
in
{
  home.pointerCursor = {
    inherit (cursor) name package;
    # x11.enable = true;
    gtk.enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = 32;
  };
}
