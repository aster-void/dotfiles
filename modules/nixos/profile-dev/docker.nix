{lib, ...}: {
  virtualisation.docker = {
    enable = lib.mkDefault true;
    enableOnBoot = false;
    rootless = {
      enable = lib.mkDefault true;
      setSocketVariable = lib.mkDefault true;
    };
  };

  # Workaround: setSocketVariable uses environment.extraInit which doesn't support fish.
  # environment.sessionVariables also doesn't work with fish due to __NIXOS_SET_ENVIRONMENT_DONE bug.
  # See: https://github.com/NixOS/nixpkgs/issues/173421
  programs.fish.interactiveShellInit = ''
    set -gx DOCKER_HOST "unix://$XDG_RUNTIME_DIR/docker.sock"
  '';
}
