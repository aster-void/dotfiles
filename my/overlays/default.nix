{
  inputs,
  system,
}: (
  _: _: {
    my = inputs.self.packages.${system};
  }
)
