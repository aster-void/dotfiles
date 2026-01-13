{
  pkgs,
  flake,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  nix-repository = inputs.nix-repository.packages.${system};

  # Portal-first xdg-open wrapper (fixes link opening on Hyprland)
  xdg-open-portal = pkgs.writeShellScriptBin "xdg-open" ''
    if ${pkgs.glib.bin}/bin/gdbus call --session \
        --dest org.freedesktop.portal.Desktop \
        --object-path /org/freedesktop/portal/desktop \
        --method org.freedesktop.portal.OpenURI.OpenURI \
        --timeout 5 "" "$1" {} 2>/dev/null; then
      exit 0
    fi
    echo "[xdg-open] Portal failed, falling back to xdg-utils" >&2
    exec ${pkgs.xdg-utils}/bin/xdg-open "$@"
  '';
in {
  home.packages = with pkgs; [
    # == Desktop utilities ==
    xdg-open-portal
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

    # == Communication ==
    thunderbird
    jitsi

    # == Media ==
    amberol
    mpv
    vlc
    playerctl
    kooha
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

    # == Code editors ==
    windsurf
    code-cursor
    cursor-cli

    # == Bluetooth ==
    blueberry

    # == KDE ==
    kdePackages.kdeconnect-kde

    # == Audio/Video control ==
    pavucontrol
    solaar # Logitech devices

    # == Wayland ==
    hyprpicker
    blobdrop
    hyprshot
    gpu-screen-recorder
    wf-recorder
    variety
    nwg-displays

    # == Launchers ==
    nwg-launchers
    fuzzel
    rofi

    # == AI ==
    inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs

    # == Security ==
    clamtk

    # == Custom ==
    flake.packages.${system}.setpaper
  ];
}
