{
  pkgs,
  inputs,
  ...
}: let
  self-hosted = pkgs.callPackage ../build/default.nix {};
in {
  home.packages = with pkgs; [
    self-hosted.waydroid-ui
    self-hosted.reload

    ## Desktop
    hyprshot
    gpu-screen-recorder
    mako # notification daemon

    ### bars
    ags
    ### Launchers
    nwg-launchers
    walker
    rofi
    waybar
    polybar
    eww

    ### media ctl
    pavucontrol
    pulseaudio
    brightnessctl
    asciinema

    ## bluetooth
    bluez
    bluez-tools

    ## Social
    slack
    discord

    ## Browsers
    firefox
    chromium
    brave
    inputs.zen-browser.packages.${system}.beta

    # LLM
    ollama

    # editor
    zed-editor

    ## Office
    libreoffice
    evince # document viewer
    video-trimmer # trim videos. what did you expect?
    xournalpp

    matugen # material you colorgen
    dart-sass
    gnome-bluetooth

    ## Terminal (akctually it's rather a GUI application than a CLI application)
    ghostty
    kitty

    ## Music
    cmus
    yt-dlp
    lollypop
    mpd
    mpc

    ## visual effect
    fastfetch
    nitch
    cava

    ## debug
    libnotify
    speedtest-cli

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
