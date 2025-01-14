{ pkgs, inputs, ... }:
let
  self-hosted = pkgs.callPackage ../build/default.nix { };
in
{
  home.packages = with pkgs; [

    # GUI Applications

    # waydroid
    self-hosted.waydroid-ui
    self-hosted.reload

    ## Desktop
    hyprshot
    walker
    rofi
    ### waybar
    pavucontrol

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

    ## Office
    libreoffice
    evince # document viewer
    video-trimmer # trim videos. what did you expect?

    # CLI Applications
    ## Terminal (akctually it's rather a GUI application than a CLI application)
    ghostty
    kitty

    ## Music
    cmus
    yt-dlp
    lollypop

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
