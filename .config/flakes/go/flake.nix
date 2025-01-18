{
  description = "dev shell template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      name = "hello";
    in {
      packages.default = pkgs.buildGoModule {
        inherit name;
        src = ./.;
        vendorHash = null;
        buildPhase = ''
          go build -o ${name} .
        '';
        installPhase = ''
          mkdir -p $out/bin
          mv ${name} $out/bin/${name}
        '';
      };
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          go
          gopls
        ];
      };
    });
}
