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
    home-manager,
    shared-config,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    shared = shared-config.config;

    build = pkgs.callPackage ./build/default.nix {};

    username = "aster";
    extraSpecialArgs = {
      inherit inputs username system shared;
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

    homeConfigurations = let
      preprocess = {
        enable-pkgs,
        extra-modules ? [],
      }:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs extraSpecialArgs;
          modules =
            [
              ./home.nix
              (import ./template/packages.nix {
                inherit enable-pkgs;
              })
            ]
            ++ extra-modules;
        };
      standard-wsl-packages = [
        "cli"
        "editor"
        [
          pkgs.helix
          inputs.claude-monitor.packages.${system}.default
        ]
      ];
      standard-desktop-packages = [
        "cli"
        "desktop"
        "editor"
        "large"
        [
          pkgs.helix
          inputs.claude-monitor.packages.${system}.default

          # inputs.helix.packages.${system}.default
          inputs.zen-browser.packages.${system}.beta
          # build.line # I give up. install it via steam.
          build.setpaper
          build.reload
          build.reload-d
          build.wpick
        ]
      ];
    in {
      amberwood = preprocess {
        enable-pkgs = standard-desktop-packages;
        extra-modules = [
          ./modules/minecraft
        ];
      };
      amberwood-wsl = preprocess {
        enable-pkgs = standard-wsl-packages;
      };
      bogster = preprocess {
        enable-pkgs = standard-desktop-packages;
        extra-modules = [
          ./modules/minecraft
        ];
      };
      carbon = preprocess {
        enable-pkgs = standard-desktop-packages;
      };
      carbon-wsl = preprocess {
        enable-pkgs = standard-wsl-packages;
      };
    };
  };
  nixConfig = {
    extra-substituters = ["https://helix.cachix.org"];
    extra-trusted-public-keys = ["helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="];
  };
}
