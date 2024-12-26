{ pkgs, ... }:
let
  cursors = import ./cursors { inherit pkgs; };
  cursor = cursors.empty-butterfly-cursor.butter;
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
