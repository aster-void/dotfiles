{...}: {
  my.profile-dev.docker.rootful = true;

  virtualisation.docker = {
    daemon.settings = {
      live-restore = false;
      ipv6 = true;
      # must start with "fd"
      fixed-cidr-v6 = "fd8e:5f6a:1029::/48";
    };
  };
}
