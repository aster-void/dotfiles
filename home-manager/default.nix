{
  inputs,
  my,
  meta,
  pkgs,
  shared,
  overlays,
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
          {
            nixpkgs.overlays = overlays;
          }
          ./global
          ./shells
          ./extensions
        ]
        ++ modules ++ [{inherit config;}];
    };

  # caelestia glassy
  shellConf = {
    glue.enable = true;
    glue.type = "glassy";
    # caelestia.enable = true;
  };
in {
  "aster@amberwood" = mkConfiguration {
    config = {
      my.shell = shellConf;
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
      my.shell = shellConf;
      my.extensions.gaming.enable = true;
    };
  };
  "aster@carbon" = mkConfiguration {
    config = {
      my.shell = shellConf;
    };
  };
  "aster@carbon-wsl" = mkConfiguration {
    config = {
      # WSL - no desktop shell
    };
  };
  "aster@dusk" = mkConfiguration {
    config = {
      my.shell = shellConf;
      my.extensions.gaming.enable = true;
    };
  };
}
