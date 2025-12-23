{
  pkgs,
  flake,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  nix-repository = inputs.nix-repository.packages.${system};
in {
  home.packages = with pkgs; [
    # == Desktop utilities ==
    dex # generate .desktop entries from AppImages
    libnotify # notify-send
    edid-decode

    # == GPU diagnostics ==
    vulkan-tools # vulkaninfo
    mesa-demos # glxinfo, eglinfo
    libva-utils # vainfo
    vdpauinfo

    # == System tray ==
    volumeicon
    networkmanagerapplet

    # == File managers ==
    baobab # disk usage analyzer
    fsearch
    filezilla
    feh
    kdePackages.gwenview
    nemo
    nix-repository.nohrs
    dragon-drop

    # == Browsers ==
    inputs.zen-browser.packages.${system}.beta
    firefox
    chromium
    brave

    # == Communication ==
    thunderbird
    slack
    discord
    vesktop # Vencord
    legcord
    jitsi

    # == Media ==
    amberol
    vlc
    playerctl
    kooha
    nomacs
    gthumb
    gimp
    inkscape
    pinta

    # == Productivity ==
    appflowy
    obsidian
    libreoffice
    drawio

    # == System utilities ==
    mission-center
    authenticator # 2FA
    localsend
    arandr

    # == Code editors ==
    zed-editor
    windsurf
    code-cursor
    cursor-cli

    # == Terminals ==
    alacritty

    # == Bluetooth ==
    blueberry

    # == Audio/Video control ==
    pavucontrol
    solaar # Logitech devices

    # == Hyprland/Wayland ==
    hyprpicker
    blobdrop
    hyprshot
    gpu-screen-recorder
    wf-recorder
    variety
    hyprpaper
    wdisplays # instant apply (no persistence)
    nwg-displays # persistent config

    # == Status bars ==
    waybar
    polybar
    eww
    cava

    # == Launchers ==
    nwg-launchers
    fuzzel
    rofi

    # == Notification ==
    dunst

    # == AI ==
    inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs

    # == Custom ==
    flake.packages.${system}.setpaper
  ];
}
