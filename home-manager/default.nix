{
  inputs,
  my,
  meta,
  pkgs,
  shared,
  ...
}: let
  inherit (inputs) home-manager;

  mkConfiguration = {
    modules ? [],
    config ? {},
  }:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs my meta shared;
        inherit (meta) system;
      };
      modules =
        [
          ./global
          ./shells
          ./extensions
        ]
        ++ modules ++ [{inherit config;}];
    };

  # caelestia glassy
  shell = "caelestia";
in {
  "aster@amberwood" = mkConfiguration {
    config = {
      my.shell.${shell}.enable = true;
      my.extensions.gaming.enable = true;
    };
  };
  "aster@amberwood-wsl" = mkConfiguration {
    config = {
      # WSL - no desktop shell
    };
  };
  "aster@bogster" = mkConfiguration {
    config = {
      my.shell.${shell}.enable = true;
      my.extensions.gaming.enable = true;
    };
  };
  "aster@carbon" = mkConfiguration {
    config = {
      my.shell.${shell}.enable = true;
    };
  };
  "aster@carbon-wsl" = mkConfiguration {
    config = {
      # WSL - no desktop shell
    };
  };
  "aster@dusk" = mkConfiguration {
    config = {
      my.shell.${shell}.enable = true;
      my.extensions.gaming.enable = true;
    };
  };
}
