{
  inputs,
  my,
  meta,
  pkgs,
  shared,
  ...
}: let
  inherit (inputs) home-manager;

  mkConfiguration = {profiles ? []}:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs my meta shared;
        inherit (meta) system;
      };
      modules = profiles;
    };
in {
  "aster@amberwood" = mkConfiguration {
    profiles = [
      ./profiles/base
      ./profiles/desktop
      ./profiles/dev
      ./profiles/game
    ];
  };
  "aster@amberwood-wsl" = mkConfiguration {
    profiles = [
      ./profiles/base
      ./profiles/wsl
      ./profiles/dev
    ];
  };
  "aster@bogster" = mkConfiguration {
    profiles = [
      ./profiles/base
      ./profiles/desktop
      ./profiles/dev
      ./profiles/game
    ];
  };
  "aster@carbon" = mkConfiguration {
    profiles = [
      ./profiles/base
      ./profiles/desktop
      ./profiles/dev
    ];
  };
  "aster@carbon-wsl" = mkConfiguration {
    profiles = [
      ./profiles/base
      ./profiles/dev
      ./profiles/wsl
    ];
  };
  "aster@dusk" = mkConfiguration {
    profiles = [
      ./profiles/base
      ./profiles/desktop
      ./profiles/dev
      ./profiles/game
    ];
  };
}
