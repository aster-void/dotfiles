{
  imports = [
    ./packages.nix

    ../../features/gui
    ../../features/xdg
  ];

  my.shell = {
    enable = true;
    type = "caelestia-shell";
  };
}
