{
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      accept-flake-config = true;
      auto-optimise-store = true;

      trusted-users = ["root" "aster"];
      trusted-substituters = [
        "https://hydra.nixos.org/"
        "https://helix.cachix.org/"
      ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
      dates = "daily";
    };
  };

  # Auto system update
  system.autoUpgrade = {
    enable = false;
  };
}
