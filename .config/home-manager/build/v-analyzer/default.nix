{ pkgs }:
let
  version = "0.0.5";
  mode = "debug";
in
pkgs.stdenv.mkDerivation {
  pname = "v-analyzer";
  inherit version;
  src = pkgs.fetchFromGitHub {
    owner = "vlang";
    repo = "v-analyzer";
    rev = version;
    fetchSubmodules = true;
    hash = "sha256-uEvPnqRh+ZC+qjMlrWt3+nOBA3MUIa3TIboBS8A3UzY=";
  };
  nativeBuildInputs =
    if mode == "debug" then [ pkgs.vlang pkgs.tinycc ]
    else if mode == "release" then [ pkgs.vlang pkgs.tinycc pkgs.glibc.static ]
    else [ ];
  buildPhase = ''
    # prepare
    export CC=tcc
    mkdir -p $out
    export HOME=/build # V uses this for something, apparently

    # build
    v build.vsh ${mode} # FIXME: release build is not working
    # copy
    cp -r bin $out
  '';
}

