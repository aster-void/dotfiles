# <https://zenn.dev/asa1984/books/nix-hands-on/viewer/ch04-02-rust-project>
{
  toolchain,
  makeRustPlatform,
}: let
  rustPlatform = makeRustPlatform {
    rustc = toolchain;
    cargo = toolchain;
  };
in
  rustPlatform.buildRustPackage {
    pname = "hello";
    version = "0.0.0";
    src = ./.;
    cargoLock.lockFile = ./Cargo.lock;
  }
