{
  pkgs,
  inputs,
  ...
}: {
  # Core system packages
  environment.systemPackages = with pkgs; [
    # core utils
    coreutils-full
    bash
    fish
    curl
    ripgrep
    zellij
    jq

    # monitor & analyze
    btop
    ncdu
    macchina
    nushell
    bc
    inputs.nix-mc.packages.${pkgs.system}.nix-mc-cli
  ];

  # Enable comprehensive terminal support for SSH sessions
  environment.enableAllTerminfo = true;

  # Enable systemd for service management
  systemd.enableEmergencyMode = false;

  # Enable sudo for wheel group
  security.sudo.enable = true;

  # Enable fish shell
  programs.fish.enable = true;
  programs.zoxide.enable = true;

  # Nix configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  # Common keyboard configuration
  services.xserver.xkb = {
    layout = "us";
    variant = "workman";
    options = "caps:escape";
  };

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Memory management - zram swap with aggressive swapping
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
  boot.kernel.sysctl."vm.swappiness" = 180;

  # Locale settings
  # Language: English, Other formats (currency, time, etc.): Japanese
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  time.timeZone = "Asia/Tokyo";

  system.stateVersion = "26.05";
}
