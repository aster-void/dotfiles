{
  inputs,
  system,
}: (
  _final: _prev: {
    my =
      inputs.self.packages.${system}
      // inputs.nix-repository.packages.${system};

    hyprshot = inputs.nixpkgs.legacyPackages.${system}.callPackage ./hyprshot-fix/package.nix {};
  }
)
