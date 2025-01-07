{ lib
, fetchFromGitHub
, callPackage

, catppuccin-cursors
, ...
} @ pkgs:
{
  # supports X cursor and hyprcursor
  catppuccin =
    lib.attrsets.mapAttrs
      (name: package: {
        name = "Catppuccin-Cursor-${name}";
        inherit package;
      })
      catppuccin-cursors;

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

  # Hyprcursor only, not currently working
  rose-pine = {
    name = "rose-pine-hyprcursor";
    package = callPackage "${fetchFromGitHub {
      owner = "ndom91";
      repo = "rose-pine-hyprcursor";
      rev = "v0.3.2";
      hash = "sha256-ArUX5qlqAXUqcRqHz4QxXy3KgkfasTPA/Qwf6D2kV0U=";
    }}/nix"
      { nixpkgs = pkgs; };
  };

  # Hyprcursor only
  googledot-violet = {
    name = "GoogleDot-Violet";
    package = import ./GoogleDot-Violet pkgs;
  };
}
