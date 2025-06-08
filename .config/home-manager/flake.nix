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
    pkgs = nixpkgs.legacyPackages.${system};
    shared = shared-config.config;

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
      preprocess = {enable-pkgs}:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs extraSpecialArgs;
          modules = [
            ./home.nix
            (import ./template/packages.nix {
              inherit enable-pkgs;
            })
          ];
        };
      standard-wsl-packaegs = [
        "cli"
        [
          pkgs.helix
        ]
      ];
      standard-desktop-packages = [
        "cli"
        "desktop"
        "editor"
        "large"
        [
          inputs.helix.packages.${system}.default
          inputs.zen-browser.packages.${system}.beta
        ]
      ];
    in {
      amberwood = preprocess {
        enable-pkgs = standard-desktop-packages;
      };
      amberwood-wsl = preprocess {
        enable-pkgs = standard-wsl-packaegs;
      };
      bogster = preprocess {
        enable-pkgs = standard-desktop-packages;
      };
      carbon = preprocess {
        enable-pkgs = standard-desktop-packages;
      };
      carbon-wsl = preprocess {
        enable-pkgs = standard-wsl-packaegs;
      };
    };
  };
  nixConfig = {
    extra-substituters = ["https://helix.cachix.org"];
    extra-trusted-public-keys = ["helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="];
  };
}
