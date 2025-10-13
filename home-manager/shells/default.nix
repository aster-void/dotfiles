{lib, ...}: {
  imports = [
    ./glassy
    ./caelestia
  ];

  options.my.shell = {
    glassy.enable = lib.mkEnableOption "glassy shell";
    caelestia.enable = lib.mkEnableOption "caelestia shell";
  };
}
