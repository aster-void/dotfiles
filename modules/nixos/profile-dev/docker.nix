{lib, ...}: {
  virtualisation.docker = {
    enable = lib.mkDefault true;
    rootless = {
      enable = lib.mkDefault true;
      setSocketVariable = lib.mkDefault true;
    };
  };

  # Workaround: setSocketVariable uses environment.extraInit which doesn't support fish
  environment.sessionVariables.DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/docker.sock";
}
