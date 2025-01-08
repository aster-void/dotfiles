{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [

    # GUI Applications

    ## Desktop
    hyprshot
    walker
    rofi

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

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
