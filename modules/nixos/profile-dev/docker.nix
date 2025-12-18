{
  lib,
  config,
  ...
}: let
  cfg = config.my.profile-dev.docker;
  rootless = !cfg.rootful;
in {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    rootless = lib.mkIf rootless {
      enable = true;
      setSocketVariable = true;
    };
    daemon.settings = {
      dns = ["8.8.8.8" "1.1.1.1"];
    };
  };

  # Workaround: setSocketVariable uses environment.extraInit which doesn't support fish.
  # environment.sessionVariables also doesn't work with fish due to __NIXOS_SET_ENVIRONMENT_DONE bug.
  # See: https://github.com/NixOS/nixpkgs/issues/173421
  programs.fish.interactiveShellInit = lib.mkIf rootless ''
    set -gx DOCKER_HOST "unix://$XDG_RUNTIME_DIR/docker.sock"
  '';
}
