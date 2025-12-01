{
  description = "Home Manager configuration of aster";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-repository.url = "github:aster-void/nix-repository";
    nix-repository.inputs.nixpkgs.follows = "nixpkgs";

    # patch / workaround inputs
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # NixOS-specific inputs
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.inputs.rust-overlay.follows = "rust-overlay";
    comin.url = "github:nlewo/comin";
    comin.inputs.nixpkgs.follows = "nixpkgs";

    # HM-specific inputs
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
    caelestia-shell.url = "github:caelestia-dots/shell";
    caelestia-shell .inputs.nixpkgs.follows = "nixpkgs";
    caelestia-cli.url = "github:caelestia-dots/cli";
    caelestia-cli.inputs.nixpkgs.follows = "nixpkgs";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
    mcp-servers-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    meta = import ./meta.nix;
    inherit (meta) system;

    myOverlay = import ./my/overlays/default.nix {inherit inputs system;};
    overlays = [
      myOverlay
    ];
    pkgs = import nixpkgs {
      inherit system overlays;
      config = {
        allowUnfree = true;
      };
    };

    args = {
      inherit inputs meta nixpkgs overlays;
      shared = import ./shared;
    };
  in {
    inherit inputs overlays;
    packages.${system} = import ./my/pkgs/default.nix {inherit inputs pkgs;};
    nixosModules = import ./my/nixosModules;

    templates = {
      default = {
        path = ./templates/default;
        description = "Simple flake with a devshell";
      };
      prisma = {
        path = ./templates/prisma;
        description = "Prisma project template with nix-prisma-utils";
      };
      rust-overlay = {
        path = ./templates/rust-overlay;
        description = "Rust project";
      };
    };

    devShells.${system}.default = pkgs.mkShell {
      name = "dotfiles";
      packages = with pkgs; [
        # automation
        lefthook
        gitleaks

        # nix
        alejandra
        deadnix
        statix
        nil

        # domain
        nwg-look
        inputs.agenix.packages.${toString pkgs.system}.default
      ];
      env = {
        RULES = "secrets/secrets.nix";
      };
      shellHook = ''
        lefthook install
      '';
    };

    homeConfigurations = pkgs.callPackage ./home-manager args;

    nixosConfigurations = pkgs.callPackage ./nixos args;

    nixConfig = {
      extra-substituters = [
        "https://helix.cachix.org"
        "https://nix-repository--aster-void.cachix.org"
      ];
      extra-trusted-public-keys = [
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "nix-repository--aster-void.cachix.org-1:A+IaiSvtaGcenevi21IvvODJoO61MtVbLFApMDXQ1Zs="
      ];
    };
  };
}
