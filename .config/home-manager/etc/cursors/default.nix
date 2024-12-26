{ pkgs }:
let
  lib = pkgs.lib;
in
{
  # supports X cursor and hyprcursor
  catppuccin-mocha = {
    name = "Catppuccin Mocha Mauve";
    package = pkgs.catppuccin-cursors.mochaMauve;
  };

  # seems to only support X cursor
  material-cursor = {
    name = "Material Cursor";
    package = import ./material-cursor.nix pkgs;
  };

  # only supports X cursor
  empty-butterfly-cursor =
    lib.attrsets.mapAttrs
      (name: package: {
        name = "Empty Butterfly Cursor ${name}";
        inherit package;
      })
      (import ./empty-butterfly-cursor pkgs);
}
