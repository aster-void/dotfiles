{
  inputs,
  flake,
  ...
}: let
  lib = inputs.nixpkgs.lib;

  # Recursively collect all files in a directory.
  # If a directory contains "default.nix", only return that file (no recursion).
  # Otherwise, recurse into subdirectories and collect all files.
  #
  # Example:
  #   Given directory structure:
  #     modules/
  #       foo/
  #         default.nix
  #         utils.nix
  #       bar/
  #         a.nix
  #         b.nix
  #       baz.nix
  #
  #   collectFiles ./modules => [
  #     ./modules/foo/default.nix   # has default.nix, no recursion
  #     ./modules/bar/a.nix         # no default.nix, all files included
  #     ./modules/bar/b.nix
  #     ./modules/baz.nix
  #   ]
  collectFiles = dir: let
    entries = builtins.readDir dir;
    hasDefaultNix = entries ? "default.nix" && entries."default.nix" == "regular";

    processEntry = name: type: let
      path = dir + "/${name}";
    in
      if type == "regular"
      then [path]
      else if type == "directory"
      then collectFiles path
      else []; # ignore symlinks and other types
  in
    if hasDefaultNix
    then [(dir + "/default.nix")]
    else lib.flatten (lib.mapAttrsToList processEntry entries);
in {
  inherit collectFiles;
}
