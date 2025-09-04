{...}: {
  # Core NixOS system configuration
  system.stateVersion = "24.05";

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [];
  };

  # Nix daemon configuration
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };
}
