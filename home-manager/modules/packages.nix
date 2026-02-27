{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # === System ===

    ## Shell & Terminal Multiplexer
    starship
    tmux
    zellij

    ## Core utils
    ripgrep
    bat
    fd
    lsof
    dotter
    tree
    eza
    procs
    tokei
    difftastic
    xh

    ## System info
    btop
    fastfetch
    nitch

    ## File management
    yazi
    fzf
    zoxide

    ## Data format and transform
    jq
    yq-go
    nushell

    # === Development ===

    ## Environment Loader
    cachix
    direnv
    devenv
    nix-direnv
    mise

    ## Runtimes
    bun
    nodejs
    uv

    ## Git and GitHub
    git
    gh
    ghq
    lazygit

    ## Utility CLIs
    nh
    nix-search-cli
    agenix-cli

    ## Editor
    helix

    ## LSP, MCP and Formatters

    ### Nix
    nixd
    nixfmt
    alejandra
    mcp-nixos

    ### Shell languages
    bash-language-server

    ### TS and web languages
    typescript-language-server
    typescript
    vscode-langservers-extracted
    tailwindcss-language-server
    prettier

    ### F#
    dotnet-sdk
    fsautocomplete
    fantomas

    ### Data & Markup
    marksman
    taplo

    # === Documents ===
    pandoc
  ];
}
