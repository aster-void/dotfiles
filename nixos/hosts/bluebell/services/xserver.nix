{ pkgs, ... }:
{
  # Lightweight X11 server for headless X11 forwarding
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true; # no display manager, manual startx only
    desktopManager.xterm.enable = false;
  };

  environment.systemPackages = with pkgs; [
    xauth
  ];
}
