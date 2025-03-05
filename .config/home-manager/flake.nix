{
  description = "Home Manager configuration of aster";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # 最新のを使いたい
    helix = {
      # my patch applied
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
    nixpkgs-stable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    stable = nixpkgs-stable.legacyPackages.${system};

    username = "aster";
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "Home Manager";
      buildInputs = with pkgs; [
        lefthook
        nixpkgs-fmt
        deadnix

        nwg-look
      ];
      shellHook = ''
        lefthook install
      '';
    };

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home.nix
      ];

      extraSpecialArgs = {
        inherit inputs username system stable;
      };
    };
  };
  nixConfig = {
    extra-substituters = ["https://helix.cachix.org"];
    extra-trusted-public-keys = ["helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="];
  };
}
