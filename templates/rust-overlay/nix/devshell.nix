{pkgs}:
pkgs.mkShell {
  packages = [
    pkgs.rust-toolchain
  ];
}
