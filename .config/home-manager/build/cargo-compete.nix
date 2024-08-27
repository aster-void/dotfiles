{ pkgs, ... }:
let
  cargo-compete = pkgs.rustPlatform.buildRustPackage rec {
    pname = "cargo-compete";
    version = "0.10.7";

    src = pkgs.fetchFromGitHub {
      owner = "owner";
      repo = pname;
      rev = version;
      hash = "sha256-+s5RBC3XSgb8omTbUNLywZnP6jSxZBKSS1BmXOjRF8M=";
    };
    cargoHash = "sha256-wJpIWorqycG8C42BmiAb1/UIDib5G06sEE1b2qPtVAU=";
    doCheck = false;
  };
in
cargo-compete
