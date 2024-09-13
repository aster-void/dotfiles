{ lib, pkgs }:
let
  self-hosting = import ./build/import.nix { inherit lib pkgs; };
  downloaded = with pkgs;  [
    # Development
    nodejs_22
    vscode
    act
    postgresql

    # GUI Applications

    ## Connect
    slack
    discord

    ## Browsers
    firefox
    chromium
    brave
    # firefox-devedition

    ## Office
    libreoffice
    evince # document viewer

    # CLI Applications
    ## Music
    cmus
    cava
    yt-dlp
    lollypop

    ## .*fetch
    screenfetch
    neofetch

    # Desktop Enhancement
    waybar


    ##
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
in
downloaded ++ self-hosting
