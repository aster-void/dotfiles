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
    coreutils # GNU core utilities (ls, cat, etc.)
    bash # Bourne Again Shell
    gnused # GNU stream editor
    gnumake # GNU Make build tool
    tree # directory listing as tree
    lsof # list open files
    file # determine file type
    psmisc # killall, pstree, fuser
    gettext # i18n utilities (envsubst, etc.)
    appimage-run # run AppImage applications
    stow # symlink farm manager
    most # pager with horizontal scrolling
    platinum-searcher # code search tool (pt)
    xsel # clipboard manipulation
    killall # kill processes by name

    # == File search & navigation ==
    ripgrep # fast grep (rg)
    fd # fast find alternative
    eza # modern ls replacement
    bat # cat with syntax highlighting
    fzf # fuzzy finder
    yazi # terminal file manager

    # == System monitoring ==
    btop # resource monitor (htop alternative)
    procs # modern ps replacement
    ncdu # disk usage analyzer (TUI)
    nitch # minimal system info
    bandwhich # bandwidth monitor per process
    inotify-tools # filesystem event monitoring
    cpufetch # CPU info display
    fastfetch # system info display (neofetch alternative)

    # == Hardware info ==
    duf # disk usage (df alternative)
    hwinfo # detailed hardware info
    lshw # list hardware
    inxi # human-readable system info
    hw-probe # hardware probe collector
    usbutils # lsusb and friends

    # == Debug & tracing ==
    strace # system call tracer
    ltrace # library call tracer
    gdb # GNU debugger

    # == Development efficiency ==
    watchexec # execute commands on file changes
    hyperfine # command benchmarking

    # == Containers ==
    podman # daemonless container engine

    # == Network tools ==
    curl # data transfer tool
    openssl # TLS/SSL toolkit
    mtr # traceroute + ping
    iperf3 # network bandwidth testing
    nmap # network scanner
    tcpdump # packet analyzer
    wireshark-cli # tshark packet analyzer
    socat # multipurpose relay
    netcat-openbsd # networking swiss army knife
    bind.dnsutils # dig, nslookup
    traceroute # trace packet route
    iputils # ping, etc.
    iproute2 # ip command
    nettools # ifconfig, netstat (legacy)
    mosh # mobile shell (roaming SSH)
    whois # domain lookup
    xh # friendly HTTP client (httpie alternative)
    wget # classic downloader
    avahi # mDNS/DNS-SD tools
    speedtest-cli # internet speed test
    cloudflared # Cloudflare tunnel client

    # == Archive tools ==
    rsync # file synchronization
    zip # zip archiver
    unzip # zip extractor
    gnutar # GNU tar

    # == Security & encryption ==
    age # modern encryption tool

    # == Data processing ==
    jq # JSON processor
    yq-go # YAML processor
    sd # sed alternative
    jless # JSON viewer (TUI)
    moreutils # sponge, parallel, etc.
    nushell # structured data shell
    postgresql # psql client
    litecli # SQLite client with autocomplete

    # == Multimedia ==
    ffmpeg # audio/video converter
    imagemagick # image manipulation

    # == Terminal ==
    kitty.terminfo # kitty terminal info

    # == Terminal multiplexers ==
    zellij # modern terminal multiplexer
    tmux # classic terminal multiplexer

    # == Shells ==
    fish # friendly interactive shell
    zsh # Z shell
    zsh-completions # additional zsh completions
    zsh-syntax-highlighting # zsh syntax highlighting

    # == Shell prompt ==
    starship # cross-shell prompt
    blesh # bash line editor

    # == Editors ==
    helix # modal editor
    vim # classic modal editor

    # == Git & version control ==
    git # distributed VCS
    ghq # repository manager
    lazygit # git TUI
    difftastic # structural diff
    tig # git TUI viewer
    gitleaks # secret scanner
    tokei # code statistics
    act # run GitHub Actions locally
    wrkflw # GitHub workflow CLI

    # == Dependency graph ==
    cargo-depgraph # Rust dependency graph
    graphviz # graph visualization (dot)

    # == Language servers & formatters ==
    ## OCaml
    ocamlPackages.ocaml-lsp # OCaml LSP
    ocamlformat # OCaml formatter
    ## Crystal
    crystalline # Crystal LSP
    ## C#
    csharp-ls # C# LSP
    omnisharp-roslyn # C# LSP (Roslyn-based)
    csharpier # C# formatter
    ## F#
    fsautocomplete # F# LSP
    fantomas # F# formatter
    ## Go
    gopls # Go LSP
    golangci-lint # Go linter
    golangci-lint-langserver # Go linter LSP
    ## Shell
    bash-language-server # Bash LSP
    fish-lsp # Fish LSP
    ## Rust
    rust-analyzer # Rust LSP
    rustfmt # Rust formatter
    clippy # Rust linter
    ## C/C++
    llvmPackages.clang-tools # clangd, clang-format
    ## Python
    pyright # Python LSP
    ## YAML / TOML
    yaml-language-server # YAML LSP
    taplo # TOML LSP & formatter
    ## Docker
    dockerfile-language-server # Dockerfile LSP
    docker-compose-language-service # docker-compose LSP
    ## Lua
    lua-language-server # Lua LSP
    ## Web (JS/TS/HTML/CSS/JSON)
    typescript-language-server # TypeScript LSP
    javascript-typescript-langserver # JS/TS LSP (alternative)
    biome # JS/TS linter & formatter
    prettier # code formatter
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint LSPs
    astro-language-server # Astro LSP
    emmet-ls # Emmet LSP
    superhtml # HTML LSP
    svelte-language-server # Svelte LSP
    tailwindcss-language-server # Tailwind CSS LSP
    ## Markdown
    markdown-oxide # Markdown LSP (wiki-style)
    marksman # Markdown LSP
    ## Nix
    nil # Nix LSP
    nixd # Nix LSP (alternative)
    alejandra # Nix formatter
    nixfmt-rfc-style # Nix formatter (RFC style)
    statix # Nix linter
    diffoscope # reproducibility diff tool
    ## Typst
    tinymist # Typst LSP
    typstyle # Typst formatter
    ## Elixir
    elixir # Elixir language (includes mix)
    ## SQL
    postgres-language-server # PostgreSQL LSP
    ## Scala
    metals # Scala LSP
    ## GLSL
    glsl_analyzer # GLSL LSP
    ## JSON
    fixjson # JSON fixer
    ## Hyprlang
    hyprls # Hyprland config LSP

    # == General LSPs ==
    lsp-ai # AI-powered LSP
    llm-ls # LLM-powered LSP
    helix-gpt # GPT integration for Helix

    # == Nix CLI tools ==
    nh # Nix helper CLI
    nix-prefetch-scripts # fetch sources for Nix
    nix-search-cli # search nixpkgs
    nix-index # nix-locate command
    nixos-generators # generate NixOS images
    hydra-check # check Hydra build status

    # == Development environments ==
    devenv # development environments
    devbox # portable dev environments
    crush # data processing tool

    # == AI assistants ==
    claude-code # Claude CLI
    codex # OpenAI Codex CLI

    # == MCP servers ==
    mcp-nixos # NixOS MCP server
    nix-repository.mcp-language-server # generic MCP language server
    nix-repository.chrome-devtools-mcp # Chrome DevTools MCP
    nix-repository.climcp # CLI MCP
    nix-repository.kiri # code context extraction
    nix-repository.osgrep # OS-aware grep
    nix-repository.ccusage # Claude usage tracker
    nix-repository.ccusage-codex # Codex usage tracker
    nix-repository.ccusage-mcp # MCP usage tracker
    inputs.mcp-servers-nix.packages.${system}.mcp-server-filesystem # filesystem access MCP
    inputs.mcp-servers-nix.packages.${system}.serena # AI assistant MCP
    inputs.mcp-servers-nix.packages.${system}.context7-mcp # context management MCP

    # == Repository management ==
    nix-repository.gwq # ghq wrapper
    nix-repository.zz # directory jumper
  ];
}
