{lib, ...}: {
  virtualisation.docker = {
    enable = lib.mkDefault true;
    rootless = {
      enable = lib.mkDefault true;
      setSocketVariable = lib.mkDefault true;
    };
  };
}
