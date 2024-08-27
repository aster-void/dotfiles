{ pkgs }:
let
  package-name = pkgs.rustPlatform.buildRustPackage rec {
    pname = "package name";
    version = "package version";

    src = pkgs.fetchFromGitHub {
      owner = "owner";
      repo = pname;
      rev = version;
      hash = "sha256-+s5RBC3XSgb8omTbUNLywZnP6jSxZBKSS1BmXOjRF8M=";
    };
    cargoHash = "sha256-gsE9qHigEm5R1+lJU9uazWJ/8yZZjE0eVJDtZlX0SmM=";
    doCheck = false;
  };
in
package-name
