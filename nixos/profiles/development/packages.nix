{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.profiles;
in {
  programs.chrome-devtools-mcp.enable = true;
  environment.systemPackages = lib.optionals cfg.development.enable (with pkgs; [
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
    dockerfile-language-server
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
  ]);
}
