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
    comin = {
      url = "github:nlewo/comin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    agenix,
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

    mkSystemConfig = {
      host,
      system,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit system inputs host;
          shared = pkgs.callPackage ./shared {};
        };

        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ./nixos/configuration.nix
          ./nixos/hosts/${host}
        ];
      };
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "Home Manager";
      packages = with pkgs; [
        # automation
        lefthook

        # nix
        alejandra
        deadnix
        statix
        nil

        # domain
        nwg-look
        agenix.packages.${pkgs.system}.default
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
      dusk = mkSystemConfig {
        host = "dusk";
        system = "x86_64-linux";
      };
    };

    nixConfig = {
      extra-substituters = ["https://helix.cachix.org"];
      extra-trusted-public-keys = ["helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="];
    };
  };
}
