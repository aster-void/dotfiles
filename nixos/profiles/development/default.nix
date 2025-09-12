{pkgs, ...}: {
  # 開発環境用パッケージ（インライン化）
  environment.systemPackages = with pkgs; [
    # Editors
    vim
    claude-code

    # Language servers - Rust
    rustfmt
    rust-analyzer
    clippy

    # Language servers - Go
    gopls
    golangci-lint
    golangci-lint-langserver

    # Language servers - TS/JS/CSS/HTML
    biome
    typescript-language-server
    emmet-ls
    tailwindcss-language-server
    svelte-language-server
    vscode-langservers-extracted
    astro-language-server

    # Language servers - Other languages
    fsautocomplete # F#
    metals # Scala
    bash-language-server
    glsl_analyzer

    # Language servers - Nix
    alejandra
    nil
    nixd
    statix

    # Markup language servers
    marksman
    markdown-oxide
    taplo
    dockerfile-language-server-nodejs
    docker-compose-language-service
    yaml-language-server
    hyprls
    tinymist
    typstyle
    fixjson

    # AI/General LSPs
    lsp-ai
    helix-gpt

    # Other development tools
    blockbench
  ];

  # Virtualization
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    waydroid.enable = true;
  };

  # Additional development packages
  environment.systemPackages = with pkgs; [
    kubernetes
    kubectl
    k3s
  ];
}
