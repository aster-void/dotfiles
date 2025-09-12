{
  shared,
  pkgs,
  ...
}: {
  imports = [
    # display manager
    # ./display-managers/sddm.nix
    ./display-managers/ly.nix
    # ./display-managers/gdm.nix

    # ./window-managers/gnome.nix
    # ./window-managers/plasma6.nix
    ./window-managers/hyprland.nix
  ];
  services.displayManager.autoLogin.user = shared.system.user;
  environment.systemPackages = with pkgs; [wl-clipboard];

  services = {
    displayManager.defaultSession = "hyprland-uwsm";
    xserver.enable = true;
    libinput.enable = true;
  };

  environment.variables = {
    QT_QPA_PLATFORM = "wayland;xcb"; # allow fallback to x11 (xwayland) when wayland is not found
    ELECTRON_OZONE_PLATFORM_HINT = "auto"; # hyprland wiki says it should be "auto"
  };

  programs = {
    xwayland.enable = true;
    dconf.enable = true;
  };

  # compat + gui libs (i'm not familiar)
  qt.enable = true;

  # XDG portals (I'm not sure what this is)
  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
