{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [wl-clipboard];
    variables = {
      QT_QPA_PLATFORM = "wayland;xcb"; # allow fallback to x11 (xwayland) when wayland is not found
      ELECTRON_OZONE_PLATFORM_HINT = "auto"; # hyprland wiki says it should be "auto"
    };
  };
  services = {
    speechd.enable = true;
    xserver.enable = true;
    libinput.enable = true;
    xserver.displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output Virtual1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
    '';
  };
  programs = {
    xwayland.enable = true;
    dconf.enable = true;
  };

  qt.enable = true;
}
