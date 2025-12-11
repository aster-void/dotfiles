{...}: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    rootless.enable = false;
    daemon.settings = {
      live-restore = false;
      ipv6 = true;
      # must start with "fd"
      fixed-cidr-v6 = "fd8e:5f6a:1029::/48";
    };
  };

  users.users.aster.extraGroups = ["docker"];

  # Override rootless DOCKER_HOST from profile-dev/docker.nix
  # Use default socket for rootful Docker
  programs.fish.interactiveShellInit = ''
    set -e DOCKER_HOST
  '';
}
