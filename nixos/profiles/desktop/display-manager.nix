{shared, ...}: {
  # Display manager configuration for desktop workstations
  services = {
    displayManager = {
      defaultSession = "hyprland-uwsm";
      autoLogin = {
        enable = false; # LY doesn't support auto login
        user = shared.system.user;
      };
      ly.enable = true;
    };

    xserver.enable = true;
    libinput.enable = true;
  };

  programs = {
    xwayland.enable = true;
    dconf.enable = true;
  };

  qt.enable = true;
}
