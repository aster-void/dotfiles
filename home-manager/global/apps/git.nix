{
  shared,
  meta,
  ...
}: {
  programs.git = {
    enable = true;
    settings =
      meta.git // shared.config.git;
  };
}
