{
  imports = [
    ./gui.nix
    ./ime.nix

    # display manager
    ./display-managers/sddm.nix
    # ./display-managers/ly.nix
    # ./display-managers/gdm.nix

    # ./window-managers/gnome.nix
    # ./window-managers/plasma6.nix
    ./window-managers/hyprland.nix
  ];
}
