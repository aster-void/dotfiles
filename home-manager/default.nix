{
  inputs,
  my,
  meta,
  pkgs,
  shared,
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
  amberwood = mkConfiguration {
    profiles = [
      ./profiles/base
      ./profiles/desktop
      ./profiles/dev
      ./profiles/game
    ];
  };
  amberwood-wsl = mkConfiguration {
    profiles = [
      ./profiles/base
      ./profiles/wsl
      ./profiles/dev
    ];
  };
  bogster = mkConfiguration {
    profiles = [
      ./profiles/base
      ./profiles/desktop
      ./profiles/dev
      ./profiles/game
    ];
  };
  carbon = mkConfiguration {
    profiles = [
      ./profiles/base
      ./profiles/desktop
      ./profiles/dev
    ];
  };
  carbon-wsl = mkConfiguration {
    profiles = [
      ./profiles/base
      ./profiles/dev
      ./profiles/wsl
    ];
  };
}
