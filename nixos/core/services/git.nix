{
  meta,
  shared,
  ...
}: {
  # Git設定
  programs.git = {
    enable = true;
    config = {
      user = {
        inherit (meta.git) email;
        name = meta.git.user;
      };
      core.editor = "hx";
      init.defaultBranch = "main";
      pull.rebase = "true";
      alias = shared.config.git.aliases;
    };
  };
}
