{
  shared,
  meta,
  ...
}: let
  git-config = shared.config.git;
in {
  programs.git = {
    inherit (git-config) aliases;
    enable = true;
    userName = meta.git.user;
    userEmail = meta.git.email;
    extraConfig = {
      core.editor = git-config.core.editor;
      init.defaultBranch = git-config.init.defaultBranch;
      pull.rebase = git-config.pull.rebase;
    };
  };
}
