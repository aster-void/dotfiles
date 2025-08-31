# <https://zenn.dev/asa1984/books/nix-hands-on/viewer/ch04-02-rust-project>
{
  toolchain,
  makeRustPlatform,
}: let
  rustPlatform = makeRustPlatform {
    rustc = toolchain;
    cargo = toolchain;
  };
  cargo-toml = fromTOML (builtins.readFile ./Cargo.toml);
in
  rustPlatform.buildRustPackage {
    inherit (cargo-toml.package) version;
    pname = cargo-toml.package.name;
    src = ./.;
    cargoLock.lockFile = ./Cargo.lock;
  }
