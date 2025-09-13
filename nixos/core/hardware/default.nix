{
  imports = [
    ./drivers
    ./sound.nix
    ./bluetooth.nix
    ./battery.nix
  ];
  hardware.graphics.enable = true;
}
