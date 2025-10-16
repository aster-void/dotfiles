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
    sddm-astronaut-theme = {
      url = "github:Keyitdev/sddm-astronaut-theme";
      flake = false;
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcp-servers-nix = {
      url = "github:natsukium/mcp-servers-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    meta = import ./meta.nix;
    inherit (meta) system;

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    args = {
      inherit inputs meta nixpkgs;
      my = {
        pkgs = import ./my/pkgs/default.nix {inherit inputs pkgs;};
      };
      shared = pkgs.callPackage ./shared {};
    };
  in {
    packages = import ./my/pkgs/default.nix {inherit inputs pkgs;};
    devShells.${system}.default = pkgs.mkShell {
      name = "dotfiles";
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
        inputs.agenix.packages.${pkgs.system}.default
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
      extra-substituters = ["https://helix.cachix.org"];
      extra-trusted-public-keys = ["helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="];
    };
  };
}
