{ lib, pkgs }:
let
  self-hosting = import ./build/import.nix { inherit lib pkgs; };
  downloaded = with pkgs;  [
    firefox
    nodejs_22
    vscode
    slack
    chromium
    zoom-us
    yt-dlp
    screenfetch
    neofetch
    discord
    steam
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    waybar

    lolcat
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
in
downloaded ++ self-hosting
