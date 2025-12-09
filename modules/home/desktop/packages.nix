{
  pkgs,
  flake,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  home.packages = with pkgs; [
    # == Desktop utilities ==
    dex # generate .desktop entries from AppImages
    libnotify # send desktop notifications (notify-send)
    edid-decode # decode EDID from monitors

    # == System tray apps ==
    volumeicon # volume control in systray
    networkmanagerapplet # NetworkManager GUI in systray

    # == File managers & viewers ==
    baobab # disk usage analyzer (GNOME)
    fsearch # fast file search (GTK)
    filezilla # FTP/SFTP client
    feh # simple image viewer
    kdePackages.gwenview # image viewer (KDE)
    nemo # file manager
    timg # terminal image viewer
    dragon-drop # drag & drop utility

    # == Browsers ==
    inputs.zen-browser.packages.${system}.beta # Zen browser
    firefox # Mozilla Firefox
    chromium # open-source Chrome
    brave # privacy-focused browser

    # == Communication ==
    thunderbird # email client
    slack # team messaging
    discord # gaming/community chat
    vesktop # Discord client (Vencord)
    legcord # Discord client (lightweight)
    jitsi # video conferencing

    # == Media ==
    amberol # music player (GNOME)
    vlc # media player
    playerctl # media player control
    kooha # screen recorder (GNOME)
    nomacs # image viewer/editor
    gthumb # image viewer/organizer
    gimp # image editor
    inkscape # vector graphics editor
    pinta # simple image editor

    # == Productivity ==
    appflowy # Notion alternative
    obsidian # note-taking (Markdown)
    libreoffice # office suite
    drawio # diagram editor

    # == System utilities ==
    mission-center # resource monitor (GNOME)
    authenticator # 2FA app
    localsend # local file sharing
    arandr # display configuration

    # == Code editors ==
    zed-editor # Zed editor
    windsurf # AI code editor
    code-cursor # Cursor AI editor
    cursor-cli # Cursor CLI

    # == Terminals ==
    alacritty # GPU-accelerated terminal
    kitty # feature-rich terminal
    ghostty # fast terminal

    # == Bluetooth ==
    blueberry # Bluetooth manager (GUI)
    bluez # Bluetooth protocol stack
    bluez-tools # Bluetooth CLI tools

    # == Audio/Video control ==
    pavucontrol # PulseAudio volume control
    pulseaudio # audio server utilities
    brightnessctl # brightness control
    asciinema # terminal recorder
    solaar # Logitech device manager

    # == Hyprland/Wayland tools ==
    hyprpicker # color picker
    blobdrop # drag & drop from terminal
    hyprshot # screenshot tool
    gpu-screen-recorder # GPU-based screen recorder
    wf-recorder # Wayland screen recorder
    variety # wallpaper manager
    hyprpaper # Wayland wallpaper daemon

    # == Status bars ==
    waybar # Wayland status bar
    polybar # X11/Wayland status bar
    eww # ElKowars Wacky Widgets
    cava # audio visualizer

    # == Launchers ==
    nwg-launchers # Wayland launchers
    fuzzel # Wayland app launcher
    rofi # app launcher

    # == Notification ==
    dunst # notification daemon

    # == Qt/GTK libraries ==
    libsForQt5.qt5.qtwayland # Qt5 Wayland support
    qt6.qtwayland # Qt6 Wayland support
    qt6Packages.qtstyleplugin-kvantum # Qt theme engine
    gtk3 # GTK3 library
    gtk4 # GTK4 library
    xwayland # X11 compatibility for Wayland

    # == AI desktop apps ==
    inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs # Claude desktop app

    # == Custom packages ==
    flake.packages.${system}.setpaper # wallpaper setter
  ];
}
