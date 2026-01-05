{flake, ...}: {
  imports = [
    flake.homeModules.profile-dev
  ];

  services.syncthing = {
    enable = true;
    settings = {};
  };
}
