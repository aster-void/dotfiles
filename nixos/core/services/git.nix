{
  meta,
  shared,
  ...
}: {
  # Git設定
  programs.git = {
    enable = true;
    config = meta.git // shared.config.git;
  };
}
