{
  my,
  pkgs,
  system,
  inputs,
  ...
}: {
  home.packages =
    (with pkgs; [
      # Dev Tools
      claude-code
      crush
      codex
      my.ccusage
      my.ccusage-codex
      my.ccusage-mcp
      postgresql
      litecli
      tokei

      ## dep graph
      cargo-depgraph
      graphviz

      # editors
      vim
      code-cursor
      cursor-cli

      # LSs
      # Coding languages
      ## Rust
      rustfmt
      rust-analyzer
      clippy

      ## Go
      gopls
      golangci-lint
      golangci-lint-langserver

      ## TS/JS/CSS/HTML/ESLint/Svelte
      biome
      typescript-language-server
      emmet-ls
      tailwindcss-language-server
      svelte-language-server
      vscode-langservers-extracted # HTML/CSS/JSON/ESLint all in one
      astro-language-server

      ## F#
      fsautocomplete

      ## Nix
      alejandra
      nixfmt-rfc-style # some repos require this as the formatter
      nil
      nixd
      statix

      ## Scala
      metals

      ## Bash
      bash-language-server

      ## GLSL
      glsl_analyzer

      # Markup
      ## Markdown
      marksman
      markdown-oxide

      ## TOML
      taplo

      ## Dockerfile, docker compose
      dockerfile-language-server
      docker-compose-language-service

      ## YAML
      yaml-language-server

      ## Hyprlang
      hyprls

      ## Typst
      tinymist
      typstyle

      ## JSON
      fixjson

      # General LSPs
      lsp-ai
      helix-gpt
    ])
    # mcp servers
    ++ (with inputs.mcp-servers-nix.packages.${system}; [
      mcp-server-filesystem
      serena
      context7-mcp
    ])
    ++ (with pkgs; [
      mcp-nixos
      my.chrome-devtools-mcp
    ]);
}
