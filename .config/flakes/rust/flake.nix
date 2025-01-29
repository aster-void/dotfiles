{
  description = "A basic flake ready to be rusty";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    rust-overlay,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      overlays = [(import rust-overlay)];
      pkgs = import nixpkgs {
        inherit
          system
          overlays
          ;
      };
      rust-bin = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
    in {
      packages.default = pkgs.callPackage ./. {toolchain = rust-bin;};
      devShells.default = pkgs.mkShell {
        packages = [
          rust-bin
          pkgs.evcxr
          pkgs.rustc
        ];
      };
    });
}
