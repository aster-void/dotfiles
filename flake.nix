{
  description = "Home Manager configuration of aster";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    claude-monitor = {
      url = "github:aster-void/Claude-Code-Usage-Monitor?ref=add-nix-flake-distribution";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS-specific inputs
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    shared-config.url = "github:aster-void/shared-config";
    comin = {
      url = "github:nlewo/comin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    agenix,
    shared-config,
    comin,
    ...
  } @ inputs: let
    meta = import ./meta.nix;
    inherit (meta) system;

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    args = {
      inherit inputs meta;
      my = {
        pkgs = pkgs.callPackage ./my/pkgs/default.nix {};
      };
      shared = pkgs.callPackage ./shared {};
    };
    shared = shared-config.config;

    mkSystemConfig = {
      host,
      system,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit system inputs host shared;
        };

        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ./nixos/configuration.nix
          ./nixos/hosts/${host}
          (import ./nixos/templates/packages.nix {
            enable-pkgs = [
              "cli"
              "editor"
              [
                pkgs.helix
              ]
            ];
          })
        ];
      };
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "Home Manager";
      packages = with pkgs; [
        lefthook
        nixpkgs-fmt
        deadnix

        nwg-look
      ];
      shellHook = ''
        lefthook install
      '';
    };

    devShell.${system} = pkgs.callPackage ./nixos/shell.nix {inherit agenix;};

    homeConfigurations = pkgs.callPackage ./home-manager args;

    nixosConfigurations = {
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
    };

    nixConfig = {
      extra-substituters = ["https://helix.cachix.org"];
      extra-trusted-public-keys = ["helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="];
    };
  };
}
