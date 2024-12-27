{ pkgs }:
let
  lib = pkgs.lib;
in
{
  # supports X cursor and hyprcursor
  catppuccin =
    lib.attrsets.mapAttrs
      (name: package: {
        name = "Catppuccin-Cursor-${name}";
        inherit package;
      })
      pkgs.catppuccin-cursors;

  # seems to only support X cursor
  material-cursor = {
    name = "Material Cursor";
    package = import ./material-cursor.nix pkgs;
  };

  # only supports X cursor
  empty-butterfly-cursor =
    lib.attrsets.mapAttrs
      (name: package: {
        name = "Empty-Butterfly-Cursor-${name}";
        inherit package;
      })
      (import ./empty-butterfly-cursor pkgs);
}
