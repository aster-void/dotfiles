{ pkgs, ... }:
let
  cursors = import ../store/cursors pkgs;
  cursor = cursors.${use};

  # available:
  # - catppuccin.mochaMauve # and others
  # - material-cursor
  # - empty-butterfly-cursor.{ butter, cyan, green, magenta, orange, purple, red, white, yellow };
  # - rose-pine
  # - googledot-violet
  use = "rose-pine";
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
