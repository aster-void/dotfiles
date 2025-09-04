{
  shared,
  pkgs,
  ...
}: {
  imports = [
    # Display manager: using LY (others available: sddm.nix, gdm.nix)
    ./display-manager/ly.nix

    # Desktop environment: using Hyprland (others available: gnome.nix, plasma6.nix)
    ./hyprland.nix
  ];

  services = {
    displayManager.defaultSession = "hyprland-uwsm";
    # Enable the X11 windowing system. (or maybe it was just named poorly and may also work for wayland idk)
    xserver.enable = true;
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
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

  services.displayManager.autoLogin.user = shared.system.user;
}
