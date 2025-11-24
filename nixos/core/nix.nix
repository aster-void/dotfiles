{
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      accept-flake-config = true;
      auto-optimise-store = false;

      trusted-users = ["root" "aster"];
      trusted-substituters = [
        "https://hydra.nixos.org/"
        "https://helix.cachix.org/"
      ];
    };

    # GC時にstoreを最適化
    optimise.automatic = true;

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
