{ inputs, system, ... }:
let
  fred-drake-nvim = ((import ./fred-drake-nvim/flake.nix).outputs inputs).packages.${system}.default;
in
{
  home.packages = [ fred-drake-nvim ];
}
