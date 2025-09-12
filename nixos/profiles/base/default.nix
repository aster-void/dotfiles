{
  pkgs,
  shared,
  meta,
  ...
}: {
  # Git設定
  programs.git = {
    enable = true;
    config = {
      user = {
        inherit (meta.git) email;
        name = meta.git.user;
      };
      core.editor = "hx";
      init.defaultBranch = "main";
      pull.rebase = "true";
      alias = shared.config.git.aliases;
    };
  };

  # SSH設定
  programs.ssh = {
    extraConfig = ''
      Host carbon.aster-void.dev
        ProxyCommand ${pkgs.lib.getExe' pkgs.cloudflared "cloudflared"} access ssh --hostname %h
        User root
    '';
  };

  # 基本パッケージ（インライン化）
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

    # Development
    postgresql
    tokei
    cargo-depgraph
    graphviz
    libnotify
    speedtest-cli

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

    # Nix tools
    nix-index
    nixos-generators
    hydra-check
  ];

  # シェルエイリアス
  environment.shellAliases = shared.config.mkShellAliases "bash";
}
