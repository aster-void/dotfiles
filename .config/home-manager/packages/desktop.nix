{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [

    # GUI Applications

    ## Desktop
    waybar

    ## Social
    slack
    discord

    ## Browsers
    firefox
    chromium
    brave
    inputs.zen-browser.packages.${system}.default
    # LLM
    ollama

    ## Office
    libreoffice
    evince # document viewer

    # CLI Applications

    ## Music
    cmus
    yt-dlp
    lollypop

    ## visual effect
    fastfetch
    cava

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
