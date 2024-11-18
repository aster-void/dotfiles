{ lib, config, inputs, system, ... }:
let
  cfg = config.nixvim;
  fred-drake-nvim = ((import ./fred-drake-nvim/flake.nix).outputs inputs).packages.${system}.default;
in
{
  options.nixvim = {
    enable = lib.mkEnableOption "Enable NixVim pre-configured by Fred Drake";
  };

  config.home.packages = if cfg.enable then [ fred-drake-nvim ] else [ ];
}
