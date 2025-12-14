{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv) system;
  nix-repository = inputs.nix-repository.packages.${system};
in {
  home.packages = with pkgs; [
    # == Core utilities ==
    coreutils
    bash
    gnused
    gnumake
    tree
    lsof
    file
    psmisc # killall, pstree, fuser
    gettext # envsubst, etc.
    appimage-run
    stow
    most
    xsel
    killall

    # == File search & navigation ==
    ripgrep
    fd
    eza
    bat
    fzf
    yazi

    # == System monitoring ==
    btop
    procs
    ncdu
    nitch
    bandwhich
    inotify-tools
    cpufetch
    fastfetch

    # == Hardware info ==
    duf
    hwinfo
    lshw
    inxi
    hw-probe
    usbutils # lsusb

    # == Debug & tracing ==
    strace
    ltrace
    gdb

    # == Development ==
    watchexec
    hyperfine

    # == Containers ==
    podman

    # == Network ==
    curl
    openssl
    mtr
    iperf3
    nmap
    tcpdump
    wireshark-cli # tshark
    socat
    netcat-openbsd
    bind.dnsutils # dig, nslookup
    traceroute
    iputils
    iproute2
    nettools # ifconfig, netstat
    mosh
    whois
    xh
    wget
    avahi
    speedtest-cli
    cloudflared

    # == Archive ==
    rsync
    zip
    unzip
    gnutar

    # == Encryption ==
    age

    # == Data processing ==
    jq
    yq-go
    sd
    jless
    moreutils # sponge, parallel, etc.
    nushell
    postgresql # psql
    litecli

    # == Multimedia ==
    ffmpeg
    imagemagick
    chafa
    timg
    asciinema

    # == Terminal ==
    kitty.terminfo
    tmux

    # == Shells ==
    fish
    zsh
    zsh-completions
    zsh-syntax-highlighting

    # == Shell prompt ==
    starship

    # == Editors ==
    vim

    # == Git ==
    git
    ghq
    lazygit
    difftastic
    tig
    gitleaks
    tokei
    act
    wrkflw

    # == Dependency graph ==
    cargo-depgraph
    graphviz

    # == Language servers & formatters ==
    ## OCaml
    ocamlPackages.ocaml-lsp
    ocamlformat
    ## Crystal
    crystalline
    ## C#
    csharp-ls
    omnisharp-roslyn
    csharpier
    ## F#
    fsautocomplete
    fantomas
    ## Go
    gopls
    golangci-lint
    golangci-lint-langserver
    ## Shell
    bash-language-server
    fish-lsp
    ## Rust
    rust-analyzer
    rustfmt
    clippy
    ## C/C++
    llvmPackages.clang-tools # clangd, clang-format
    ## Python
    pyright
    ## YAML / TOML
    yaml-language-server
    taplo
    ## Docker
    dockerfile-language-server
    docker-compose-language-service
    ## Lua
    lua-language-server
    ## Web
    typescript-language-server
    javascript-typescript-langserver
    biome
    prettier
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint LSPs
    astro-language-server
    emmet-ls
    superhtml
    svelte-language-server
    tailwindcss-language-server
    ## Markdown
    markdown-oxide
    marksman
    ## Nix
    nil
    nixd
    alejandra
    nixfmt-rfc-style
    statix
    diffoscope
    ## Typst
    tinymist
    typstyle
    ## Elixir
    elixir
    ## SQL
    postgres-language-server
    ## Scala
    metals
    ## GLSL
    glsl_analyzer
    ## JSON
    fixjson
    ## Hyprlang
    hyprls

    # == AI LSPs ==
    lsp-ai
    llm-ls
    helix-gpt

    # == Nix tools ==
    nh
    nix-prefetch-scripts
    nix-search-cli
    nix-index # nix-locate
    nixos-generators
    hydra-check

    # == Development environments ==
    devenv
    devbox

    # == AI assistants ==
    # claude-code is installed via programs/claude-code using edgepkgs
    codex
    crush # coding agent
    nix-repository.claude-flow # orchestrator
    nix-repository.ruv-swarm
    nix-repository.claude-squad
    nix-repository.ccmanager

    # == MCP tools ==
    nix-repository.mcptools # mcp, mcpx

    # == MCP servers ==
    mcp-nixos
    nix-repository.mcp-language-server
    nix-repository.chrome-devtools-mcp
    nix-repository.kiri # semantic grep
    nix-repository.osgrep # semantic grep
    nix-repository.ck-search # semantic grep
    nix-repository.ccusage
    nix-repository.ccusage-codex
    nix-repository.ccusage-mcp
    inputs.mcp-servers-nix.packages.${system}.mcp-server-filesystem
    inputs.mcp-servers-nix.packages.${system}.serena
    inputs.mcp-servers-nix.packages.${system}.context7-mcp

    # == Repository management ==
    nix-repository.gwq # git worktree manager
    nix-repository.git-gtr # git worktree runner (auto hooks, editor integration)
    nix-repository.zz # ghq + fzf + zellij wrapper
  ];
}
