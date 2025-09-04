{shared, ...}: {
  imports = [
    ../modules/hardware
    ../modules/flatpak.nix
    ../etc
    ../assertions.nix
    ../nix.nix
    ../services.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [];

  system.stateVersion = "24.05";

  # Common display manager settings that all hosts share
  services.displayManager.autoLogin.enable = false; # LY doesn't support auto login
  services.displayManager.autoLogin.user = shared.system.user;
}
