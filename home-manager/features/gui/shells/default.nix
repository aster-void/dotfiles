{lib, ...}: {
  imports = [
    ./glassy.nix
    ./caelestia-shell.nix
  ];

  options.my.shell = {
    enable = lib.mkEnableOption "shell configuration";
    type = lib.mkOption {
      type = lib.types.enum ["glassy" "caelestia-shell"];
      default = "glassy";
      description = "Which shell implementation to use";
    };
  };
}
