{
  nixpkgs,
  inputs,
  my,
  meta,
  shared,
  overlays,
}: let
  mkSystemConfig = {
    host,
    system,
  }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit host system inputs my meta shared;
      };

      modules = [
        {
          nixpkgs.overlays = overlays;
        }
        inputs.agenix.nixosModules.default
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.comin.nixosModules.comin
        inputs.lanzaboote.nixosModules.lanzaboote
        ./configuration.nix
        ./hosts/${host}
        ./hosts/${host}/hardware-configuration.nix
      ];
    };
in {
  amberwood = mkSystemConfig {
    host = "amberwood";
    system = "x86_64-linux";
  };
  bogster = mkSystemConfig {
    host = "bogster";
    system = "x86_64-linux";
  };
  carbon = mkSystemConfig {
    host = "carbon";
    system = "x86_64-linux";
  };
  dusk = mkSystemConfig {
    host = "dusk";
    system = "x86_64-linux";
  };
}
