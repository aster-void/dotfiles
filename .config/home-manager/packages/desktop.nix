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
    self-hosted.setpaper
    self-hosted.wpick

    ## Desktop

    ### others
    hyprshot
    hyprpicker
    gpu-screen-recorder # screen recorder
    wf-recorder # another screen recorder
    blobdrop # drag & drop from shell

    ### notification daemon
    mako
    dunst

    ### bars
    # ags
    waybar
    polybar
    eww
    ### Launchers
    nwg-launchers
    walker
    rofi

    ## watch config files and reboot the packages accordingly
    self-hosted.reload-d

    ### media ctl
    pavucontrol
    pulseaudio
    brightnessctl
    asciinema

    solaar # logicool conf
    ## bluetooth
    bluez
    bluez-tools

    ## GPU
    nvtopPackages.full

    ## Social
    slack
    notion-app-enhanced
    vesktop # discord
    discord

    ## Browsers
    firefox
    chromium
    brave
    inputs.zen-browser.packages.${system}.beta
    vivaldi

    # LLM
    ollama

    # editor
    # zed-editor # does not build
    code-cursor
    drawio
    obsidian

    ## Office
    libreoffice
    evince # document viewer
    video-trimmer # trim videos. what did you expect?
    xournalpp

    matugen # material you colorgen
    dart-sass
    gnome-bluetooth
    gthumb # lightweight image cropper ++

    ## Terminal (akctually it's rather a GUI application than a CLI application)
    ghostty
    kitty

    ## Music
    cmus
    yt-dlp
    lollypop
    mpd
    playerctl

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
