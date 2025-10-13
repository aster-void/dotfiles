{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Core utils
    lsof
    tree
    gnumake
    stow
    most
    platinum-searcher
    wget
    curl
    netcat-gnu
    openssh
    openssl
    dig

    # Core utils rebuilt
    fzf
    bat
    eza
    ripgrep

    # Extra utils
    xsel
    killall
    gettext
    nmap
    edid-decode
    avahi
    dex
    kdePackages.qttools
    upower
    upower-notify

    # Development
    postgresql
    tokei
    cargo-depgraph
    graphviz
    libnotify
    speedtest-cli
    helix

    # CLI/Terminal
    zellij
    bash
    fish
    zsh
    nushell
    bash-completion
    zsh-completions
    zsh-syntax-highlighting
    starship
    blesh

    # System info
    btop
    cpufetch
    fastfetch
    nitch
    baobab
    duf
    hwinfo
    lshw
    inxi
    hw-probe

    # CLI Apps
    git
    lazygit
    tig
    diff-so-fancy
    gitleaks
    gh
    ncdu

    # File utilities
    yazi
    zip
    unzip
    ffmpeg
    inotify-tools
    fsearch
    insync
    imagemagick
    inkscape

    # System utilities
    arandr
    volumeicon
    appimage-run
    filezilla
    networkmanagerapplet

    # service management
    cloudflared

    # Nix tools
    nix-index
    nixos-generators
    hydra-check
  ];
}
