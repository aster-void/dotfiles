{
  inputs,
  system,
}: (
  _: _: {
    my =
      inputs.self.packages.${system}
      // inputs.nix-repository.packages.${system};
  }
)
