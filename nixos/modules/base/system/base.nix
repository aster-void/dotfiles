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

  # Enable SSH agent
  programs.ssh.startAgent = true;

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
  };

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Memory management - zram swap with aggressive swapping
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryMax = 64 * 1024 * 1024 * 1024; # 64 GiB
  };
  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    # Watchdog: auto-reboot on kernel hang
    "kernel.softlockup_panic" = 1;
    "kernel.hardlockup_panic" = 1;
    "kernel.panic" = 10; # reboot 10s after panic
  };

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
