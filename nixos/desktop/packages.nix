{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Browsers
    firefox
    chromium
    brave

    # Development - GUI
    zed-editor
    windsurf
    drawio

    # Terminals
    alacritty
    wezterm
    kitty
    ghostty

    # System management
    blueberry
    dunst
    bluez
    bluez-tools
    pavucontrol
    pulseaudio
    brightnessctl
    asciinema
    solaar
    nvtopPackages.full

    # Window manager utilities
    hyprpicker
    blobdrop
    hyprshot
    gpu-screen-recorder
    wf-recorder
    variety
    hyprpaper
    waybar
    polybar
    eww
    nwg-launchers
    walker
    rofi

    # Media viewers
    feh
    kdePackages.gwenview
    vlc
    playerctl

    # Communication
    slack
    discord
    vesktop
    legcord
    jitsi

    # Productivity
    notion-app-enhanced
    appflowy
    obsidian

    # Image editing
    nomacs
    gthumb
    gimp
    localsend

    # GUI libraries
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    qt6Packages.qtstyleplugin-kvantum
    gtk3
    gtk4
    xwayland
  ];
}
