{ lib, pkgs, config, ... }:
let
  cfg = config.packages;
  self-hosted = import ./build/import.nix { inherit lib pkgs; };
  core = with pkgs;  [
    # Development
    act
    postgresql
    svelte-language-server
    wget
    ollama
    ## Langservers
    biome
    typescript-language-server
    tailwindcss-language-server
    clippy
    metals # scala
    astro-language-server
    ## terminal multiplexer
    zellij
  ];
  desktop = with pkgs; [
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
    # cava # fails to build
    yt-dlp
    lollypop
    ## .*fetch
    fastfetch
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
{
  options.packages = {
    core.enable = lib.mkEnableOption "Enable core packages";
    desktop.enable = lib.mkEnableOption "Enable desktop packages";
    self-hosted.enable = lib.mkEnableOption "Enable self-built packages (doesn't exist yet)";
  };
  config.home.packages =
    (if cfg.desktop.enable then desktop else [ ]) ++
    (if cfg.core.enable then core else [ ]) ++
    (if cfg.self-hosted.enable then self-hosted else [ ]);
}
