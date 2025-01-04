{ pkgs, ... }:
let
  # cargo-compete =
  #   (import ./cargo-compete.nix) {
  #     inherit lib pkgs;
  #   };
  v-analyzer = import ./v-analyzer { inherit pkgs; };
in
{
  inherit v-analyzer;
}
