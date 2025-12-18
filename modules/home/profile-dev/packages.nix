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

    # == Multimedia ==
    ffmpeg
    imagemagick
    chafa
    timg
    asciinema

    # == Terminal ==
    kitty.terminfo
    tmux

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

    # == Languages ==
    ## Haskell
    haskell-language-server
    ormolu
    ## OCaml
    ocamlPackages.ocaml-lsp
    ocamlformat
    ## Crystal
    crystalline
    ## C# (.NET)
    dotnet-sdk
    csharp-ls
    omnisharp-roslyn
    csharpier
    ## F# (.NET - shares dotnet-sdk with C#)
    fsautocomplete
    fantomas
    ## Go
    gopls
    golangci-lint
    golangci-lint-langserver
    ## Shell
    shellcheck
    shfmt
    ## Rust
    rust-analyzer
    rustfmt
    clippy
    cargo-depgraph
    ## C/C++
    llvmPackages.clang-tools # clangd, clang-format
    ## Python
    pyright
    ty
    ruff
    ## Elixir
    elixir
    ## Scala (JVM)
    scala
    sbt
    metals
    ## Kotlin (JVM)
    kotlin
    kotlin-language-server
    ## Julia
    julia
    # LSP: install via Pkg.add("LanguageServer") in Julia
    ## R
    R
    rPackages.languageserver
    ## Gleam (Erlang/BEAM - LSP built-in: gleam lsp)
    gleam
    erlang
    rebar3
    ## Roc (broken in nixpkgs - tests fail)
    # roc
    ## Shell (Bash/Fish/Nushell)
    fish
    # zsh
    # zsh-completions
    # zsh-syntax-highlighting
    nushell
    bash-language-server
    fish-lsp
    ## Lua
    lua-language-server
    ## Web (JS/TS/HTML/CSS)
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
    ## Markdown
    markdown-oxide
    marksman
    ## YAML / TOML
    yaml-language-server
    taplo
    ## Docker
    dockerfile-language-server
    docker-compose-language-service
    ## SQL
    postgresql # psql
    litecli
    postgres-language-server
    ## GLSL
    glsl_analyzer
    ## JSON
    fixjson
    ## Hyprlang
    hyprls
    ## Misc
    graphviz

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
  ];
}
