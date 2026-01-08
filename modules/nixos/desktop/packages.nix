{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # System
    bluez
    bluez-tools
    pulseaudio
    brightnessctl
    nvtopPackages.full

    # GUI libraries
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    qt6Packages.qtstyleplugin-kvantum
    gtk3
    gtk4
    xwayland
  ];
}
