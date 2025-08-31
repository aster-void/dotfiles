# TODO: share the config between nixos-config
{shared, ...}: let
  inherit (shared) git-config;
in {
  programs.git = {
    inherit (git-config) aliases;
    enable = true;
    userName = git-config.user.user;
    userEmail = git-config.user.email;
    extraConfig = {
      core.editor = git-config.core.editor;
      init.defaultBranch = git-config.init.defaultBranch;
      pull.rebase = git-config.pull.rebase;
    };
  };
}
