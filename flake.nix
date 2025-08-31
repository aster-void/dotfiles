{
  description = "Home Manager configuration of aster";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    shared-config.url = "github:aster-void/shared-config";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # my patch applied
    helix = {
      # url = "github:helix-editor/helix";
      url = "github:aster-void/helix?ref=all-patch-applied";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-monitor = {
      url = "github:aster-void/Claude-Code-Usage-Monitor?ref=add-nix-flake-distribution";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprpanel = {
    # url = "github:Jas-SinghFSU/HyprPanel";
    # inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    nixpkgs,
    shared-config,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    dotfilesDir = ".dotfiles"; # path to dotfiles from ~ (gets appended after ${home.homeDir}/)
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    shared = shared-config.config;

    build = pkgs.callPackage ./home-manager/build/default.nix {};

    username = "aster";
    extraSpecialArgs = {
      inherit username system shared dotfilesDir;
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

    homeConfigurations = pkgs.callPackage ./home-manager {
      inherit
        inputs
        extraSpecialArgs
        build
        ;
    };
    nixConfig = {
      extra-substituters = ["https://helix.cachix.org"];
      extra-trusted-public-keys = ["helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="];
    };
  };
}
