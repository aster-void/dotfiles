{ pkgs }:
let
  package-name = pkgs.rustPlatform.buildRustPackage rec {
    pname = "package name";
    version = "package version";

    # still not sure how they differ from each other, but they sure do.
    # some theory suggests that buildInputs is for compile time dependencies and
    # nativeBuildInputs is for runtime dependencies.
    buildInputs = [ ];
    nativeBuildInputs = [ ];

    src = pkgs.fetchFromGitHub {
      owner = "owner";
      repo = pname;
      rev = version;
      # let nix decide the hash for you
      hash = "";
    };
    # or, you can also do:
    # src = pkgs.fetchurl {
    #   url = "https://example.com/url/to/the/file.tar.gz";
    #   hash = "";
    # };

    # let nix decide the hash for you
    cargoHash = "";
    doCheck = false;
  };
in
package-name
