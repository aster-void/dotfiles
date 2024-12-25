{ pkgs }: {
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
}
